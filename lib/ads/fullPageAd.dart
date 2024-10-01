import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:toktok_quote/showsaved.dart';

class FullPageAd extends StatefulWidget {
  const FullPageAd({Key? key}) : super(key: key);

  @override
  State<FullPageAd> createState() => _FullPageAdState();
}

class _FullPageAdState extends State<FullPageAd> {
  late InterstitialAd ad;

  bool isLoaded = false;
  @override
  void initState() {
    initAd();
    super.initState();
  }

  void initAd() {
    InterstitialAd.load(
        adUnitId: "ca-app-pub-3940256099942544/1033173712",
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (rAd) {
          ad = rAd;
          setState(() {
            isLoaded = true;
          });
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            ad.dispose();
            setState(() {
              isLoaded = false;
            });
            //do what you want after ad is dismissed
            print('AD is Dismissed');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ShowSaved()),
            );
          }, onAdFailedToShowFullScreenContent: (ad, error) {
            ad.dispose();
          });
        }, onAdFailedToLoad: ((error) {
          print(error.message);
          ad.dispose();
          setState(() {
            isLoaded = false;
          });
        })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              if (isLoaded) {
                ad.show();
              }
            },
            child: Text("Activate")),
      ),
    );
  }
}
