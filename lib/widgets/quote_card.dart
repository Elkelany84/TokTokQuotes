import 'package:flutter/material.dart';

class QuoteCard extends StatelessWidget {
  final String quote;
  final QuoteCardTheme theme;

  const QuoteCard({
    Key? key,
    required this.quote,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 400,
      decoration: BoxDecoration(
        gradient: theme.gradient,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          // ── Decorative circles ───────────────────────────────────────
          Positioned(
            top: -30,
            left: -30,
            child: _decorativeCircle(120, Colors.white.withOpacity(0.08)),
          ),
          Positioned(
            bottom: -20,
            right: -20,
            child: _decorativeCircle(160, Colors.white.withOpacity(0.06)),
          ),
          Positioned(
            top: 60,
            right: -40,
            child: _decorativeCircle(100, Colors.white.withOpacity(0.05)),
          ),

          // ── Content ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Opening quote mark
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '❝',
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white.withOpacity(0.4),
                      height: 1,
                    ),
                  ),
                ),

                // Quote text
                Text(
                  quote,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'ElMessiri',
                    fontWeight: FontWeight.bold,
                    height: 1.8,
                  ),
                ),

                // App watermark
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 1,
                      color: Colors.white.withOpacity(0.4),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'كلام تكاتك',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontFamily: 'ElMessiri',
                        fontSize: 14,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 60,
                      height: 1,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _decorativeCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

// ── Card Themes ─────────────────────────────────────────────────────────────
class QuoteCardTheme {
  final String name;
  final LinearGradient gradient;

  const QuoteCardTheme({required this.name, required this.gradient});
}

const List<QuoteCardTheme> quoteCardThemes = [
  QuoteCardTheme(
    name: 'تيل',
    gradient: LinearGradient(
      colors: [Color.fromRGBO(0, 166, 156, 1), Color.fromRGBO(0, 105, 99, 1)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  QuoteCardTheme(
    name: 'غروب',
    gradient: LinearGradient(
      colors: [Color(0xFFf7971e), Color(0xFFffd200)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  QuoteCardTheme(
    name: 'ليل',
    gradient: LinearGradient(
      colors: [Color(0xFF141E30), Color(0xFF243B55)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  QuoteCardTheme(
    name: 'ورد',
    gradient: LinearGradient(
      colors: [Color(0xFFee9ca7), Color(0xFFffdde1)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  QuoteCardTheme(
    name: 'بنفسج',
    gradient: LinearGradient(
      colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  QuoteCardTheme(
    name: 'طبيعة',
    gradient: LinearGradient(
      colors: [Color(0xFF11998e), Color(0xFF38ef7d)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
];