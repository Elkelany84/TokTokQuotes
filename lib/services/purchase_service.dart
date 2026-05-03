import 'dart:io';

import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseService {
  // ── Replace with your actual RevenueCat API key ──
  static const String _androidApiKey = 'test_GSCTxrbUCdPdUYODsIYmeeoLRYB';
  static const String _iosApiKey     = 'appl_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
  static const String _entitlementId = 'premium';

  // ── Init — call once in main() ─────────────────────────────────────────
  static Future<void> init() async {
    await Purchases.setLogLevel(LogLevel.debug); // remove in production

    final config = PurchasesConfiguration(
      Platform.isAndroid ? _androidApiKey : _iosApiKey,
    );

    await Purchases.configure(config);
  }

  // ── Check if user is premium ───────────────────────────────────────────
  static Future<bool> checkPremiumStatus() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      return customerInfo.entitlements.active.containsKey(_entitlementId);
    } catch (e) {
      debugPrint('RevenueCat checkPremium error: $e');
      return false;
    }
  }

  // ── Fetch available packages ───────────────────────────────────────────
  static Future<List<Package>> getPackages() async {
    try {
      final offerings = await Purchases.getOfferings();
      return offerings.current?.availablePackages ?? [];
    } catch (e) {
      debugPrint('RevenueCat getPackages error: $e');
      return [];
    }
  }

  // ── Purchase a package ─────────────────────────────────────────────────
  static Future<bool> purchase(Package package) async {
    try {
      final customerInfo = await Purchases.purchasePackage(package);
      return customerInfo.entitlements.active.containsKey(_entitlementId);
    } on PurchasesErrorCode catch (e) {
      if (e == PurchasesErrorCode.purchaseCancelledError) {
        debugPrint('User cancelled purchase');
      } else {
        debugPrint('Purchase error: $e');
      }
      return false;
    }
  }

  // ── Restore purchases ──────────────────────────────────────────────────
  static Future<bool> restorePurchases() async {
    try {
      final customerInfo = await Purchases.restorePurchases();
      return customerInfo.entitlements.active.containsKey(_entitlementId);
    } catch (e) {
      debugPrint('Restore error: $e');
      return false;
    }
  }
}