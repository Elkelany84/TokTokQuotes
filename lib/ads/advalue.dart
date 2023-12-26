import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:toktok_quote/ads/ad_helper.dart';

class Advalue extends StatefulWidget {
  const Advalue({Key? key}) : super(key: key);

  @override
  _AdvalueState createState() => _AdvalueState();
}

class _AdvalueState extends State<Advalue> {
  BannerAd? _ad;
  bool? isLoaded;
  bool checkval = false;

  @override
  void initState() {
    super.initState();

    // setData();
    // _content(context);
    _ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(onAdLoaded: (_) {
        // isLoaded = true;
        setState(() {
          isLoaded = true;
        });
      }, onAdFailedToLoad: (_, error) {
        print('Ad failed to load with error: $error');
      }),
    );
    _ad!.load();
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  Widget checkForAd() {
    if (isLoaded == true) {
      return Container(
        width: _ad!.size.width.toDouble(),
        height: _ad!.size.height.toDouble(),
        alignment: Alignment.center,
        child: AdWidget(ad: _ad!),
      );
    } else {
      return const CircularProgressIndicator(
          color: Color.fromRGBO(202, 249, 243, 0.9));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: checkForAd(),
    );
  }
}
