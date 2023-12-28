import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddQuote extends StatelessWidget {
  AddQuote({this.quote});
  final String? quote;

  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: const Color(0xff757575),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const Text(
              'شارك حكمتك المُفضلة :',
              style: TextStyle(
                  color: Color.fromRGBO(0, 166, 156, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  decoration: TextDecoration.underline),
              textAlign: TextAlign.start,
            ),
            TextField(
              controller: _textController,
              autofocus: true,
              decoration: InputDecoration(),
              // textDirection: TextDirection.rtl,
            ),
            Container(
              width: double.infinity,
              height: 50.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 241, 0, 1)),
                child: const Text(
                  'أضـــف',
                  style: TextStyle(
                      color: Color.fromRGBO(0, 166, 156, 1),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  final f = DateFormat(' dd-MM-yyyy', 'ar');
                  await FirebaseFirestore.instance
                      .collection('Quotes')
                      .doc(
                          '${_textController.text} ${f.format(DateTime.fromMillisecondsSinceEpoch(DateTime.now().toUtc().millisecondsSinceEpoch))}')
                      .set({
                        'name': _textController.text,
                        // 'rev': _textController.text,
                        // 'date': DateTime.now().toUtc().millisecondsSinceEpoch,
                        // 'val':
                        //     '$quote ${f.format(DateTime.fromMillisecondsSinceEpoch(DateTime.now().toUtc().millisecondsSinceEpoch))}',
                        'status': false
                      })
                      .then((value) => Navigator.pop(context))
                      .then((value) => ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Color.fromRGBO(255, 241, 0, 1),
                              content: Text(
                                  'تم إضافة المقولة للتطبيق ، خالص الشكر',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 166, 156, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0)))));
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
