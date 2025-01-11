part of 'package:kiki/app/walk_through/home/view/home_view/screen/home_screen.dart';
//
// class _AdmobBanner extends StatefulWidget {
//   const _AdmobBanner({super.key});
//
//   @override
//   State<_AdmobBanner> createState() => _AdmobBannerState();
// }
//
// class _AdmobBannerState extends State<_AdmobBanner> {
//   bool isOnException = false;
//   bool isOnLoading = true;
//
//   final BannerAd _banner = BannerAd(
//     listener: BannerAdListener(
//       onAdLoaded: (Ad ad) {},
//       onAdFailedToLoad: (Ad ad, LoadAdError error) {},
//     ),
//     size: AdSize.banner,
//     adUnitId: getIt<IConfig>().banner1Id,
//     request: const AdRequest(),
//   )..load();
//
//   @override
//   void dispose() {
//     _banner.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: _banner.size.height.toDouble(),
//       child: AdWidget(
//         ad: _banner,
//       ),
//     );
//   }
// }
