import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:toktok_quote/ads/advalue.dart';
import 'package:toktok_quote/models/sqldb.dart';
import 'package:toktok_quote/showsaved.dart';
import 'package:toktok_quote/widgets/addQuote.dart';
import 'package:toktok_quote/widgets/category_selector.dart';
import 'package:toktok_quote/widgets/share_sheet.dart';

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
    _initAd();

    // ── Fetch quotes if not already loaded ──
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<AppProvider>();
      if (provider.quotes.isEmpty && !provider.isLoading) {
        provider.fetchQuotes();
      }
    });
  }

  // ── Favorites ──────────────────────────────────────────────────────────
  Future<void> _loadFavorites() async {
    final response = await _sqlDb.readShort('favorites');
    _counterController.myfavorites.addAll(response);
    if (mounted) setState(() {});
  }

  // ── Quotes ─────────────────────────────────────────────────────────────
  void _pickRandomQuote() {
    // ✅ Reading from AppProvider — not local list
    final quotes = context.read<AppProvider>().quotes;

    if (quotes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('لا توجد حِكم في هذا التصنيف'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() => _text = quotes[_rnd.nextInt(quotes.length)]);
  }

  // ── Ads ────────────────────────────────────────────────────────────────
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
    _adLoaded ? _ad.show() : _navigateToSaved();
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
        icon: const Icon(Icons.favorite, color: Color.fromRGBO(0, 166, 156, 1)),
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
    // ✅ Watch AppProvider for loading state and quotes
    final appProvider = context.watch<AppProvider>();

    return Container(
      height: double.infinity,
      color: const Color.fromRGBO(202, 249, 243, 0.9),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),

            // ✅ Category selector
            const CategorySelector(),

            _buildLogo(size),

            // ✅ Show loader or quote text
            appProvider.isLoading
                ? const SizedBox(
                    height: 75,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color.fromRGBO(0, 166, 156, 1),
                      ),
                    ),
                  )
                : _buildQuoteText(),

            _buildRandomButton(size, appProvider.isLoading),
            SizedBox(height: size.height / 17),
            _buildActionRow(),
            const SizedBox(height: 7),
            const Advalue(),
          ],
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

  Widget _buildRandomButton(Size size, bool isLoading) {
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
          // ✅ Disabled while loading
          onPressed: isLoading ? null : _pickRandomQuote,
          child: const Text(
            'خُلاصة الحِكمة',
            style: TextStyle(fontSize: 20, fontFamily: 'ElMessiri'),
          ),
        ),
      ),
    );
  }

  Widget _buildActionRow() {
    final favProvider = context.watch<AppProvider>();
    final isSaved = favProvider.isSaved(_text);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ── Share ── replace old IconButton with this:
        IconButton(
          onPressed: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => ShareSheet(quote: _text),
          ),
          icon: const FaIcon(
            FontAwesomeIcons.shareNodes,
            color: Color.fromRGBO(0, 166, 156, 1),
          ),
        ),
        const SizedBox(width: 15),
        IconButton(
          onPressed: () => FlutterClipboard.copy(_text).then(
            (_) => ScaffoldMessenger.of(context).showSnackBar(_snackBarCopy),
          ),
          icon: const FaIcon(FontAwesomeIcons.copy,
              color: Color.fromRGBO(0, 166, 156, 1)),
        ),
        const SizedBox(width: 15),
        IconButton(
          onPressed: () {
            context.read<AppProvider>().toggleFavorite(_text,context);
            // Only show snackbar if it was actually saved/removed
            // (dialog handles the cap case)
            if (favProvider.isSaved(_text)) {
              ScaffoldMessenger.of(context).showSnackBar(_snackBarRemoved);
            } else if (favProvider.savedQuotes.length < 10 || favProvider.isPremium) {
              ScaffoldMessenger.of(context).showSnackBar(_snackBarFav);
            }
          },
          icon: isSaved
              ? const Icon(Icons.favorite,
                  color: Color.fromRGBO(0, 166, 156, 1))
              : const FaIcon(FontAwesomeIcons.heart,
                  color: Color.fromRGBO(0, 166, 156, 1)),
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
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddQuote(quote: _quote),
        ),
      ),
    );
  }
}
