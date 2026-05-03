import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:toktok_quote/ads/ad_helper.dart';

class Advalue extends StatefulWidget {
  const Advalue({Key? key}) : super(key: key);

  @override
  State<Advalue> createState() => _AdvalueState();
}

class _AdvalueState extends State<Advalue> {
  BannerAd? _ad;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    _ad = BannerAd(
      // ✅ Use test ID during development, switch to real ID for production
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          if (mounted) setState(() => _isLoaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded || _ad == null) {
      return const SizedBox(
        height: 50, // same height as AdSize.banner
        child: Center(
          child: CircularProgressIndicator(
            color: Color.fromRGBO(0, 166, 156, 1),
            strokeWidth: 2,
          ),
        ),
      );
    }

    return SizedBox(
      width: _ad!.size.width.toDouble(),
      height: _ad!.size.height.toDouble(),
      child: AdWidget(ad: _ad!),
    );
  }
}