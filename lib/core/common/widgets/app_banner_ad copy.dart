import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:periodility/core/dependencies/injection.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

class AppBannerAd extends StatefulWidget {
  const AppBannerAd({
    super.key,
    this.width,
    this.height = 80,
  });

  final double? width;
  final double height;

  @override
  State<AppBannerAd> createState() => _AppBannerAdState();
}

class _AppBannerAdState extends State<AppBannerAd> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;
  final Talker _talker = sl<Talker>();

  double? _loadedWidth;

  @override
  void dispose() {
    unawaited(_bannerAd?.destroy());
    super.dispose();
  }

  void _loadAd(double width) {
    const adUnitId = 'demo-banner-yandex';
    // const adUnitId = dotenv.get('YANDEX_ADS_BANNER_ID');

    _talker.info('Loading Banner Ad: $adUnitId for width: $width');

    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      adSize: BannerAdSize.inline(
        width: width.round(),
        maxHeight: widget.height.round(),
      ),
      adRequest: const AdRequest(),
      onAdLoaded: () async {
        _talker.info('Banner Ad loaded');
        if (mounted) {
          setState(() {
            _isAdLoaded = true;
          });
        } else {
          await _bannerAd?.destroy();
        }
      },
      onAdFailedToLoad: (error) {
        _talker.error('Banner Ad failed to load: ${error.description}');
        if (mounted) {
          setState(() {
            _isAdLoaded = false;
          });
        }
      },
    );

    unawaited(_bannerAd!.loadAd());
    _loadedWidth = width;
  }

  @override
  Widget build(BuildContext context) {
    // Используем LayoutBuilder, чтобы получить доступную ширину от родителя
    return LayoutBuilder(
      builder: (context, constraints) {
        // Определяем ширину: либо переданная в виджет, либо максимальная доступная от родителя
        final availableWidth = widget.width ?? constraints.maxWidth;

        // Если ширина изменилась или реклама еще не загружалась - инициализируем её
        if (_bannerAd == null || _loadedWidth != availableWidth) {
          // Если реклама уже была, но ширина изменилась (например, поворот экрана),
          // уничтожаем старую перед созданием новой
          unawaited(_bannerAd?.destroy());
          _bannerAd = null;
          _isAdLoaded = false;

          // Откладываем вызов setState и загрузку рекламы на следующий фрейм,
          // чтобы не вызвать ошибку "setState() or markNeedsBuild() called during build"
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _loadAd(availableWidth);
            }
          });
        }

        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          width: availableWidth,
          height: widget.height,
          child: _isAdLoaded && _bannerAd != null
              ? AdWidget(bannerAd: _bannerAd!)
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
