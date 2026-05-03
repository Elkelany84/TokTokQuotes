import 'package:flutter/material.dart';

class QuoteCategory {
  final String id;        // matches Firestore category field value
  final String label;     // Arabic display name
  final IconData icon;
  final bool isPremium;

  const QuoteCategory({
    required this.id,
    required this.label,
    required this.icon,
    required this.isPremium,
  });
}

// ── All categories ─────────────────────────────────────────────────────────
const List<QuoteCategory> quoteCategories = [
  QuoteCategory(
    id: 'all',
    label: 'الكل',
    icon: Icons.auto_awesome,
    isPremium: false,
  ),
  QuoteCategory(
    id: 'wisdom',
    label: 'حكم وفلسفة',
    icon: Icons.lightbulb_outline,
    isPremium: false,
  ),
  QuoteCategory(
    id: 'motivation',
    label: 'نجاح وتحفيز',
    icon: Icons.rocket_launch_outlined,
    isPremium: false,
  ),
  QuoteCategory(
    id: 'love',
    label: 'حب ورومانسية',
    icon: Icons.favorite_border,
    isPremium: true,      // 🔒 premium
  ),
  QuoteCategory(
    id: 'religion',
    label: 'دين وروحانيات',
    icon: Icons.mosque_outlined,
    isPremium: true,      // 🔒 premium
  ),
  QuoteCategory(
    id: 'friendship',
    label: 'صداقة',
    icon: Icons.people_outline,
    isPremium: true,      // 🔒 premium
  ),
  QuoteCategory(
    id: 'humor',
    label: 'فكاهة',
    icon: Icons.sentiment_very_satisfied_outlined,
    isPremium: true,      // 🔒 premium
  ),
];