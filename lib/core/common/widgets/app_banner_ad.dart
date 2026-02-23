import 'dart:async';
import 'package:flutter/material.dart';
import 'package:periodility/core/dependencies/injection.dart';
import 'package:periodility/core/services/ad_service.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

class AppBannerAd extends StatefulWidget {
  const AppBannerAd({
    super.key,
    // Теперь width и height можно не передавать,
    // виджет сам подстроится под родителя.
    // Но оставим дефолтную высоту на случай бесконечных ограничений (например, в Column)
    this.defaultHeight = 80,
  });

  final double defaultHeight;

  @override
  State<AppBannerAd> createState() => _AppBannerAdState();
}

class _AppBannerAdState extends State<AppBannerAd> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;
  bool _isAdLoading = false;

  final Talker _talker = sl<Talker>();
  final AdService _adService = sl<AdService>();

  void _loadAd(double width, double height) {
    if (_isAdLoading) return;
    _isAdLoading = true;

    // Получаем ID баннера из нашего сервиса
    final adUnitId = _adService.getDefaultBannerId();
    _talker.info(
      'Loading Banner Ad: $adUnitId (Size: ${width.round()}x${height.round()})',
    );

    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      adSize: BannerAdSize.inline(
        width: width.round(),
        maxHeight: height.round(),
      ),
      adRequest: const AdRequest(),
      onAdLoaded: () {
        _talker.info('Banner Ad loaded successfully');
        if (mounted) {
          setState(() {
            _isAdLoaded = true;
          });
        }
      },
      onAdFailedToLoad: (error) {
        _talker.error(
          'Banner Ad failed to load: ${error.description}',
        );
        if (mounted) {
          setState(() {
            _isAdLoaded = false;
            _isAdLoading = false;
          });
        }
      },
    );

    // Запускаем загрузку рекламы
    _bannerAd!.loadAd();
  }

  @override
  void dispose() {
    unawaited(_bannerAd?.destroy());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 1. Вычисляем доступную ширину.
        // Если родитель не ограничивает ширину (например, внутри Row), берем ширину экрана.
        final double adWidth = constraints.hasBoundedWidth
            ? constraints.maxWidth
            : MediaQuery.of(context).size.width;

        // 2. Вычисляем доступную высоту.
        // Если родитель не ограничивает высоту (например, внутри ListView/Column), берем defaultHeight.
        final double adHeight = constraints.hasBoundedHeight
            ? constraints.maxHeight
            : widget.defaultHeight;

        // 3. Инициализируем рекламу только один раз, когда узнали размеры
        if (_bannerAd == null && !_isAdLoading) {
          // Используем addPostFrameCallback, чтобы избежать ошибки
          // "setState() called during build" при инициализации
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _loadAd(adWidth, adHeight);
            }
          });
        }

        // Если реклама еще не загружена, возвращаем пустой контейнер тех же размеров,
        // чтобы UI не "прыгал" после загрузки рекламы.
        return Offstage(
          offstage: !_isAdLoaded,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            width: adWidth,
            height: adHeight,
            // Добавляем AdWidget только если _bannerAd уже создан
            child: _bannerAd != null
                ? AdWidget(bannerAd: _bannerAd!)
                : const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
