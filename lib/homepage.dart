// import 'dart:math';

// // import 'package:cron/cron.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';

// import 'package:toktok_quote/ads/advalue.dart';
// import 'package:toktok_quote/models/quotes.dart';

// import 'package:share/share.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:clipboard/clipboard.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:toktok_quote/models/sqldb.dart';
// import 'package:toktok_quote/showsaved.dart';
// import 'package:get/get.dart';
// import 'package:toktok_quote/models/goldnotfiapi.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//   // final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // final CounterController _counterController = Get.find();
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
//     return response;
//   }

//   var iresult;
//   @override
//   void initState() {
//     // _counterController.readData();
//     readData();
//     // GoldNotificationApi.init(initScheduled: true);
//     // listenNotification();
//     super.initState();
//     // GoldNotificationApi.editedShowScheduledNotification(
//     //   title: 'كلام تكاتك',
//     //   body: text,
//     //   payload: 'Delay.abs',
//     // );
//     // checkConnectivity();
//   }

//   // void checkConnectivity() async {
//   //   var result = await Connectivity().checkConnectivity();

//   // }

//   //  void listenNotification() {
//   //   GoldNotificationApi.onNotifications.stream.listen(onClickedNotification);
//   // }

//   void onClickedNotification(String? payload) => Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => const MyHomePage(),
//         ),
//       );
//   // final cron = Cron();

//   bool isClicked = false;
//   var rnd = Random();
//   var snackBarCopy = const SnackBar(
//     content: Text('تم النسخ للحافظة'),
//     duration: Duration(seconds: 2),
//   );

//   var snackBarFav = const SnackBar(
//     content: Text('تم الإضافة للمُفضلة'),
//     duration: Duration(seconds: 2),
//   );

//   String text = 'اضغط بالراحة عشان تأخذ الخُلاصة';

//   @override
//   Widget build(BuildContext context) {
//     var screenInfo = MediaQuery.of(context);
//     final double screenHeight = screenInfo.size.height;
//     final double screenWidth = screenInfo.size.width;

//     return StreamBuilder<ConnectivityResult>(
//         stream: Connectivity().onConnectivityChanged,
//         builder: (context, snapshot) {
//           return Scaffold(
//             appBar: AppBar(
//               leading: IconButton(
//                 icon: const Icon(Icons.favorite,
//                     color: Color.fromRGBO(0, 166, 156, 1)),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => ShowSaved()),
//                   );
//                 },
//               ),

