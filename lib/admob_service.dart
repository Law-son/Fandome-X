import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobService {
  static String get bannerAdUnitID1 => 'ca-app-pub-7474941424456306/8320498676';
  static String get bannerAdUnitID2 => 'ca-app-pub-7474941424456306/4741481783';
  static String get bannerAdUnitID3 => 'ca-app-pub-7474941424456306/7120233119';

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-7474941424456306/9143761227";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/5135589807";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
  
  static String get interstitialAdUnitId1 {
    if (Platform.isAndroid) {
      return "ca-app-pub-7474941424456306/4521989935";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/5135589807";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId2 {
    if (Platform.isAndroid) {
      return "ca-app-pub-7474941424456306/6326026195";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/5135589807";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static initialize() {
    // ignore: unnecessary_null_comparison
    if (MobileAds.instance == null) {
      MobileAds.instance.initialize();
    }
  }

  static BannerAd createBannerAd() {
    BannerAd ad = new BannerAd(
        size: AdSize.banner,
        adUnitId: bannerAdUnitID1,
        listener:
            BannerAdListener(onAdFailedToLoad: (Ad ad, LoadAdError error) {}),
        request: AdRequest());
    return ad;
  }

  static BannerAd createBannerAd1() {
    BannerAd ad = new BannerAd(
        size: AdSize.banner,
        adUnitId: bannerAdUnitID1,
        listener:
            BannerAdListener(onAdFailedToLoad: (Ad ad, LoadAdError error) {}),
        request: AdRequest());
    return ad;
  }

  static BannerAd createBannerAd2() {
    BannerAd ad = new BannerAd(
        size: AdSize.banner,
        adUnitId: bannerAdUnitID1,
        listener:
            BannerAdListener(onAdFailedToLoad: (Ad ad, LoadAdError error) {}),
        request: AdRequest());
    return ad;
  }

}
