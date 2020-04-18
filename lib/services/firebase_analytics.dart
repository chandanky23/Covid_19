import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = new FirebaseAnalytics();

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      new FirebaseAnalyticsObserver(analytics: _analytics);

  Future getCurrentPage(
      {@required String page, String pageToOverride}) async {
    await _analytics.setCurrentScreen(
        screenName: page, screenClassOverride: pageToOverride);
  }
}
