import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktok_quote/models/quote_category.dart';

import '../controller/favorites_provider.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();

    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: quoteCategories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = quoteCategories[index];
          final isSelected = provider.selectedCategory.id == category.id;

          return _CategoryChip(
            category: category,
            isSelected: isSelected,
            onTap: () {
              if (category.isPremium) {
                // ── Step (premium gate) will handle this later ──
                _showPremiumDialog(context);
                return;
              }
              context.read<AppProvider>().selectCategory(category);
            },
          );
        },
      ),
    );
  }

  void _showPremiumDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: const Color.fromRGBO(255, 241, 0, 1),
        title: const Text(
          '🔒 ميزة مدفوعة',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'ElMessiri',
            color: Color.fromRGBO(0, 166, 156, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'هذا التصنيف متاح للمشتركين فقط.\nسيتم إضافة الاشتراك قريباً!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'ElMessiri',
            color: Color.fromRGBO(0, 166, 156, 1),
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'حسناً',
              style: TextStyle(
                fontFamily: 'ElMessiri',
                color: Color.fromRGBO(0, 166, 156, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final QuoteCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromRGBO(0, 166, 156, 1)
              : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color.fromRGBO(0, 166, 156, 1),
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: const Color.fromRGBO(0, 166, 156, 0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            )
          ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Lock icon for premium
            if (category.isPremium)
              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Icon(Icons.lock, size: 13, color: Colors.amber),
              ),
            Icon(
              category.icon,
              size: 16,
              color: isSelected
                  ? Colors.white
                  : const Color.fromRGBO(0, 166, 156, 1),
            ),
            const SizedBox(width: 6),
            Text(
              category.label,
              style: TextStyle(
                fontFamily: 'ElMessiri',
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? Colors.white
                    : const Color.fromRGBO(0, 166, 156, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}