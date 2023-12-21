// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:toktok_quote/ads/advalue.dart';
import 'package:toktok_quote/homepage.dart';
// import 'package:toktok_quote/models/quotes.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:toktok_quote/models/sqldb.dart';
// import 'package:toktok_quote/showsaved.dart';
import 'package:get/get.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:toktok_quote/showsaved.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // final CounterController _counterController = Get.put(CounterController());

  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'كلام تكاتك',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.light(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ar', 'AE'),
      ],
      locale: Locale("ar", "AE"),
      // theme: ThemeData(
      //   primarySwatch: Colors.orange,
      // ),
      home: MyHomePage(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final CounterController _counterController = Get.put(CounterController());
  
//   SqlDb sqlDb = SqlDb();

//   // bool isLoading = true;

//   Future readData() async {
//     //shortcut function
//     List<Map> response = await sqlDb.readShort('favorites');
//     // List<Map> response = await sqlDb.readData('SELECT * FROM notes');
//     _counterController.myfavorites.addAll(response);
//     // isLoading = false;
//     if (mounted) {
//       setState(() {});
//     }
//   }

//   @override
//   void initState() {
//     readData();
//     super.initState();
//   }

//   bool isClicked = false;
//   var rnd = Random();
//   var snackBar = const SnackBar(
//     content: Text('تم النسخ للحافظة'),
//   );

//   String text = 'اضغط بالراحة عشان تأخذ الخُلاصة';

//   @override
//   Widget build(BuildContext context) {
//     var screenInfo = MediaQuery.of(context);
//     final double screenHeight = screenInfo.size.height;
//     final double screenWidth = screenInfo.size.width;

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {},
//           icon: IconButton(
//             icon: const Icon(Icons.favorite),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ShowSaved()),
//               );
//             },
//           ),
//         ),
//         centerTitle: true,
//         elevation: 0.5,
//         backgroundColor:
//             // Colors.amber,
//             const Color.fromRGBO(255, 241, 0, 1),
//         title: Text(
//           widget.title,
//           style: const TextStyle(
//             color: Color.fromRGBO(0, 166, 156, 1),
//             fontSize: 26,
//             fontFamily: 'ElMessiri',
//           ),
//         ),
//         // leading: IconButton(
//         //   onPressed: () {
//         //     Navigator.push(
//         //         context,
//         //         MaterialPageRoute(
//         //             builder: (context) => ShowSaved(valued: val)));
//         //   },
//         //   icon: const Icon(Icons.menu),
//         // ),
//       ),
//       body:Container(
//           color: const Color.fromRGBO(202, 249, 243, 0.9),
//           // color: const Color.fromRGBO(13, 59, 85, 0.9),
//           // color: Colors.white54,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Steve Jobs Image
//                 // Padding
//                 Padding(
//                   padding: EdgeInsets.only(
//                     right: screenWidth / 5,
//                     left: screenWidth / 5,
//                     top: screenHeight / 11,
//                   ),
//                   // SizedBox
//                   child:
//                       // CircleAvatar(child: Image.asset('images/circleicon.png'),)
//                       SizedBox(
//                           width: screenWidth / 2,
//                           height: screenHeight / 4,
//                           child: Image.asset('assets/images/circleicon.png')),
//                 ),
//                 // Quotes Text
//                 Padding(
//                   padding: const EdgeInsets.only(right: 2.0, left: 2.0),
//                   child: SizedBox(
//                     width: double.infinity,
//                     height: 100,
//                     child: Center(
//                       child: AutoSizeText(
//                         text,
//                         textAlign: TextAlign.center,
//                         maxLines: 2,
//                         maxFontSize: 22,
//                         minFontSize: 21,
//                         style: const TextStyle(
//                             color: Color.fromRGBO(0, 166, 156, 1),
//                             // color: Colors.amber,
//                             // fontSize: 21,
//                             fontFamily: 'ElMessiri',
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Padding(
//                 //   padding: EdgeInsets.only(
//                 //       top: screenHeight / 14,
//                 //       left: screenWidth / 15,
//                 //       right: screenWidth / 13),
//                 //   child: Text(
//                 //     text,
//                 //     style: const TextStyle(
//                 //         color: Color.fromRGBO(0, 166, 156, 1),
//                 //         // color: Colors.amber,
//                 //         fontSize: 22,
//                 //         fontFamily: 'ElMessiri',
//                 //         fontWeight: FontWeight.bold),
//                 //     textDirection: TextDirection.rtl,
//                 //   ),
//                 // ),
//                 // Elevated Button
//                 Padding(
//                   padding: EdgeInsets.only(top: screenHeight / 12),
//                   child: SizedBox(
//                     width: screenWidth / 2,
//                     height: screenHeight / 15,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         primary:
//                             const Color.fromRGBO(255, 241, 0, 1), // background
//                         onPrimary: const Color.fromRGBO(0, 166, 156, 1),
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           int number = rnd.nextInt(quotes.length);
//                           text = quotes[number];

//                           text = (text);
//                           isClicked = false;
//                         });
//                       },
//                       child: const Text(
//                         'خُلاصة الحِكمة',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontFamily: 'ElMessiri',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: screenHeight / 17,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         Share.share(text);
//                       },
//                       icon: const FaIcon(
//                         FontAwesomeIcons.shareAlt,
//                         color: Color.fromRGBO(0, 166, 156, 1),
//                       ),
//                     ),
//                     const SizedBox(width: 15),
//                     IconButton(
//                       onPressed: () {
//                         FlutterClipboard.copy(text).then(
//                           (value) => ScaffoldMessenger.of(context)
//                               .showSnackBar(snackBar),
//                         );
//                       },
//                       icon: const FaIcon(
//                         FontAwesomeIcons.copy,
//                         color: Color.fromRGBO(0, 166, 156, 1),
//                       ),
//                     ),
//                     const SizedBox(width: 15),
//                     IconButton(
//                       onPressed: () async {
//                         int response = await sqlDb.insertShort('favorites', {
//                           'title': text,
//                           'category': "romance",
//                         });
//                         print('response================= + $response');
//                         setState(() {
//                           isClicked = true;
//                         });
//                       },
//                       icon: isClicked
//                           ? const Icon(
//                               Icons.favorite,
//                               color: Color.fromRGBO(0, 166, 156, 1),
//                             )
//                           : const FaIcon(
//                               FontAwesomeIcons.heart,
//                               color: Color.fromRGBO(0, 166, 156, 1),
//                             ),
//                     ),
//                   ],
//                 ),
//                 Advalue(),
//               ],
//             ),
//           ),
//         ),
     
//     );
//   }
// }









// import 'package:flutter/material.dart';
// import 'package:toktok_quote/homepage.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// // import 'package:get/get.dart';


// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'TokToK Talk',
//       // theme: ThemeData.dark(),
//        localizationsDelegates: [
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       supportedLocales: [
//          Locale('ar', 'AE'),
//       ],
//       locale: Locale("ar", "AE"),
//       home: HomePage(),
//     );
//   }
// }
