// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:share/share.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class RandomQuotes extends StatelessWidget {
//   const RandomQuotes({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List quotes = [
//       'اللى تعب وشقى غير اللى طلع و لقى أى حاجة فى كيس',
//       'كله بالحب الا الحب'
//     ];
//     return Padding(
//       padding: const EdgeInsets.all(2.0),
//       child: Container(
//         padding: const EdgeInsets.all(6),
//         color: const Color(0xFFD6D6D6),
//         child: ListView.builder(
//             itemCount: 2,
//             itemBuilder: (BuildContext context, int index) {
//               return Container(
//                 height: 130,
//                 decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                   // border: Border.all(
//                   //   color: const Color(0xFFcaf9f3),
//                   // ),
//                 ),
//                 margin: const EdgeInsets.all(8),
//                 child: Card(
//                   color: Colors.white,
//                   child: ListTile(
//                     title: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Text(
//                             quotes[index],
//                             style: GoogleFonts.tajawal(
//                               textStyle: const TextStyle(
//                                   color: Color(0xFF090856),
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             textAlign: TextAlign.start,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               IconButton(
//                                 onPressed: () {
//                                   Share.share(quotes[index]);
//                                 },
//                                 icon: const FaIcon(
//                                   FontAwesomeIcons.shareAlt,
//                                   color: Color(0xFF090856),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 15,
//                               ),
//                               IconButton(
//                                 onPressed: () {
                                
//                                 },
//                                 icon: const FaIcon(
//                                   FontAwesomeIcons.heart,
//                                   color: Color(0xFF090856),
//                                 ),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }),
//       ),
//     );
//   }
// }
