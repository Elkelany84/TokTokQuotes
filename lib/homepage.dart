import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toktok_quote/ads/advalue.dart';
import 'package:toktok_quote/models/sqldb.dart';
import 'package:toktok_quote/providers/favorites_provider.dart';
import 'package:toktok_quote/showsaved.dart';
import 'package:toktok_quote/widgets/addQuote.dart';

import 'controller/favorites_provider.dart';
import 'models/quotes.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ── State ──────────────────────────────────────────────────────────────
  final CounterController _counterController = Get.put(CounterController());
  final SqlDb _sqlDb = SqlDb();
  final Random _rnd = Random();

  List<String> _onlineQuotes = [];
  bool _quotesLoading = true;
  bool _adLoaded = false;
  String? _quote;

  String _text = 'اضغط بالراحة عشان تأخذ الخُلاصة';

  late InterstitialAd _ad;

  // ── Snack Bars ─────────────────────────────────────────────────────────
  static const _snackBarCopy = SnackBar(
    content: Text('تم النسخ للحافظة'),
    duration: Duration(seconds: 2),
  );

  static const _snackBarFav = SnackBar(
    content: Text('تم الإضافة للمُفضلة'),
    duration: Duration(seconds: 2),
  );

  static const _snackBarRemoved = SnackBar(
    content: Text('تم الحذف من المُفضلة'),
    duration: Duration(seconds: 2),
  );

  // ── Lifecycle ──────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    _loadFavorites();
    _fetchOnlineQuotes();
    _initAd();
  }

  // ── Data Methods ───────────────────────────────────────────────────────

  Future<void> _loadFavorites() async {
    final response = await _sqlDb.readShort('favorites');
    _counterController.myfavorites.addAll(response);
    if (mounted) setState(() {});
  }

  Future<void> _fetchOnlineQuotes() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('onlineQuotes')
          .orderBy('id')
          .get();

      final quotes =
      snapshot.docs.map((doc) => doc['text'] as String).toList();

      if (mounted) {
        setState(() {
          _onlineQuotes = quotes;
          _quotesLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error fetching quotes: $e');
      if (mounted) setState(() => _quotesLoading = false);
    }
  }

  void _pickRandomQuote() {
    if (_onlineQuotes.isEmpty) return;
    setState(() {
      _text = _onlineQuotes[_rnd.nextInt(_onlineQuotes.length)];
    });
  }

  // ── Ad Methods ─────────────────────────────────────────────────────────

  void _initAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-5674077285757727/8322710786',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (loadedAd) {
          _ad = loadedAd;
          setState(() => _adLoaded = true);

          _ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              setState(() => _adLoaded = false);
              _navigateToSaved();
            },
            onAdFailedToShowFullScreenContent: (ad, _) => ad.dispose(),
          );
        },
        onAdFailedToLoad: (_) {
          setState(() => _adLoaded = false);
          _navigateToSaved();
        },
      ),
    );
  }

  void _navigateToSaved() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ShowSaved()),
    );
  }

  void _onFavoritesPressed() {
    if (_adLoaded) {
      _ad.show();
    } else {
      _navigateToSaved();
    }
  }

  // ── Build ──────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(size),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color.fromRGBO(255, 241, 0, 1),
      centerTitle: true,
      elevation: 0.5,
      title: const Text(
        'كلام تكاتك',
        style: TextStyle(
          color: Color.fromRGBO(0, 166, 156, 1),
          fontSize: 26,
          fontFamily: 'ElMessiri',
        ),
      ),
      leading: IconButton(
        icon:
        const Icon(Icons.favorite, color: Color.fromRGBO(0, 166, 156, 1)),
        onPressed: _onFavoritesPressed,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.add,
              color: Color.fromRGBO(0, 166, 156, 1), size: 28),
          onPressed: _showAddQuoteSheet,
        ),
      ],
    );
  }

  Widget _buildBody(Size size) {
    return Container(
      height: double.infinity,
      color: const Color.fromRGBO(202, 249, 243, 0.9),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildLogo(size),
              _buildQuoteText(),
              _buildRandomButton(size),
              SizedBox(height: size.height / 17),
              _buildActionRow(),
              const SizedBox(height: 7),
              const Advalue(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(Size size) {
    return Padding(
      padding: EdgeInsets.only(
        right: size.width / 5,
        left: size.width / 5,
        top: size.height / 12,
      ),
      child: SizedBox(
        width: size.width / 2,
        height: size.height / 4,
        child: Image.asset('assets/images/circleicon.png'),
      ),
    );
  }

  Widget _buildQuoteText() {
    if (_quotesLoading) {
      return const SizedBox(
        height: 75,
        child: Center(
          child: CircularProgressIndicator(
            color: Color.fromRGBO(0, 166, 156, 1),
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 75,
      child: Center(
        child: AutoSizeText(
          _text,
          textAlign: TextAlign.center,
          maxLines: 2,
          maxFontSize: 22,
          minFontSize: 21,
          style: const TextStyle(
            color: Color.fromRGBO(0, 166, 156, 1),
            fontFamily: 'ElMessiri',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildRandomButton(Size size) {
    return Padding(
      padding: EdgeInsets.only(top: size.height / 12),
      child: SizedBox(
        width: size.width / 2,
        height: size.height / 15,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color.fromRGBO(0, 166, 156, 1),
            backgroundColor: const Color.fromRGBO(255, 241, 0, 1),
          ),
          onPressed: _quotesLoading ? null : _pickRandomQuote,
          child: const Text(
            'خُلاصة الحِكمة',
            style: TextStyle(fontSize: 20, fontFamily: 'ElMessiri'),
          ),
        ),
      ),
    );
  }

  Widget _buildActionRow() {
    // watch() — rebuilds only this widget when favorites change
    final favProvider = context.watch<FavoritesProvider>();
    final isSaved = favProvider.isSaved(_text);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ── Share ──
        IconButton(
          onPressed: () => Share.share(_text),
          icon: const FaIcon(
            FontAwesomeIcons.shareNodes,
            color: Color.fromRGBO(0, 166, 156, 1),
          ),
        ),
        const SizedBox(width: 15),

        // ── Copy ──
        IconButton(
          onPressed: () => FlutterClipboard.copy(_text).then(
                (_) => ScaffoldMessenger.of(context).showSnackBar(_snackBarCopy),
          ),
          icon: const FaIcon(
            FontAwesomeIcons.copy,
            color: Color.fromRGBO(0, 166, 156, 1),
          ),
        ),
        const SizedBox(width: 15),

        // ── Favorite ──
        IconButton(
          onPressed: () {
            context.read<FavoritesProvider>().toggleFavorite(_text);
            ScaffoldMessenger.of(context).showSnackBar(
              isSaved ? _snackBarRemoved : _snackBarFav,
            );
          },
          icon: isSaved
              ? const Icon(
            Icons.favorite,
            color: Color.fromRGBO(0, 166, 156, 1),
          )
              : const FaIcon(
            FontAwesomeIcons.heart,
            color: Color.fromRGBO(0, 166, 156, 1),
          ),
        ),
      ],
    );
  }

  void _showAddQuoteSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddQuote(quote: _quote),
        ),
      ),
    );
  }
}