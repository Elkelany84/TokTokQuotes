import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toktok_quote/models/quote_category.dart';
import 'package:toktok_quote/models/sqldb.dart';

import '../screens/premium_screen.dart';
import '../services/purchase_service.dart';

class AppProvider extends ChangeNotifier {
  final SqlDb _sqlDb = SqlDb();

  // ── Favorites ────────────────────────────────────────────────────────────
  final Set<String> _savedQuotes = {};
  Set<String> get savedQuotes => _savedQuotes;

  bool isSaved(String quote) => _savedQuotes.contains(quote);

  Future<void> loadFavorites() async {
    final List<Map> rows = await _sqlDb.readShort('favorites');
    _savedQuotes.clear();
    for (final row in rows) {
      _savedQuotes.add(row['title'] as String);
    }
    notifyListeners();
  }

  // Future<void> toggleFavorite(String quote) async {
  //   if (isSaved(quote)) {
  //     await _sqlDb.deleteShort('favorites', "title = '$quote'");
  //     _savedQuotes.remove(quote);
  //   } else {
  //     // ── Step 4 will add the 10-quote cap check here ──
  //     await _sqlDb.insertShort('favorites', {
  //       'title': quote,
  //       'category': _selectedCategory.id,
  //     });
  //     _savedQuotes.add(quote);
  //   }
  //   notifyListeners();
  // }

  // ── Constants ────────────────────────────────────────────────────────────
  static const int _freeFavoritesLimit = 10;

  // ── Premium Status ────────────────────────────────────────────────────
  bool _isPremium = false;
  bool get isPremium => _isPremium;

  /// Call on app start to check stored purchase status
  Future<void> checkPremiumStatus() async {
    _isPremium = await PurchaseService.checkPremiumStatus();
    notifyListeners();
  }

// Call this after RevenueCat confirms purchase (coming later)
  void setPremium(bool value) {
    _isPremium = value;
    notifyListeners();
  }


  Future<void> toggleFavorite(String quote, BuildContext context) async {
    if (isSaved(quote)) {
      // Always allow removing
      await _sqlDb.deleteShort('favorites', "title = '$quote'");
      _savedQuotes.remove(quote);
    } else {
      // ── Free user cap check ──
      if (!isPremium && _savedQuotes.length >= _freeFavoritesLimit) {
        _showUpgradeDialog(context);
        return;
      }

      await _sqlDb.insertShort('favorites', {
        'title': quote,
        'category': _selectedCategory.id,
      });
      _savedQuotes.add(quote);
    }
    notifyListeners();
  }

  void _showUpgradeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: const Color.fromRGBO(255, 241, 0, 1),
        title: const Text(
          '⭐ وصلت للحد المجاني',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'ElMessiri',
            color: Color.fromRGBO(0, 166, 156, 1),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        content: const Text(
          'يمكنك حفظ ١٠ حِكم فقط في النسخة المجانية.\nاشترك الآن لحفظ حِكم بلا حدود!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'ElMessiri',
            color: Color.fromRGBO(0, 166, 156, 1),
            fontSize: 16,
            height: 1.6,
          ),
        ),
        actions: [
          Row(
            children: [
              // Dismiss
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'لاحقاً',
                    style: TextStyle(
                      fontFamily: 'ElMessiri',
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              // Upgrade — will wire to RevenueCat in premium step
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 166, 156, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PremiumScreen()),
                    );
                  },
                  child: const Text(
                    'اشترك الآن',
                    style: TextStyle(
                      fontFamily: 'ElMessiri',
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Quotes ───────────────────────────────────────────────────────────────
  List<String> _quotes = [];
  List<String> get quotes => _quotes;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // ── Selected Category ────────────────────────────────────────────────────
  QuoteCategory _selectedCategory = quoteCategories.first; // defaults to 'all'
  QuoteCategory get selectedCategory => _selectedCategory;

  Future<void> selectCategory(QuoteCategory category) async {
    if (_selectedCategory.id == category.id) return;
    _selectedCategory = category;
    notifyListeners();
    await fetchQuotes();
  }

  // ── Fetch Quotes from Firestore ──────────────────────────────────────────
  // Future<void> fetchQuotes() async {
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   try {
  //     Query query = FirebaseFirestore.instance
  //         .collection('onlineQuotes')
  //         .orderBy('id');
  //
  //     // Filter by category unless 'all' is selected
  //     if (_selectedCategory.id != 'all') {
  //       query = query.where('category', isEqualTo: _selectedCategory.id);
  //     }
  //
  //     final snapshot = await query.get();
  //     _quotes = snapshot.docs.map((doc) => doc['text'] as String).toList();
  //   } catch (e) {
  //     debugPrint('Error fetching quotes: $e');
  //     _quotes = [];
  //   }
  //
  //   _isLoading = false;
  //   notifyListeners();
  // }
  Future<void> fetchQuotes() async {
    _isLoading = true;
    notifyListeners();

    try {
      Query query = FirebaseFirestore.instance
          .collection('onlineQuotes')
          .orderBy('id');

      if (_selectedCategory.id != 'all') {
        query = query.where('category', isEqualTo: _selectedCategory.id);
      }

      final snapshot = await query.get();
      _quotes = snapshot.docs.map((doc) => doc['text'] as String).toList();

      // ── Debug prints ──
      print('✅ Quotes fetched: ${_quotes.length}');
      print('📂 Category: ${_selectedCategory.id}');
      if (_quotes.isNotEmpty) print('📝 First quote: ${_quotes.first}');

    } catch (e) {
      print('❌ Error fetching quotes: $e');   // ← check this in your console
      _quotes = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}