//               centerTitle: true,
//               elevation: 0.5,
//               backgroundColor:
//                   // Colors.amber,
//                   const Color.fromRGBO(255, 241, 0, 1),
//               title: const Text(
//                 'كلام تكاتك',
//                 style: TextStyle(
//                   color: Color.fromRGBO(0, 166, 156, 1),
//                   fontSize: 26,
//                   fontFamily: 'ElMessiri',
//                 ),
//               ),
//               // leading: IconButton(
//               //   onPressed: () {
//               //     Navigator.push(
//               //         context,
//               //         MaterialPageRoute(
//               //             builder: (context) => ShowSaved(valued: val)));
//               //   },
//               //   icon: const Icon(Icons.menu),
//               // ),
//             ),
//             // ignore: unrelated_type_equality_checks
//             body: snapshot.data == ConnectivityResult.none
//                 ? Container(
//                     height: double.infinity,
//                     color: const Color.fromRGBO(202, 249, 243, 0.9),
//                     // color: const Color.fromRGBO(13, 59, 85, 0.9),
//                     // color: Colors.white54,
//                     child: Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           // Steve Jobs Image
//                           // Padding
//                           Padding(
//                             padding: EdgeInsets.only(
//                               right: screenWidth / 5,
//                               left: screenWidth / 5,
//                               top: screenHeight / 12,
//                             ),
//                             // SizedBox
//                             child:
//                                 // CircleAvatar(child: Image.asset('images/circleicon.png'),)
//                                 SizedBox(
//                                     width: screenWidth / 2,
//                                     height: screenHeight / 4,
//                                     child: Image.asset(
//                                         'assets/images/circleicon.png')),
//                           ),
//                           // Quotes Text
//                           SizedBox(
//                             width: double.infinity,
//                             height: 90,
//                             child: Center(
//                               child: AutoSizeText(
//                                 text,
//                                 textAlign: TextAlign.center,
//                                 maxLines: 2,
//                                 maxFontSize: 22,
//                                 minFontSize: 21,
//                                 style: const TextStyle(
//                                     color: Color.fromRGBO(0, 166, 156, 1),
//                                     // color: Colors.amber,
//                                     // fontSize: 21,
//                                     fontFamily: 'ElMessiri',
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                           // Padding(
//                           //   padding: EdgeInsets.only(
//                           //       top: screenHeight / 14,
//                           //       left: screenWidth / 15,
//                           //       right: screenWidth / 13),
//                           //   child: Text(
//                           //     text,
//                           //     style: const TextStyle(
//                           //         color: Color.fromRGBO(0, 166, 156, 1),
//                           //         // color: Colors.amber,
//                           //         fontSize: 22,
//                           //         fontFamily: 'ElMessiri',
//                           //         fontWeight: FontWeight.bold),
//                           //     textDirection: TextDirection.rtl,
//                           //   ),
//                           // ),
//                           // Elevated Button
//                           Padding(
//                             padding: EdgeInsets.only(top: screenHeight / 12),
//                             child: SizedBox(
//                               width: screenWidth / 2,
//                               height: screenHeight / 15,
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   primary: const Color.fromRGBO(
//                                       255, 241, 0, 1), // background
//                                   onPrimary:
//                                       const Color.fromRGBO(0, 166, 156, 1),
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     int number = rnd.nextInt(quotes.length);
//                                     text = quotes[number];

//                                     text = (text);
//                                     isClicked = false;
//                                   });
//                                 },
//                                 child: const Text(
//                                   'خُلاصة الحِكمة',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontFamily: 'ElMessiri',
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: screenHeight / 17,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               IconButton(
//                                 onPressed: () {
//                                   Share.share(text);
//                                 },
//                                 icon: const FaIcon(
//                                   FontAwesomeIcons.shareAlt,
//                                   color: Color.fromRGBO(0, 166, 156, 1),
//                                 ),
//                               ),
//                               const SizedBox(width: 15),
//                               IconButton(
//                                 onPressed: () {
//                                   FlutterClipboard.copy(text).then(
//                                     (value) => ScaffoldMessenger.of(context)
//                                         .showSnackBar(snackBarCopy),
//                                   );
//                                 },
//                                 icon: const FaIcon(
//                                   FontAwesomeIcons.copy,
//                                   color: Color.fromRGBO(0, 166, 156, 1),
//                                 ),
//                               ),
//                               const SizedBox(width: 15),
//                               IconButton(
//                                 onPressed: () async {
//                                   if (isClicked == false) {
//                                     int response =
//                                         await sqlDb.insertShort('favorites', {
//                                       'title': text,
//                                       'category': "romance",
//                                     });
//                                     print(
//                                         'response================= + $response');
//                                   } else {
//                                     print('NOTHING TO SHOW HERE++++++++++++++');
//                                   }

//                                   isClicked == false
//                                       ? ScaffoldMessenger.of(context)
//                                           .showSnackBar(snackBarFav)
//                                       : null;

//                                   setState(() {
//                                     // readFav();
//                                     // _counterController.myfavorites.add(response);
//                                     isClicked = !isClicked;
//                                   });
//                                 },
//                                 icon: isClicked
//                                     ? const Icon(
//                                         Icons.favorite,
//                                         color: Color.fromRGBO(0, 166, 156, 1),
//                                       )
//                                     : const FaIcon(
//                                         FontAwesomeIcons.heart,
//                                         color: Color.fromRGBO(0, 166, 156, 1),
//                                       ),
//                               ),
//                             ],
//                           ),
//                           // Advalue(),
//                         ],
//                       ),
//                     ),
//                   )
//                 : Container(
//                     height: double.infinity,
//                     color: const Color.fromRGBO(202, 249, 243, 0.9),
//                     // color: const Color.fromRGBO(13, 59, 85, 0.9),
//                     // color: Colors.white54,
//                     child: Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           // Steve Jobs Image
//                           // Padding
//                           Padding(
//                             padding: EdgeInsets.only(
//                               right: screenWidth / 5,
//                               left: screenWidth / 5,
//                               top: screenHeight / 12,
//                             ),
//                             // SizedBox
//                             child:
//                                 // CircleAvatar(child: Image.asset('images/circleicon.png'),)
//                                 SizedBox(
//                                     width: screenWidth / 2,
//                                     height: screenHeight / 4,
//                                     child: Image.asset(
//                                         'assets/images/circleicon.png')),
//                           ),
//                           // Quotes Text
//                           SizedBox(
//                             width: double.infinity,
//                             height: 90,
//                             child: Center(
//                               child: AutoSizeText(
//                                 text,
//                                 textAlign: TextAlign.center,
//                                 maxLines: 2,
//                                 maxFontSize: 22,
//                                 minFontSize: 21,
//                                 style: const TextStyle(
//                                     color: Color.fromRGBO(0, 166, 156, 1),
//                                     // color: Colors.amber,
//                                     // fontSize: 21,
//                                     fontFamily: 'ElMessiri',
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                           // Padding(
//                           //   padding: EdgeInsets.only(
//                           //       top: screenHeight / 14,
//                           //       left: screenWidth / 15,
//                           //       right: screenWidth / 13),
//                           //   child: Text(
//                           //     text,
//                           //     style: const TextStyle(
//                           //         color: Color.fromRGBO(0, 166, 156, 1),
//                           //         // color: Colors.amber,
//                           //         fontSize: 22,
//                           //         fontFamily: 'ElMessiri',
//                           //         fontWeight: FontWeight.bold),
//                           //     textDirection: TextDirection.rtl,
//                           //   ),
//                           // ),
//                           // Elevated Button
//                           Padding(
//                             padding: EdgeInsets.only(top: screenHeight / 12),
//                             child: SizedBox(
//                               width: screenWidth / 2,
//                               height: screenHeight / 15,
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   primary: const Color.fromRGBO(
//                                       255, 241, 0, 1), // background
//                                   onPrimary:
//                                       const Color.fromRGBO(0, 166, 156, 1),
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     int number = rnd.nextInt(quotes.length);
//                                     text = quotes[number];

//                                     text = (text);
//                                     isClicked = false;
//                                   });
//                                 },
//                                 child: const Text(
//                                   'خُلاصة الحِكمة',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontFamily: 'ElMessiri',
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: screenHeight / 17,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               IconButton(
//                                 onPressed: () {
//                                   Share.share(text);
//                                 },
//                                 icon: const FaIcon(
//                                   FontAwesomeIcons.shareAlt,
//                                   color: Color.fromRGBO(0, 166, 156, 1),
//                                 ),
//                               ),
//                               const SizedBox(width: 15),
//                               IconButton(
//                                 onPressed: () {
//                                   FlutterClipboard.copy(text).then(
//                                     (value) => ScaffoldMessenger.of(context)
//                                         .showSnackBar(snackBarCopy),
//                                   );
//                                 },
//                                 icon: const FaIcon(
//                                   FontAwesomeIcons.copy,
//                                   color: Color.fromRGBO(0, 166, 156, 1),
//                                 ),
//                               ),
//                               const SizedBox(width: 15),
//                               IconButton(
//                                 onPressed: () async {
//                                   if (isClicked == false) {
//                                     int response =
//                                         await sqlDb.insertShort('favorites', {
//                                       'title': text,
//                                       'category': "romance",
//                                     });
//                                     print(
//                                         'response================= + $response');
//                                   } else {
//                                     print('NOTHING TO SHOW HERE++++++++++++++');
//                                   }

//                                   isClicked == false
//                                       ? ScaffoldMessenger.of(context)
//                                           .showSnackBar(snackBarFav)
//                                       : null;

//                                   setState(() {
//                                     // readFav();
//                                     // _counterController.myfavorites.add(response);
//                                     isClicked = !isClicked;
//                                   });
//                                 },
//                                 icon: isClicked
//                                     ? const Icon(
//                                         Icons.favorite,
//                                         color: Color.fromRGBO(0, 166, 156, 1),
//                                       )
//                                     : const FaIcon(
//                                         FontAwesomeIcons.heart,
//                                         color: Color.fromRGBO(0, 166, 156, 1),
//                                       ),
//                               ),
//                             ],
//                           ),
//                           Advalue(),
//                         ],
//                       ),
//                     ),
//                   ),
//           );
//         });
//   }
// }

import 'dart:math';

// import 'package:cron/cron.dart';
import 'package:flutter/material.dart';

import 'package:toktok_quote/ads/advalue.dart';
import 'package:toktok_quote/models/localNotifications.dart';
import 'package:toktok_quote/models/quotes.dart';

import 'package:share/share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:clipboard/clipboard.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:toktok_quote/models/sqldb.dart';
import 'package:toktok_quote/showsaved.dart';
import 'package:get/get.dart';
import 'package:toktok_quote/widgets/addQuote.dart';
// import 'package:toktok_quote/models/goldnotfiapi.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  // final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? quote;
  // final CounterController _counterController = Get.find();
  final CounterController _counterController = Get.put(CounterController());

  SqlDb sqlDb = SqlDb();

  // bool isLoading = true;

  Future readData() async {
    //shortcut function
    List<Map> response = await sqlDb.readShort('favorites');
    // List<Map> response = await sqlDb.readData('SELECT * FROM notes');
    _counterController.myfavorites.addAll(response);
    // isLoading = false;
    if (mounted) {
      setState(() {});
    }
    return response;
  }

  @override
  void initState() {
    // _counterController.readData();
    readData();
    ScheduledFunction();
    // GoldNotificationApi.init(initScheduled: true);
    // listenNotification();
    super.initState();
    // GoldNotificationApi.editedShowScheduledNotification(
    //   title: 'كلام تكاتك',
    //   body: text,
    //   payload: 'Delay.abs',
    // );
  }

  //Scheduled Notifications

  ScheduledFunction() {
    int number = rnd.nextInt(quotes.length);
    text = quotes[number];
    LocalNotifications.showScheduleNotification(
        title: "", body: text, payload: "This is schedule data");
  }

  //  to listen to any notification clicked or not
  listenToNotifications() {
    print("Listening to notification");
    LocalNotifications.onClickNotification.stream.listen((event) {
      print(event);
      // Navigator.pushNamed(context, '/another', arguments: event);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ShowSaved()),
      );
    });
  }

  //  void listenNotification() {
  //   GoldNotificationApi.onNotifications.stream.listen(onClickedNotification);
  // }

  void onClickedNotification(String? payload) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MyHomePage(),
        ),
      );
  // final cron = Cron();

  bool isClicked = false;
  var rnd = Random();
  var snackBarCopy = const SnackBar(
    content: Text('تم النسخ للحافظة'),
    duration: Duration(seconds: 2),
  );

  var snackBarFav = const SnackBar(
    content: Text('تم الإضافة للمُفضلة'),
    duration: Duration(seconds: 2),
  );

  String text = 'اضغط بالراحة عشان تأخذ الخُلاصة';

  @override
  Widget build(BuildContext context) {
    var screenInfo = MediaQuery.of(context);
    final double screenHeight = screenInfo.size.height;
    final double screenWidth = screenInfo.size.width;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        foregroundColor: Color.fromRGBO(0, 166, 156, 1),
        backgroundColor: Color.fromRGBO(255, 241, 0, 1),
        elevation: 10.0,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AddQuote(quote: quote),
                ),
              ),
            ),
          );
        },
      ),
      appBar: AppBar(
        leading: IconButton(
          icon:
              const Icon(Icons.favorite, color: Color.fromRGBO(0, 166, 156, 1)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ShowSaved()),
            );
          },
        ),

        centerTitle: true,
        elevation: 0.5,
        backgroundColor:
            // Colors.amber,
            const Color.fromRGBO(255, 241, 0, 1),
        title: const Text(
          'كلام تكاتك',
          style: TextStyle(
            color: Color.fromRGBO(0, 166, 156, 1),
            fontSize: 26,
            fontFamily: 'ElMessiri',
          ),
        ),
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => ShowSaved(valued: val)));
        //   },
        //   icon: const Icon(Icons.menu),
        // ),
      ),
      body: Container(
        height: double.infinity,
        color: const Color.fromRGBO(202, 249, 243, 0.9),
        // color: const Color.fromRGBO(13, 59, 85, 0.9),
        // color: Colors.white54,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Steve Jobs Image
                // Padding
                Padding(
                  padding: EdgeInsets.only(
                    right: screenWidth / 5,
                    left: screenWidth / 5,
                    top: screenHeight / 12,
                  ),
                  // SizedBox
                  child:
                      // CircleAvatar(child: Image.asset('images/circleicon.png'),)
                      SizedBox(
                          width: screenWidth / 2,
                          height: screenHeight / 4,
                          child: Image.asset('assets/images/circleicon.png')),
                ),
                // Quotes Text
                SizedBox(
                  width: double.infinity,
                  height: 75,
                  child: Center(
                    child: AutoSizeText(
                      text,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      maxFontSize: 22,
                      minFontSize: 21,
                      style: const TextStyle(
                          color: Color.fromRGBO(0, 166, 156, 1),
                          // color: Colors.amber,
                          // fontSize: 21,
                          fontFamily: 'ElMessiri',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(
                //       top: screenHeight / 14,
                //       left: screenWidth / 15,
                //       right: screenWidth / 13),
                //   child: Text(
                //     text,
                //     style: const TextStyle(
                //         color: Color.fromRGBO(0, 166, 156, 1),
                //         // color: Colors.amber,
                //         fontSize: 22,
                //         fontFamily: 'ElMessiri',
                //         fontWeight: FontWeight.bold),
                //     textDirection: TextDirection.rtl,
                //   ),
                // ),
                // Elevated Button
                Padding(
                  padding: EdgeInsets.only(top: screenHeight / 12),
                  child: SizedBox(
                    width: screenWidth / 2,
                    height: screenHeight / 15,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color.fromRGBO(0, 166, 156, 1),
                        backgroundColor: const Color.fromRGBO(255, 241, 0, 1),
                      ),
                      onPressed: () {
                        setState(() {
                          int number = rnd.nextInt(quotes.length);
                          text = quotes[number];

                          text = (text);
                          isClicked = false;
                        });
                      },
                      child: const Text(
                        'خُلاصة الحِكمة',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'ElMessiri',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight / 17,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Share.share(text);
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.shareAlt,
                        color: Color.fromRGBO(0, 166, 156, 1),
                      ),
                    ),
                    const SizedBox(width: 15),
                    IconButton(
                      onPressed: () {
                        FlutterClipboard.copy(text).then(
                          (value) => ScaffoldMessenger.of(context)
                              .showSnackBar(snackBarCopy),
                        );
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.copy,
                        color: Color.fromRGBO(0, 166, 156, 1),
                      ),
                    ),
                    const SizedBox(width: 15),
                    IconButton(
                      onPressed: () async {
                        if (isClicked == false) {
                          int response = await sqlDb.insertShort('favorites', {
                            'title': text,
                            'category': "romance",
                          });
                          print('response================= + $response');
                        } else {
                          print('NOTHING TO SHOW HERE++++++++++++++');
                        }

                        isClicked == false
                            ? ScaffoldMessenger.of(context)
                                .showSnackBar(snackBarFav)
                            : null;

                        setState(() {
                          // readFav();
                          // _counterController.myfavorites.add(response);
                          isClicked = !isClicked;
                        });
                      },
                      icon: isClicked
                          ? const Icon(
                              Icons.favorite,
                              color: Color.fromRGBO(0, 166, 156, 1),
                            )
                          : const FaIcon(
                              FontAwesomeIcons.heart,
                              color: Color.fromRGBO(0, 166, 156, 1),
                            ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                const Advalue(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
