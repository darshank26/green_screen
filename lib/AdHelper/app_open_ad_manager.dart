//
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'dart:io' show Platform;
//
// /// Utility class that manages loading and showing app open ads.
// class AppOpenAdManager {
//   /// Maximum duration allowed between loading and showing the ad.
//   final Duration maxCacheDuration = Duration(hours: 4);
//
//   /// Keep track of load time so we don't show an expired ad.
//   DateTime? _appOpenLoadTime;
//
//   AppOpenAd? _appOpenAd;
//   bool _isShowingAd = false;
//
//   String adUnitId = Platform.isAndroid
//       ? 'ca-app-pub-2180535035689124/7738149900'
//       : 'ca-app-pub-2180535035689124/7738149900';
//
//   /// Load an [AppOpenAd].
//   void loadAd() {
//     AppOpenAd.load(
//       adUnitId: adUnitId,
//       orientation: AppOpenAd.orientationPortrait,
//       request: AdRequest(),
//       adLoadCallback: AppOpenAdLoadCallback(
//         onAdLoaded: (ad) {
//           print('$ad loaded');
//           _appOpenLoadTime = DateTime.now();
//           _appOpenAd = ad;
//         },
//         onAdFailedToLoad: (error) {
//           print('AppOpenAd failed to load: $error');
//         },
//       ),
//     );
//   }
//
//   /// Whether an ad is available to be shown.
//   bool get isAdAvailable {
//     return _appOpenAd != null;
//   }
//
//   /// Shows the ad, if one exists and is not already being shown.
//   ///
//   /// If the previously cached ad has expired, this just loads and caches a
//   /// new ad.
//   void showAdIfAvailable() {
//     if (!isAdAvailable) {
//       print('Tried to show ad before available.');
//       loadAd();
//       return;
//     }
//     if (_isShowingAd) {
//       print('Tried to show ad while already showing an ad.');
//       return;
//     }
//     if (DateTime.now().subtract(maxCacheDuration).isAfter(_appOpenLoadTime!)) {
//       print('Maximum cache duration exceeded. Loading another ad.');
//       _appOpenAd!.dispose();
//       _appOpenAd = null;
//       loadAd();
//       return;
//     }
//     // Set the fullScreenContentCallback and show the ad.
//     _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (ad) {
//         _isShowingAd = true;
//         print('$ad onAdShowedFullScreenContent');
//       },
//       onAdFailedToShowFullScreenContent: (ad, error) {
//         print('$ad onAdFailedToShowFullScreenContent: $error');
//         _isShowingAd = false;
//         ad.dispose();
//         _appOpenAd = null;
//       },
//       onAdDismissedFullScreenContent: (ad) {
//         print('$ad onAdDismissedFullScreenContent');
//         _isShowingAd = false;
//         ad.dispose();
//         _appOpenAd = null;
//         loadAd();
//       },
//     );
//     _appOpenAd!.show();
//   }
// }