import 'package:flutter/material.dart';

class ReviewTxtIf extends StatelessWidget {
  final String txt;
  final String initialTxtValue;
  final String hint;
  final IconData? icon;
  //final String Function(String) validator;
  //final Function(String) onSaved;
  const ReviewTxtIf({
    Key? key,
    required this.txt,
    required this.initialTxtValue,
    required this.hint,
    this.icon,
    //required this.validator,
    //required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(25.0, 18, 25.0, 8),
          child: Text(
            txt,
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black87),
          ),
        ),
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 2.0,
            ),
          ]),
          margin: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
          child: TextFormField(
            initialValue: initialTxtValue,
            autocorrect: true,
            //validator: validator,
            //onSaved: onSaved,
            minLines: 8,
            maxLines: 20,
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: EdgeInsets.all(8),
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.white, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.amber, width: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
