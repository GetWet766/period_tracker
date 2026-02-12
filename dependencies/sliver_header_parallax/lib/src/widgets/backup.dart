import 'dart:math' as math;

import 'package:flutter/material.dart';

class HeaderParallaxUtils {
  HeaderParallaxUtils({
    required this.mounted,
    required this.context,
    required this.scrollController,
    required this.minHeight,
    required this.midHeightPercent,
    required this.maxHeightPercent,
    this.excludeSize,
  });

  final bool mounted;
  final BuildContext context;
  final ScrollController scrollController;
  final double minHeight;
  final double midHeightPercent;
  final double maxHeightPercent;
  final double? excludeSize;

  double get _screenHeight =>
      MediaQuery.sizeOf(context).height - (excludeSize ?? 0);

  double get midHeight => _screenHeight * midHeightPercent;

  double get maxHeight =>
      (_screenHeight - (excludeSize ?? 0)) * maxHeightPercent;

  void jumpToMidHeight() {
    if (!scrollController.hasClients) return;

    // Сразу скроллим к точке, где хедер визуально равен midHeight
    final double midScrollOffset = maxHeight - midHeight;
    scrollController.jumpTo(midScrollOffset);
  }

  void snapListener() {
    if (!scrollController.position.isScrollingNotifier.value) {
      checkAndSnap();
    }
  }

  void checkAndSnap() {
    if (!mounted || !scrollController.hasClients) return;

    final double offset = scrollController.offset;
    final double midOffset = maxHeight - midHeight;
    final double maxOffset = maxHeight - minHeight;

    double targetOffset = offset;

    print("$offset | ${midOffset * .3}");

    if (offset < midOffset) {
      const double openThreshold = .5;

      if (offset < midOffset * openThreshold) {
        targetOffset = 0.0; // Открыть полностью (мы очень близко к верху)
      } else {
        targetOffset = midOffset; // Вернуть на середину (не дотянули)
      }
    } else if (offset < maxOffset) {
      final double progress = offset - midOffset;

      final double range = maxOffset - midOffset;

      // Тут стандартно: перешли половину - сворачиваем, нет - возвращаем.

      if (progress < range / 2) {
        targetOffset = midOffset;
      } else {
        targetOffset = maxOffset;
      }
    } else {
      // Уже свернут и скроллим дальше контент

      return;
    }

    // Запуск анимации, если нужно сдвинуться

    if ((offset - targetOffset).abs() > 1.0) {
      scrollController.animateTo(
        targetOffset,

        duration: const Duration(
          milliseconds: 300,
        ), // Можно сделать быстрее, например 250

        curve: Curves.easeOutCubic, // Плавная кривая возврата
      );
    }
  }
}

class SliverHeaderParallax extends StatelessWidget {
  const SliverHeaderParallax({
    required this.minHeight,

    required this.midHeight,

    required this.maxHeight,

    required this.child,

    super.key,
  });

  final double minHeight;

  final double midHeight;

  final double maxHeight;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // В этой версии мы всегда говорим сливеру, что его размер - maxHeight.

    // Эффект "середины" достигается за счет прокрутки.

    return SliverPersistentHeader(
      delegate: _ParallaxHeaderDelegate(
        minHeight: minHeight,

        midHeight: midHeight,

        maxHeight: maxHeight,

        child: child,
      ),
    );
  }
}

class _ParallaxHeaderDelegate extends SliverPersistentHeaderDelegate {
  _ParallaxHeaderDelegate({
    required this.minHeight,

    required this.midHeight,

    required this.maxHeight,

    required this.child,
  });

  final double minHeight;

  final double midHeight;

  final double maxHeight;

  final Widget child;

  @override
  Widget build(
    BuildContext context,

    double shrinkOffset,

    bool overlapsContent,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxHeight < 1) {
          return const SizedBox.shrink();
        }

        final double currentHeight = constraints.maxHeight;

        final double contentHeight = math
            .max(currentHeight, maxHeight)
            .ceilToDouble();

        return Stack(
          fit: StackFit.passthrough,

          children: [
            Positioned(
              top: 0,

              left: 0,

              right: 0,

              bottom: 0,

              child: ClipRect(
                child: OverflowBox(
                  minHeight: contentHeight,

                  maxHeight: contentHeight,

                  alignment: Alignment.topCenter,

                  child: Transform.translate(
                    // Параллакс эффект: половина скорости скролла
                    offset: Offset(0, -shrinkOffset * 0.25),

                    child: SizedBox(
                      height: contentHeight,

                      width: constraints.maxWidth,

                      child: Center(child: child),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  double get maxExtent => maxHeight; // ВСЕГДА MaxHeight

  @override
  double get minExtent => minHeight;

  // Stretch конфигурация больше не нужна, так как BouncingScrollPhysics

  // будет сам растягивать контент, когда мы тянем вниз от 0-го оффсета.

  @override
  bool shouldRebuild(covariant _ParallaxHeaderDelegate oldDelegate) {
    return midHeight != oldDelegate.midHeight ||
        minHeight != oldDelegate.minExtent ||
        maxHeight != oldDelegate.maxHeight ||
        child != oldDelegate.child;
  }
}

class TensionScrollPhysics extends BouncingScrollPhysics {
  const TensionScrollPhysics({
    required this.frictionStartOffset,

    this.tensionFactor = 0.3,

    super.parent,
  });

  final double frictionStartOffset; // Точка MidHeight (смещение)

  final double tensionFactor;

  @override
  TensionScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return TensionScrollPhysics(
      frictionStartOffset: frictionStartOffset,

      tensionFactor: tensionFactor,

      parent: buildParent(ancestor),
    );
  }

  // 1. DRAG (Тянем пальцем)

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    if (position.pixels < frictionStartOffset) {
      // Если тянем вниз (раскрываем), применяем силу трения

      if (offset > 0) {
        return super.applyPhysicsToUserOffset(position, offset * tensionFactor);
      }
    }

    return super.applyPhysicsToUserOffset(position, offset);
  }

  // 2. BALLISTIC (Отпустили палец с инерцией)

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,

    double velocity,
  ) {
    if (velocity < 0) {
      // Если "случайный отрыв пальца" (слабая скорость),

      // то возвращаем обратно к середине, не даем открыться.

      return ScrollSpringSimulation(
        spring,

        position.pixels,

        frictionStartOffset, // Возврат к MidHeight

        velocity,

        tolerance: toleranceFor(position),
      );
    }

    // Мы находимся в верхней зоне (между Max и Mid)

    if (position.pixels < frictionStartOffset) {
      // СЦЕНАРИЙ: Скролл летит ВНИЗ (Velocity > 0) -> Сворачивание хедера

      if (velocity > 0) {
        // Тут оставляем как есть: стремимся к MidHeight

        return ScrollSpringSimulation(
          spring,

          position.pixels,

          frictionStartOffset,

          velocity,

          tolerance: toleranceFor(position),
        );
      }
    }

    // Во всех остальных случаях - стандартная физика

    return super.createBallisticSimulation(position, velocity);
  }
}
