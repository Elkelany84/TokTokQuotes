import 'dart:io';

// class AdHelper {
//
//   static String get bannerAdUnitId {
//     if (Platform.isAndroid) {
//       return 'ca-app-pub-5674077285757727/5002156800';
//     } else {
//       throw UnsupportedError('Unsupported platform');
//     }
//   }
//
// }

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      // ✅ Test ID — use this during development
      // return 'ca-app-pub-3940256099942544/6300978111';

      // 🚀 Real ID — uncomment for production
       return 'ca-app-pub-5674077285757727/5002156800';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716'; // iOS test ID
    }
    throw UnsupportedError('Unsupported platform');
  }
}