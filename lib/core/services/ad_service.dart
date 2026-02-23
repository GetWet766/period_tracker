import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

class AdService {
  AdService({
    required this.talker,
  });

  final Talker talker;

  /// Инициализация Yandex Mobile Ads
  Future<void> init() async {
    try {
      await MobileAds.initialize();
      talker.info('Yandex Mobile Ads initialized');
    } catch (e, st) {
      talker.error('Failed to initialize Yandex Mobile Ads', e, st);
    }
  }

  // ===========================================================================
  // 1. ПОЛНОЭКРАННАЯ РЕКЛАМА (МЕЖСТРАНИЧНАЯ / INTERSTITIAL)
  // ===========================================================================

  Future<void> showDefaultInterstitial() async {
    // Используем демо-блок, если ключ не найден
    final adUnitId =
        dotenv.env['YANDEX_ADS_INTERSTITIAL_ID'] ?? 'demo-interstitial-yandex';
    return showInterstitialAd(adUnitId);
  }

  Future<void> showInterstitialAd(String adUnitId) async {
    talker.info('Loading Interstitial Ad: $adUnitId');
    try {
      final loader = await InterstitialAdLoader.create(
        onAdLoaded: (ad) {
          talker.info('Interstitial Ad loaded');
          ad.setAdEventListener(
            eventListener: InterstitialAdEventListener(
              onAdShown: () => talker.info('Interstitial Ad shown'),
              onAdFailedToShow: (error) => talker.error(
                'Interstitial Ad failed to show: ${error.description}',
              ),
              onAdDismissed: () {
                talker.info('Interstitial Ad dismissed');
                ad.destroy();
              },
              onAdClicked: () => talker.info('Interstitial Ad clicked'),
              onAdImpression: (data) =>
                  talker.info('Interstitial Ad impression'),
            ),
          );
          ad.show(); // Показываем сразу после загрузки
        },
        onAdFailedToLoad: (error) {
          talker.error('Interstitial Ad failed to load: ${error.description}');
        },
      );

      await loader.loadAd(
        adRequestConfiguration: AdRequestConfiguration(adUnitId: adUnitId),
      );
    } catch (e, st) {
      talker.error('Error showing Interstitial Ad', e, st);
    }
  }

  // ===========================================================================
  // 2. РЕКЛАМА С ВОЗНАГРАЖДЕНИЕМ (REWARDED)
  // ===========================================================================

  Future<void> showDefaultRewarded({
    required void Function(Reward reward) onRewarded,
  }) async {
    final adUnitId =
        dotenv.env['YANDEX_ADS_REWARDED_ID'] ?? 'demo-rewarded-yandex';
    return showRewardedAd(adUnitId, onRewarded);
  }

  Future<void> showRewardedAd(
    String adUnitId,
    void Function(Reward reward) onRewarded,
  ) async {
    talker.info('Loading Rewarded Ad: $adUnitId');
    try {
      final loader = await RewardedAdLoader.create(
        onAdLoaded: (ad) {
          talker.info('Rewarded Ad loaded');
          ad.setAdEventListener(
            eventListener: RewardedAdEventListener(
              onAdShown: () => talker.info('Rewarded Ad shown'),
              onAdFailedToShow: (error) => talker.error(
                'Rewarded Ad failed to show: ${error.description}',
              ),
              onAdDismissed: () {
                talker.info('Rewarded Ad dismissed');
                ad.destroy();
              },
              onAdClicked: () => talker.info('Rewarded Ad clicked'),
              onAdImpression: (data) => talker.info('Rewarded Ad impression'),
              onRewarded: (reward) {
                talker.info('Rewarded: ${reward.amount} ${reward.type}');
                onRewarded(reward);
              },
            ),
          );
          ad.show();
        },
        onAdFailedToLoad: (error) {
          talker.error('Rewarded Ad failed to load: ${error.description}');
        },
      );

      await loader.loadAd(
        adRequestConfiguration: AdRequestConfiguration(adUnitId: adUnitId),
      );
    } catch (e, st) {
      talker.error('Error showing Rewarded Ad', e, st);
    }
  }

  // ===========================================================================
  // 3. РЕКЛАМА ПРИ ОТКРЫТИИ ПРИЛОЖЕНИЯ (APP OPEN AD)
  // ===========================================================================

  Future<void> showDefaultAppOpenAd() async {
    final adUnitId =
        dotenv.env['YANDEX_ADS_APP_OPEN_ID'] ?? 'demo-appopenad-yandex';
    return showAppOpenAd(adUnitId);
  }

  Future<void> showAppOpenAd(String adUnitId) async {
    talker.info('Loading App Open Ad: $adUnitId');
    try {
      final loader = await AppOpenAdLoader.create(
        onAdLoaded: (ad) {
          talker.info('App Open Ad loaded');
          ad.setAdEventListener(
            eventListener: AppOpenAdEventListener(
              onAdShown: () => talker.info('App Open Ad shown'),
              onAdFailedToShow: (error) => talker.error(
                'App Open Ad failed to show: ${error.description}',
              ),
              onAdDismissed: () {
                talker.info('App Open Ad dismissed');
                ad.destroy();
              },
              onAdClicked: () => talker.info('App Open Ad clicked'),
              onAdImpression: (data) => talker.info('App Open Ad impression'),
            ),
          );
          ad.show();
        },
        onAdFailedToLoad: (error) {
          talker.error('App Open Ad failed to load: ${error.description}');
        },
      );

      await loader.loadAd(
        adRequestConfiguration: AdRequestConfiguration(adUnitId: adUnitId),
      );
    } catch (e, st) {
      talker.error('Error showing App Open Ad', e, st);
    }
  }

  // ===========================================================================
  // 4. ДОСТУП К ID ДЛЯ ВСТРАИВАЕМЫХ ВИДЖЕТОВ (BANNER / NATIVE)
  // Эти методы используются внутри виджетов, например, внутри AppBannerAd
  // ===========================================================================

  String getDefaultBannerId() {
    return dotenv.env['YANDEX_ADS_BANNER_ID'] ?? 'demo-banner-yandex';
  }

  String getDefaultNativeId() {
    return dotenv.env['YANDEX_ADS_NATIVE_ID'] ?? 'demo-nativeapp-yandex';
  }
}
