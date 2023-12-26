// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:toktok_quote/ads/advalue.dart';
// import 'package:toktok_quote/homepage.dart';
// import 'package:toktok_quote/models/quotes.dart';
// import 'package:toktok_quote/models/sqldb.dart';
// import 'package:get/get.dart';
// import 'package:share/share.dart';

// class ShowSaved extends StatefulWidget {
//   @override
//   State<ShowSaved> createState() => _ShowSavedState();
// }

// class _ShowSavedState extends State<ShowSaved> {
//   final CounterController _counterController = Get.find();

//   SqlDb sqlDb = SqlDb();

//   Future<List<Map>> readData() async {
//     //shortcut function
//     List<Map> response = await sqlDb.readShort('favorites');
//     // List<Map> response = await sqlDb.readData('SELECT * FROM notes');
//     _counterController.myfavorites.addAll(response);
//     // isLoading = false;

//     return response;
//   }

//   Future checkStatus() async {
//     // int isEmpt = _counterController.myfavorites.length;
//     List<Map> response = await sqlDb.readShort('favorites');
//     // return isEmpt;
//     if (mounted) {
//       setState(() {});
//     }
//     return response;
//   }

//   @override
//   void initState() {
//     // _counterController.readData();
//     super.initState();
//     checkStatus();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final CounterController _counterController = Get.find();
//     int isEmpty = _counterController.myfavorites.length;

