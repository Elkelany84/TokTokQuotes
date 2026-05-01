import 'package:flutter/material.dart';
import 'package:toktok_quote/models/sqldb.dart';

class FavoritesProvider extends ChangeNotifier {
  final SqlDb _sqlDb = SqlDb();

  // Set of saved quote texts for O(1) lookup
  final Set<String> _savedQuotes = {};

  Set<String> get savedQuotes => _savedQuotes;

  /// Load all favorites from SQLite on app start
  Future<void> loadFavorites() async {
    final List<Map> rows = await _sqlDb.readShort('favorites');
    _savedQuotes.clear();
    for (final row in rows) {
      _savedQuotes.add(row['title'] as String);
    }
    notifyListeners();
  }

  /// Returns true if the quote is already saved
  bool isSaved(String quote) => _savedQuotes.contains(quote);

  /// Toggle save/unsave for a quote
  Future<void> toggleFavorite(String quote) async {
    if (isSaved(quote)) {
      // Remove from SQLite
      await _sqlDb.deleteShort('favorites', "title = '$quote'");
      _savedQuotes.remove(quote);
    } else {
      // Save to SQLite
      await _sqlDb.insertShort('favorites', {
        'title': quote,
        'category': 'romance',
      });
      _savedQuotes.add(quote);
    }
    notifyListeners();
  }
}