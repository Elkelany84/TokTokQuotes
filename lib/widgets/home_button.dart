import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  // final Color color;
  final String title;
  // final VoidCallback onPressed;

  // ignore: use_key_in_widget_constructors
  const MyButton({required this.title});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.width;
    return Container(
      width: w * 0.70,
      height: h * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white70.withOpacity(1),
      ),
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.tajawal(
            textStyle:  const TextStyle(
               color: Color(0xFF4600b2),
                // color: Colors.lightBlue[700],
                 fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