//     return Scaffold(
//         // backgroundColor: Color.fromRGBO(202, 249, 243, 0.9),
//         appBar: AppBar(
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const FaIcon(
//               FontAwesomeIcons.arrowRight,
//               color: Color.fromRGBO(0, 166, 156, 1),
//             ),
//           ),
//           centerTitle: true,
//           elevation: 0.5,
//           backgroundColor:
//               // Colors.amber,
//               const Color.fromRGBO(255, 241, 0, 1),
//           title: const Text(
//             'قائمــة المُفضلــة',
//             style: TextStyle(
//               color: Color.fromRGBO(0, 166, 156, 1),
//               fontSize: 26,
//               fontFamily: 'ElMessiri',
//             ),
//           ),
//           // leading: IconButton(
//           //   onPressed: () {
//           //     Navigator.push(
//           //         context,
//           //         MaterialPageRoute(
//           //             builder: (context) => ShowSaved(valued: val)));
//           //   },
//           //   icon: const Icon(Icons.menu),
//           // ),
//         ),
// body: Container(
//   color: const Color.fromRGBO(202, 249, 243, 0.9),
//   child: Stack(
//     alignment: AlignmentDirectional.center,
//     fit: StackFit.loose,
//     children: [
//     ListView(children: [
//       FutureBuilder(
//           future: readData(),
//           builder: (BuildContext context,
//               AsyncSnapshot<List<Map>> snapshot) {
//             if (isEmpty == 0) {
//               return emptyContainer(context);
//             }
//             if (snapshot.hasData) {
//               return ListView.builder(
//                   // reverse: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemBuilder: (BuildContext context, index) {
//                     // return Text('${snapshot.data![index]}');
//                     return Card(
//                       shape: RoundedRectangleBorder(
//                         side: BorderSide(
//                           color: Colors.green.shade300,
//                         ),
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       child: ListTile(
//                         shape: RoundedRectangleBorder(
//                             side: BorderSide(
//                               color: Colors.green.shade300,
//                             ),
//                             borderRadius: BorderRadius.circular(10.0)),
//                         tileColor: const Color.fromRGBO(255, 241, 0, 1),
//                         title: Text(
//                           '${snapshot.data![index]['title']}',
//                           style: const TextStyle(
//                             color: Color.fromRGBO(0, 166, 156, 1),
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'ElMessiri',
//                           ),
//                         ),
// subtitle: Text(
//   _counterController.myfavorites.length.toString(),
//   style: TextStyle(color: Colors.red),
// ),
// trailing: IconButton(
//   onPressed: () async {
//     //short function
//     int response = await sqlDb.deleteShort(
//         'favorites',
//         'id = ${_counterController.myfavorites[index]['id']}');
//     //for refreshing ui
//     if (response > 0) {
//       _counterController.myfavorites
//           .removeWhere((element) =>
//               element['id'] ==
//               _counterController
//                   .myfavorites[index]['id']);
//       setState(() {});
//     }
//   },
//               icon: Icon(
//                 Icons.delete,
//                 color: Colors.red[400],
//               ),
//             ),
//           ),
//         );
//       },
//       itemCount: snapshot.data!.length);
// }
// return
//  emptyContainer(context);
//       const Center(
//     child: CircularProgressIndicator(),
//   );
// }),

// physics: const NeverScrollableScrollPhysics(),

// itemBuilder: (BuildContext context, index) {
//   return Card(
//     child: ListTile(
//       tileColor: const Color.fromRGBO(255, 241, 0, 1),
//       title: Text(
//        ('${_counterController.myfavorites[index]['title']}'),
//         style: const TextStyle(
//             color: Color.fromRGBO(0, 166, 156, 1),
//             fontSize: 21),
//       ),
//       subtitle: Text(
//         _counterController.myfavorites.length.toString(),
//         style: const TextStyle(color: Colors.red),
//       ),
//       trailing: IconButton(
//         onPressed: () async {
//           //short function
//           int response = await sqlDb.deleteShort('favorites',
//               'id = ${_counterController.myfavorites[index]['id']}');
//           //for refreshing ui
//           if (response > 0) {
//             _counterController.myfavorites.removeWhere(
//                 (element) =>
//                     element['id'] ==
//                     _counterController.myfavorites[index]
//                         ['id']);
//           }
//regular function
// int response = await sqlDb.deleteData(
//     'DELETE FROM notes WHERE id = ${notes[index]['id']}');
// // print(response);
// if (response > 0) {
//   notes.removeWhere((element) =>
//       element['id'] == notes[index]['id']);
//   setState(() {});
// }
// Navigator.of(context).pushReplacement(
//     MaterialPageRoute(
//         builder: (context) => Home()));
// },
//               icon: const Icon(
//                 Icons.delete,
//                 color: Colors.red,
//               ),
//             ),
//           ),
//         );
//       }),
// ]),
//           ]),
//           Positioned(
//             child: Center(child: Advalue()),
//             bottom: 7,
//           ),
//         ]),
//       ));
// }

// Widget emptyContainer(BuildContext context) {
//   // int isEmpty = _counterController.myfavorites.length;
//   var screenInfo = MediaQuery.of(context);
//   final double screenHeight = screenInfo.size.height;
//   final double screenWidth = screenInfo.size.width;
//   return Container(
//     width: double.infinity,
//     height: double.infinity,
//     color: const Color.fromRGBO(202, 249, 243, 0.9),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SizedBox(
//           width: screenWidth / 2,
//           height: screenHeight / 4,
//           child: Image.asset('assets/images/circleicon.png'),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         const Text(
//           'لا توجد حِكم مُفضلة حتى الأن',
//           style: TextStyle(
//               color: Color.fromARGB(255, 166, 0, 83),
//               // color: Colors.amber,
//               fontSize: 22,
//               fontFamily: 'ElMessiri',
//               fontWeight: FontWeight.bold),
//         )
//       ],
//     ),
//   );
// }
// }

// import 'package:flutter/material.dart';
// import 'package:toktok_quote/models/quotes.dart';
// import 'package:toktok_quote/models/sqldb.dart';
// import 'package:get/get.dart';

// class ShowSaved extends StatefulWidget {
//   @override
//   State<ShowSaved> createState() => _ShowSavedState();
// }

// class _ShowSavedState extends State<ShowSaved> {
//   final CounterController _counterController = Get.find();
//   SqlDb sqlDb = SqlDb();

//   Future readSaved() async {
//     //shortcut function
//     List<Map> response = await sqlDb.readShort('favorites');
//     // List<Map> response = await sqlDb.readData('SELECT * FROM notes');
//     // myfavorites.addAll(response);
//     // isLoading = false;
//     if (mounted) {
//       setState(() async {
//         // List<Map> response = await sqlDb.readShort('favorites');
//       });
//     }
//   }

//   @override
//   void initState() {
//     readSaved();
//     super.initState();

//     // setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(
//         () => Container(
//           child: ListView(children: [
//             ListView.builder(
//                 reverse: true,
//                 itemCount: _counterController.myfavorites.length,
//                 physics: const NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemBuilder: (BuildContext context, index) {
//                   return Card(
//                     child: ListTile(
//                       tileColor: Color.fromARGB(255, 26, 24, 4),
//                       title: Text(
//                         _counterController.myfavorites[index]['title'],
//                         style: const TextStyle(
//                             color: Color.fromRGBO(0, 166, 156, 1),fontSize: 21),
//                       ),subtitle: Text(_counterController.myfavorites.length.toString(),style: TextStyle(color: Colors.red),),
//                       trailing: IconButton(
//                         onPressed: () async {
//                           //short function
//                           int response = await sqlDb.deleteShort('favorites',
//                               'id = ${_counterController.myfavorites[index]['id']}');
//                           //for refreshing ui
//                           if (response > 0) {
//                             _counterController.myfavorites.removeWhere(
//                                 (element) =>
//                                     element['id'] ==
//                                     _counterController.myfavorites[index]
//                                         ['id']);
//                             setState(() {});
//                           }
//                           //regular function
//                           // int response = await sqlDb.deleteData(
//                           //     'DELETE FROM notes WHERE id = ${notes[index]['id']}');
//                           // // print(response);
//                           // if (response > 0) {
//                           //   notes.removeWhere((element) =>
//                           //       element['id'] == notes[index]['id']);
//                           //   setState(() {});
//                           // }
//                           // Navigator.of(context).pushReplacement(
//                           //     MaterialPageRoute(
//                           //         builder: (context) => Home()));
//                         },
//                         icon: const Icon(
//                           Icons.delete,
//                           color: Colors.red,
//                         ),
//                       ),
//                     ),

//                   );
//                 }),
//           ]),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:toktok_quote/ads/advalue.dart';
// import 'package:toktok_quote/models/quotes.dart';
import 'package:toktok_quote/models/sqldb.dart';
// import 'package:get/get.dart';

class ShowSaved extends StatefulWidget {
  const ShowSaved({Key? key}) : super(key: key);

  @override
  State<ShowSaved> createState() => _ShowSavedState();
}

class _ShowSavedState extends State<ShowSaved> {
  // final CounterController _counterController = Get.find();
  SqlDb sqlDb = SqlDb();
  List z = [];
  Future readData() async {
    //shortcut function
    List<Map> response = await sqlDb.readShort('favorites');
    z.addAll(response);
    // List<Map> response = await sqlDb.readData('SELECT * FROM notes');
    // _counterController.myfavorites.addAll(response);
    // isLoading = false;
    setState(() {});
    return response;
  }

  // Future readSaved() async {
  //   //shortcut function
  //   List<Map> response = await sqlDb.readShort('favorites');
  //   // List<Map> response = await sqlDb.readData('SELECT * FROM notes');
  //   // myfavorites.addAll(response);
  //   // isLoading = false;
  //   if (mounted) {
  //     setState(() async {
  //       // List<Map> response = await sqlDb.readShort('favorites');
  //     });
  //     return response;
  //   }
  // }

  @override
  void initState() {
    readData();
    // _counterController.readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int y = z.length;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(
            FontAwesomeIcons.arrowRight,
            color: Color.fromRGBO(0, 166, 156, 1),
          ),
        ),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor:
            // Colors.amber,
            const Color.fromRGBO(255, 241, 0, 1),
        title: const Text(
          'قائمــة المُفضلــة',
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
      body: y>=1 ? Container(height: double.infinity,
        color: const Color.fromRGBO(202, 249, 243, 0.9),
        child: SingleChildScrollView(
          child: Column(children: [
            ListView.builder(
                reverse: true,
                itemCount: z.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.green.shade300,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.green.shade300,
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      tileColor: const Color.fromRGBO(255, 241, 0, 1),
                      title: Text(
                        z[index]['title'],
                        style: const TextStyle(
                          color: Color.fromRGBO(0, 166, 156, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ElMessiri',
                        ),
                      ),
                      // subtitle: Text(
                      //   _counterController.myfavorites.length.toString(),
                      //   style: TextStyle(color: Colors.red),
                      // ),
                      trailing: IconButton(
                        onPressed: () async {
                          //short function
                          int response = await sqlDb.deleteShort(
                              'favorites', 'id = ${z[index]['id']}');
                          //for refreshing ui
                          if (response > 0) {
                            z.removeWhere(
                                (element) => element['id'] == z[index]['id']);
                            setState(() {});
                          }
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  );
                }),
          ]),
        ),
      ): emptyContainer(context),
    );
  }

  Widget emptyContainer(BuildContext context) {
    // int isEmpty = _counterController.myfavorites.length;
    var screenInfo = MediaQuery.of(context);
    final double screenHeight = screenInfo.size.height;
    final double screenWidth = screenInfo.size.width;
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color.fromRGBO(202, 249, 243, 0.9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: screenWidth / 2,
            height: screenHeight / 4,
            child: Image.asset('assets/images/circleicon.png'),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'لا توجد حِكم مُفضلة حتى الأن',
            style: TextStyle(
                color: Color.fromARGB(255, 166, 0, 83),
                // color: Colors.amber,
                fontSize: 22,
                fontFamily: 'ElMessiri',
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
