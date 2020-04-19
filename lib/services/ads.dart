import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

const String testDevice = 'Mobile_id';

const adkeywords = <String>[
  'covid',
  'health',
  'symtoms',
  'masks',
  'who',
  'covid-19',
  'sars-cov-2',
  'stay home'
];

class Ads {
  static bool _isShowingAds = false;
  static bool _isGoingToBeShown = false;
  static BannerAd _bannerAd;

  static void initialize() {
    FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-5369694228287577~8362379320');
  }

  static MobileAdTargetingInfo _getMobileAdTargetingInfo() {
    return MobileAdTargetingInfo(
        testDevices: testDevice != null ? <String>[testDevice] : null,
        keywords: adkeywords,
        nonPersonalizedAds: true,
        childDirected: true);
  }

  static void setBannerAd() {
    _bannerAd = BannerAd(
        adUnitId: 'ca-app-pub-5369694228287577/5125895799',
        size: AdSize.banner,
        targetingInfo: _getMobileAdTargetingInfo(),
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.loaded) {
            _isShowingAds = true;
            _isGoingToBeShown = false;
          } else if (event == MobileAdEvent.failedToLoad) {
            _isShowingAds = false;
            _isGoingToBeShown = false;
          }
          print("Banner event: $event");
        });
  }

  static void showBannerAd([State state]) {
    if (state != null && !state.mounted) return;
    if (_bannerAd == null) setBannerAd();
    if (!_isShowingAds && !_isGoingToBeShown) {
      _isGoingToBeShown = true;
      _bannerAd
        ..load()
        ..show(anchorOffset: 60.0, anchorType: AnchorType.bottom);
    }
  }

  static void hideBannerAd() {
    if (_bannerAd != null && !_isGoingToBeShown) {
      _bannerAd.dispose().then((disposed) {
        _isShowingAds = !disposed;
      });
      _bannerAd = null;
    }
  }

  static void showIntertitialAd() {
    var intertitialAd = InterstitialAd(
        adUnitId: 'ca-app-pub-5369694228287577/2986763719',
        targetingInfo: _getMobileAdTargetingInfo(),
        listener: (MobileAdEvent event) {
          print('Intertitial event: $event');
        });
    intertitialAd
      ..load()
      ..show(anchorOffset: 0.0, anchorType: AnchorType.bottom);
  }
}
