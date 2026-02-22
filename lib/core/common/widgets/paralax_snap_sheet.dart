import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:periodility/core/common/widgets/block_container.dart';
import 'package:periodility/core/common/widgets/sliver_fill_overscroll.dart';

class ParallaxSnapSheet extends StatefulWidget {
  const ParallaxSnapSheet({
    required this.backgroundContent,
    required this.sheetContent,
    this.radius = 28,
    this.sliverAppBar,
    this.appBarHeight,
    this.minVisibleSheetHeight = 60.0,
    this.backgroundColor,
    this.sheetColor,
    this.dragHandle,
    this.bottomSliver,
    this.enableMinSnap = false,
    super.key,
  });

  /// Радиус скругления шторки
  final double radius;

  /// Контент, который находится на заднем плане (в дырке)
  final Widget backgroundContent;

  /// Контент самой шторки (список, грид и т.д.)
  final Widget sheetContent;

  /// Sliver-виджет для AppBar (например, TrackerAppBar или SliverAppBar).
  /// Если не передан, будет использовано пустое пространство.
  final Widget? sliverAppBar;

  /// Высота AppBar. По умолчанию рассчитывается как kToolbarHeight + SafeArea top.
  /// Нужно для правильного расчета отступов.
  final double? appBarHeight;

  /// Минимально видимая часть шторки, когда она закрыта
  final double minVisibleSheetHeight;

  /// Цвет фона под задним контентом
  final Color? backgroundColor;

  /// Цвет фона самой шторки
  final Color? sheetColor;

  /// Виджет "ручки" (drag handle) на шторке
  final Widget? dragHandle;

  /// Дополнительные Sliver-виджеты в конец скролла (например, SliverFillOverscroll)
  final Widget? bottomSliver;

  /// Разрешает ли шторке смахиваться в самый низ (до minVisibleSheetHeight).
  /// Если false, минимальным положением будет высота фонового контента.
  final bool enableMinSnap;

  @override
  State<ParallaxSnapSheet> createState() => _ParallaxSnapSheetState();
}

class _ParallaxSnapSheetState extends State<ParallaxSnapSheet> {
  final ScrollController _scrollController = ScrollController();

  double _topContainerHeight = 0;
  double _scrollOffset = 0;
  double _availableHeight = 0;

  bool _isCalculated = false;
  bool _hasInitialScrolled = false;
  bool _isAnimatingToSnap = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onBackgroundSizeChanged(Size size) {
    if (!mounted) return;

    // Игнорируем микро-изменения
    if ((_topContainerHeight - size.height).abs() < 1.0) {
      return;
    }

    final oldHeight = _topContainerHeight;
    final newHeight = size.height;
    final heightDifference = newHeight - oldHeight;

    setState(() {
      _topContainerHeight = newHeight;
      _isCalculated = true;
    });

    if (_availableHeight <= 0 || !_scrollController.hasClients) return;

    final maxHoleHeight = _availableHeight - widget.minVisibleSheetHeight;
    final newSnapMiddle = (maxHoleHeight - newHeight).clamp(
      0.0,
      double.infinity,
    );

    // 1. Если это самый первый расчет размеров
    if (!_hasInitialScrolled) {
      _hasInitialScrolled = true;
      _scrollController.jumpTo(newSnapMiddle);
      setState(() {
        _scrollOffset = newSnapMiddle;
      });
      return;
    }

    // 2. Если размер изменился УЖЕ после первого рендера,
    // нам нужно скорректировать скролл, чтобы контент не прыгал.
    // Если мы находились в состоянии покоя под контентом (около старого snapMiddle),
    // двигаем скролл вслед за изменением размера.
    final oldSnapMiddle = (maxHoleHeight - oldHeight).clamp(
      0.0,
      double.infinity,
    );

    // Проверяем, была ли шторка "прилеплена" к контенту
    // (с небольшой погрешностью на анимации)
    if ((_scrollOffset - oldSnapMiddle).abs() < 5.0) {
      _scrollController.jumpTo(newSnapMiddle);
      setState(() {
        _scrollOffset = newSnapMiddle;
      });
    } else if (_scrollOffset > oldSnapMiddle) {
      // Если шторка была натянута выше (пользователь скроллил вниз),
      // нужно компенсировать разницу, чтобы скролл не дернулся.
      final correctedOffset = (_scrollOffset - heightDifference).clamp(
        0.0,
        double.infinity,
      );
      _scrollController.jumpTo(correctedOffset);
      setState(() {
        _scrollOffset = correctedOffset;
      });
    }
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      setState(() {
        _scrollOffset = notification.metrics.pixels.clamp(0.0, double.infinity);
      });
    }

