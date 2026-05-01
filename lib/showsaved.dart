import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toktok_quote/providers/favorites_provider.dart';

import 'controller/favorites_provider.dart';

class ShowSaved extends StatelessWidget {
  const ShowSaved({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favProvider = context.watch<FavoritesProvider>();
    final favorites = favProvider.savedQuotes.toList();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(202, 249, 243, 0.9),
      appBar: _buildAppBar(context, favorites.length),
      body: favorites.isEmpty
          ? _buildEmptyState(context)
          : _buildList(context, favorites, favProvider),
    );
  }

  // ── AppBar ─────────────────────────────────────────────────────────────

  AppBar _buildAppBar(BuildContext context, int count) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(255, 241, 0, 1),
      centerTitle: true,
      elevation: 0.5,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const FaIcon(
          FontAwesomeIcons.arrowRight,
          color: Color.fromRGBO(0, 166, 156, 1),
        ),
      ),
      title: const Text(
        'قائمــة المُفضلــة',
        style: TextStyle(
          color: Color.fromRGBO(0, 166, 156, 1),
          fontSize: 26,
          fontFamily: 'ElMessiri',
        ),
      ),
      // Quote counter badge
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 166, 156, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'ElMessiri',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── List ───────────────────────────────────────────────────────────────

  Widget _buildList(
      BuildContext context,
      List<String> favorites,
      FavoritesProvider favProvider,
      ) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final quote = favorites[index];
        return _buildQuoteCard(context, quote, index, favProvider);
      },
    );
  }

  Widget _buildQuoteCard(
      BuildContext context,
      String quote,
      int index,
      FavoritesProvider favProvider,
      ) {
    return Dismissible(
      key: Key(quote),
      direction: DismissDirection.endToStart,
      background: _buildDismissBackground(),
      onDismissed: (_) {
        favProvider.toggleFavorite(quote);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم الحذف من المُفضلة'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 3,
        shadowColor: Colors.teal.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color.fromRGBO(0, 166, 156, 0.3)),
          borderRadius: BorderRadius.circular(14),
        ),
        child: ListTile(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          tileColor: const Color.fromRGBO(255, 241, 0, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          // Quote number
          leading: CircleAvatar(
            backgroundColor: const Color.fromRGBO(0, 166, 156, 1),
            radius: 18,
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'ElMessiri',
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          title: Text(
            quote,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              color: Color.fromRGBO(0, 166, 156, 1),
              fontSize: 17,
              fontWeight: FontWeight.bold,
              fontFamily: 'ElMessiri',
              height: 1.5,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              favProvider.toggleFavorite(quote);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم الحذف من المُفضلة'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(Icons.delete_rounded, color: Colors.pinkAccent),
            tooltip: 'حذف',
          ),
        ),
      ),
    );
  }

  // Swipe-to-delete red background
  Widget _buildDismissBackground() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(14),
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 20),
      child: const Icon(Icons.delete_rounded, color: Colors.white, size: 28),
    );
  }

  // ── Empty State ────────────────────────────────────────────────────────

  Widget _buildEmptyState(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Faded logo
          Opacity(
            opacity: 0.5,
            child: SizedBox(
              width: size.width / 2.2,
              height: size.height / 4.5,
              child: Image.asset('assets/images/circleicon.png'),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'لا توجد حِكم مُفضلة حتى الأن',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 166, 0, 83),
              fontSize: 20,
              fontFamily: 'ElMessiri',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'اضغط على ♥ لحفظ الحِكمة',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(0, 166, 156, 0.7),
              fontSize: 16,
              fontFamily: 'ElMessiri',
            ),
          ),
        ],
      ),
    );
  }
}