import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toktok_quote/widgets/quote_card.dart';

import '../controller/favorites_provider.dart';
import '../screens/premium_screen.dart';

class ShareSheet extends StatefulWidget {
  final String quote;

  const ShareSheet({Key? key, required this.quote}) : super(key: key);

  @override
  State<ShareSheet> createState() => _ShareSheetState();
}

class _ShareSheetState extends State<ShareSheet> {
  final ScreenshotController _screenshotController = ScreenshotController();
  QuoteCardTheme _selectedTheme = quoteCardThemes.first;
  bool _isSaving = false;

  // ── Capture & Share ────────────────────────────────────────────────────
  Future<void> _shareAsImage() async {
    setState(() => _isSaving = true);

    try {
      final Uint8List? imageBytes = await _screenshotController.capture(
        pixelRatio: 3.0, // high resolution
      );

      if (imageBytes == null) return;

      // Save to temp file then share
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/toktok_quote.png');
      await file.writeAsBytes(imageBytes);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: widget.quote,
      );
    } catch (e) {
      debugPrint('Share error: $e');
    }

    if (mounted) setState(() => _isSaving = false);
  }

  Future<void> _saveToGallery() async {
    setState(() => _isSaving = true);

    try {
      final Uint8List? imageBytes = await _screenshotController.capture(
        pixelRatio: 3.0,
      );

      if (imageBytes == null) return;

      // ✅ image_gallery_saver_plus method
      final result = await ImageGallerySaverPlus.saveImage(
        imageBytes,
        name: 'toktok_quote_${DateTime.now().millisecondsSinceEpoch}',
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result['isSuccess'] == true
                  ? '✅ تم الحفظ في الاستوديو'
                  : '❌ فشل الحفظ',
              style: const TextStyle(fontFamily: 'ElMessiri'),
              textAlign: TextAlign.center,
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      debugPrint('Save error: $e');
    }

    if (mounted) setState(() => _isSaving = false);
  }

  // ── Build ──────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final isPremium = context.watch<AppProvider>().isPremium;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),

          // Title
          const Text(
            'مشاركة كبطاقة',
            style: TextStyle(
              fontFamily: 'ElMessiri',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 166, 156, 1),
            ),
          ),
          const SizedBox(height: 20),

          // ── Quote card preview ─────────────────────────────────────
          Screenshot(
            controller: _screenshotController,
            child: QuoteCard(
              quote: widget.quote,
              theme: _selectedTheme,
            ),
          ),
          const SizedBox(height: 20),

          // ── Theme picker ───────────────────────────────────────────
          _buildThemePicker(isPremium),
          const SizedBox(height: 24),

          // ── Action buttons ─────────────────────────────────────────
          _isSaving
              ? const CircularProgressIndicator(
            color: Color.fromRGBO(0, 166, 156, 1),
          )
              : Row(
            children: [
              // Save to gallery
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color.fromRGBO(0, 166, 156, 1),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: isPremium
                      ? _saveToGallery
                      : () => _showPremiumDialog(context),
                  icon: Icon(
                    isPremium
                        ? Icons.download_rounded
                        : Icons.lock_rounded,
                    color: const Color.fromRGBO(0, 166, 156, 1),
                    size: 20,
                  ),
                  label: const Text(
                    'حفظ',
                    style: TextStyle(
                      fontFamily: 'ElMessiri',
                      color: Color.fromRGBO(0, 166, 156, 1),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Share
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    const Color.fromRGBO(0, 166, 156, 1),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: isPremium
                      ? _shareAsImage
                      : () => _showPremiumDialog(context),
                  icon: Icon(
                    isPremium
                        ? Icons.share_rounded
                        : Icons.lock_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  label: const Text(
                    'مشاركة كصورة',
                    style: TextStyle(
                      fontFamily: 'ElMessiri',
                      color: Colors.white,
                      fontSize: 16,
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

  Widget _buildThemePicker(bool isPremium) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 4, bottom: 10),
          child: Row(
            children: [
              const Text(
                'اختر التصميم',
                style: TextStyle(
                  fontFamily: 'ElMessiri',
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 6),
              // Premium themes label
              if (!isPremium)
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    '🔒 بعض التصاميم للمشتركين',
                    style: TextStyle(
                      fontFamily: 'ElMessiri',
                      fontSize: 11,
                      color: Colors.orange,
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: quoteCardThemes.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final theme = quoteCardThemes[index];
              // First 2 themes free, rest premium
              final isLocked = !isPremium && index >= 2;
              final isSelected = _selectedTheme.name == theme.name;

              return GestureDetector(
                onTap: () {
                  if (isLocked) {
                    _showPremiumDialog(context);
                    return;
                  }
                  setState(() => _selectedTheme = theme);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: isLocked ? null : theme.gradient,
                    color: isLocked ? Colors.grey.shade200 : null,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? Colors.black
                          : Colors.transparent,
                      width: 3,
                    ),
                    boxShadow: isSelected
                        ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      )
                    ]
                        : [],
                  ),
                  child: isLocked
                      ? const Icon(Icons.lock,
                      color: Colors.grey, size: 18)
                      : null,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showPremiumDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: const Color.fromRGBO(255, 241, 0, 1),
        title: const Text(
          '⭐ ميزة مدفوعة',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'ElMessiri',
            color: Color.fromRGBO(0, 166, 156, 1),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        content: const Text(
          'مشاركة البطاقات وحفظها وجميع التصاميم متاحة للمشتركين فقط.',
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
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'لاحقاً',
                    style: TextStyle(
                        fontFamily: 'ElMessiri', color: Colors.grey),
                  ),
                ),
              ),
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
                    // TODO: open premium screen (coming next step)

                  },
                  child: const Text(
                    'اشترك الآن',
                    style: TextStyle(
                        fontFamily: 'ElMessiri', color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}