    if (notification is ScrollEndNotification && !_isAnimatingToSnap) {
      if (!_isCalculated || _topContainerHeight == 0 || _availableHeight == 0) {
        return false;
      }

      final maxHoleHeight = _availableHeight - widget.minVisibleSheetHeight;

      const double snapBottom = 0;
      final double snapMiddle = (maxHoleHeight - _topContainerHeight).clamp(
        0.0,
        double.infinity,
      );
      final double snapTop = maxHoleHeight;

      final double currentOffset = _scrollController.offset;
      final double velocity = notification.dragDetails?.primaryVelocity ?? 0.0;

      Future.microtask(() async {
        if (!_scrollController.hasClients) return;
        double? target;

        // --- ЛОГИКА 1: Верхняя половина (между Middle и Top) ---
        if (currentOffset > snapMiddle && currentOffset <= snapTop) {
          if (velocity > 500) {
            target = snapMiddle;
          } else {
            final middlePoint = snapMiddle + (snapTop - snapMiddle) / 2;
            target = currentOffset < middlePoint ? snapMiddle : snapTop;
          }
        }
        // --- ЛОГИКА 2: Нижняя половина (между Bottom и Middle) ---
        else if (currentOffset > snapBottom && currentOffset <= snapMiddle) {
          if (widget.enableMinSnap) {
            final threshold = snapBottom + (snapMiddle - snapBottom) * 0.3;
            if (currentOffset < threshold || velocity > 1000) {
              target = snapBottom;
            } else {
              target = snapMiddle;
            }
          } else {
            target = snapMiddle;
          }
        }

        // Анимируем к цели
        if (target != null && (target - currentOffset).abs() > 1.0) {
          _isAnimatingToSnap = true;
          await _scrollController.animateTo(
            target,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutCubic,
          );
          _isAnimatingToSnap = false;
        }
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final double appBarHeight =
        widget.appBarHeight ??
        (MediaQuery.of(context).padding.top + kToolbarHeight);

    return LayoutBuilder(
      builder: (context, constraints) {
        _availableHeight = constraints.maxHeight - appBarHeight;
        if (_availableHeight < 0) _availableHeight = 0;

        final double maxHoleHeight =
            (_availableHeight - widget.minVisibleSheetHeight).clamp(
              0.0,
              double.infinity,
            );

        double parallaxOffset = 0;
        double snapMiddle = 0;

        if (_isCalculated) {
          snapMiddle = (maxHoleHeight - _topContainerHeight).clamp(
            0.0,
            double.infinity,
          );

          if (_scrollOffset > snapMiddle) {
            parallaxOffset = (_scrollOffset - snapMiddle) * 0.5;
          } else {
            parallaxOffset = _scrollOffset - snapMiddle;
          }
        }

        final ScrollPhysics scrollPhysics =
            widget.enableMinSnap || !_isCalculated
            ? const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              )
            : MinOffsetScrollPhysics(
                minOffset: snapMiddle,
                parent: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
              );

        return AnimatedOpacity(
          opacity: _hasInitialScrolled ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 150),
          child: NotificationListener<ScrollNotification>(
            onNotification: _onScrollNotification,
            child: CustomScrollView(
              controller: _scrollController,
              physics: scrollPhysics,
              slivers: [
                if (widget.sliverAppBar != null) widget.sliverAppBar!,

                // "ДЫРКА" С ФОНОВЫМ КОНТЕНТОМ
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: _isCalculated ? maxHoleHeight : _availableHeight,
                    child: ClipRect(
                      child: Transform.translate(
                        offset: Offset(0, parallaxOffset),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: MeasureSize(
                            onChange: _onBackgroundSizeChanged,
                            child: SizedBox(
                              width: double.infinity,
                              child: widget.backgroundContent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // ШТОРКА
                SliverToBoxAdapter(
                  child: BlockContainer(
                    borderRadius: .vertical(top: .circular(widget.radius)),
                    constraints: BoxConstraints(
                      minHeight: _availableHeight,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (widget.dragHandle != null) widget.dragHandle!,
                        widget.sheetContent,
                      ],
                    ),
                  ),
                ),

                if (widget.bottomSliver != null) widget.bottomSliver!,
                SliverFillOverscroll(
                  child: ColoredBox(
                    color: widget.sheetColor ?? colorScheme.surface,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DragHandle extends StatelessWidget {
  const DragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Center(
          child: Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// ============================================================================
// ВСПОМОГАТЕЛЬНЫЕ КЛАССЫ ДЛЯ ОТСЛЕЖИВАНИЯ ИЗМЕНЕНИЯ РАЗМЕРА ВИДЖЕТА
// ============================================================================

typedef OnWidgetSizeChange = void Function(Size size);

/// Виджет, который вызывает [onChange] при изменении своего размера.
class MeasureSize extends SingleChildRenderObjectWidget {
  const MeasureSize({
    required this.onChange,
    required super.child,
    super.key,
  });
  final OnWidgetSizeChange onChange;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _MeasureSizeRenderObject(onChange);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _MeasureSizeRenderObject renderObject,
  ) {
    renderObject.onChange = onChange;
  }
}

class _MeasureSizeRenderObject extends RenderProxyBox {
  _MeasureSizeRenderObject(this.onChange);
  Size? oldSize;
  OnWidgetSizeChange onChange;

  @override
  void performLayout() {
    super.performLayout();

    final newSize = child?.size ?? Size.zero;
    if (oldSize == newSize) return;

    oldSize = newSize;
    // Оборачиваем коллбэк в microtask, чтобы не вызывать setState во время layout
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}

// ============================================================================
// КАСТОМНАЯ ФИЗИКА ДЛЯ ОГРАНИЧЕНИЯ СКРОЛЛА
// ============================================================================

class MinOffsetScrollPhysics extends ScrollPhysics {
  const MinOffsetScrollPhysics({
    required this.minOffset,
    super.parent,
  });
  final double minOffset;

  @override
  MinOffsetScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return MinOffsetScrollPhysics(
      minOffset: minOffset,
      parent: buildParent(ancestor),
    );
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    // Если пользователь пытается тянуть вверх (offset > 0 значит скролл идет вниз к началу списка),
    // и мы уже на границе minOffset, режем offset, чтобы шторка не тянулась ниже.
    if (position.pixels <= minOffset && offset > 0) {
      return 0;
    }
    // Плавно гасим оттяжку, если пользователь уже перетянул границу
    if (position.pixels - offset < minOffset && offset > 0) {
      return position.pixels - minOffset;
    }
    return super.applyPhysicsToUserOffset(position, offset);
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    // Жестко запрещаем скроллу уходить ниже minOffset
    if (value < minOffset && position.pixels <= minOffset) {
      return value - position.pixels;
    }
    if (value < minOffset && position.pixels > minOffset) {
      return value - minOffset;
    }
    return super.applyBoundaryConditions(position, value);
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    // Если по какой-то причине оказались ниже minOffset, пружиним обратно
    if (position.pixels < minOffset) {
      return ScrollSpringSimulation(
        spring,
        position.pixels,
        minOffset,
        velocity,
        tolerance: tolerance,
      );
    }
    return super.createBallisticSimulation(position, velocity);
  }
}
