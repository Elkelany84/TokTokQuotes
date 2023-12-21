import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5674077285757727/5002156800';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

}