import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:toktok_quote/services/purchase_service.dart';

import '../controller/favorites_provider.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({Key? key}) : super(key: key);

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  List<Package> _packages = [];
  bool _isLoading = true;
  bool _isPurchasing = false;

  @override
  void initState() {
    super.initState();
    _loadPackages();
  }

  Future<void> _loadPackages() async {
    final packages = await PurchaseService.getPackages();
    if (mounted) {
      setState(() {
        _packages = packages;
        _isLoading = false;
      });
    }
  }

  Future<void> _purchase(Package package) async {
    setState(() => _isPurchasing = true);

    final success = await PurchaseService.purchase(package);

    if (success && mounted) {
      context.read<AppProvider>().setPremium(true);
      _showSuccessDialog();
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'فشلت عملية الشراء، حاول مرة أخرى',
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'ElMessiri'),
          ),
        ),
      );
    }

    if (mounted) setState(() => _isPurchasing = false);
  }

  Future<void> _restore() async {
    setState(() => _isPurchasing = true);

    final success = await PurchaseService.restorePurchases();

    if (mounted) {
      if (success) {
        context.read<AppProvider>().setPremium(true);
        _showSuccessDialog();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'لم يتم العثور على اشتراك سابق',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'ElMessiri'),
            ),
          ),
        );
      }
      setState(() => _isPurchasing = false);
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: const Color.fromRGBO(255, 241, 0, 1),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            const Text('🎉', style: TextStyle(fontSize: 60)),
            const SizedBox(height: 16),
            const Text(
              'مرحباً بك في النسخة المميزة!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'ElMessiri',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(0, 166, 156, 1),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'تم تفعيل جميع المميزات\nاستمتع بتجربة كاملة!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'ElMessiri',
                fontSize: 15,
                color: Color.fromRGBO(0, 166, 156, 1),
                height: 1.6,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(0, 166, 156, 1),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pop(context); // close dialog
                Navigator.pop(context); // close premium screen
              },
              child: const Text(
                'ابدأ الاستخدام',
                style: TextStyle(
                  fontFamily: 'ElMessiri',
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(202, 249, 243, 0.9),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 241, 0, 1),
        elevation: 0.5,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close,
              color: Color.fromRGBO(0, 166, 156, 1)),
        ),
        title: const Text(
          'النسخة المميزة ⭐',
          style: TextStyle(
            fontFamily: 'ElMessiri',
            color: Color.fromRGBO(0, 166, 156, 1),
            fontSize: 22,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: Color.fromRGBO(0, 166, 156, 1),
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // ── Hero ───────────────────────────────────────────
            _buildHero(),
            const SizedBox(height: 28),

            // ── Features list ──────────────────────────────────
            _buildFeaturesList(),
            const SizedBox(height: 28),

            // ── Purchase buttons ───────────────────────────────
            _isPurchasing
                ? const CircularProgressIndicator(
              color: Color.fromRGBO(0, 166, 156, 1),
            )
                : _buildPurchaseButtons(),

            const SizedBox(height: 16),

            // ── Restore ────────────────────────────────────────
            TextButton(
              onPressed: _isPurchasing ? null : _restore,
              child: const Text(
                'استعادة المشتريات السابقة',
                style: TextStyle(
                  fontFamily: 'ElMessiri',
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),

            // ── Legal ──────────────────────────────────────────
            const Text(
              'بالشراء توافق على شروط الاستخدام وسياسة الخصوصية',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'ElMessiri',
                color: Colors.grey,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(0, 166, 156, 1),
            Color.fromRGBO(0, 105, 99, 1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 166, 156, 0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: const Column(
        children: [
          Text('⭐', style: TextStyle(fontSize: 50)),
          SizedBox(height: 12),
          Text(
            'كلام تكاتك المميز',
            style: TextStyle(
              fontFamily: 'ElMessiri',
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'استمتع بتجربة كاملة بلا حدود',
            style: TextStyle(
              fontFamily: 'ElMessiri',
              color: Colors.white70,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesList() {
    final features = [
      {'emoji': '🚫', 'text': 'إزالة الإعلانات بالكامل'},
      {'emoji': '💾', 'text': 'حفظ حِكم بلا حدود'},
      {'emoji': '🎨', 'text': 'جميع تصاميم البطاقات'},
      {'emoji': '📸', 'text': 'مشاركة وحفظ البطاقات كصور'},
      {'emoji': '📂', 'text': 'جميع تصنيفات الحِكم'},
      {'emoji': '🔔', 'text': 'إشعار يومي بحكمة مختارة'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        children: List.generate(features.length, (index) {
          final feature = features[index];
          final isLast = index == features.length - 1;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: Row(
                  children: [
                    Text(
                      feature['emoji']!,
                      style: const TextStyle(fontSize: 22),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      feature['text']!,
                      style: const TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 16,
                        color: Color.fromRGBO(0, 105, 99, 1),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.check_circle,
                      color: Color.fromRGBO(0, 166, 156, 1),
                      size: 20,
                    ),
                  ],
                ),
              ),
              if (!isLast) Divider(height: 1, color: Colors.grey.shade100),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildPurchaseButtons() {
    if (_packages.isEmpty) {
      return const Text(
        'لا تتوفر خيارات شراء حالياً',
        style: TextStyle(fontFamily: 'ElMessiri', color: Colors.grey),
      );
    }

    return Column(
      children: _packages.map((package) {
        final price = package.storeProduct.priceString;
        final title = package.packageType == PackageType.lifetime
            ? 'دفعة واحدة للأبد'
            : package.packageType == PackageType.annual
            ? 'اشتراك سنوي'
            : 'اشتراك شهري';

        final isRecommended = package.packageType == PackageType.lifetime ||
            package.packageType == PackageType.annual;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isRecommended
                      ? const Color.fromRGBO(0, 166, 156, 1)
                      : Colors.white,
                  foregroundColor: isRecommended
                      ? Colors.white
                      : const Color.fromRGBO(0, 166, 156, 1),
                  minimumSize: const Size(double.infinity, 58),
                  elevation: isRecommended ? 4 : 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: BorderSide(
                      color: const Color.fromRGBO(0, 166, 156, 1),
                      width: isRecommended ? 0 : 1.5,
                    ),
                  ),
                ),
                onPressed: () => _purchase(package),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: isRecommended
                            ? Colors.white
                            : const Color.fromRGBO(0, 166, 156, 1),
                      ),
                    ),
                    Text(
                      price,
                      style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: isRecommended
                            ? Colors.white
                            : const Color.fromRGBO(0, 166, 156, 1),
                      ),
                    ),
                  ],
                ),
              ),

              // Recommended badge
              if (isRecommended)
                Positioned(
                  top: -10,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'الأفضل قيمة',
                      style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }
}