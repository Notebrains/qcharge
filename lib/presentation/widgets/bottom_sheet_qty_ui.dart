
import 'package:flutter/material.dart';

import 'button.dart';
import 'txt_input_field.dart';

showBottomSheetUi(BuildContext context) {
  showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter state) {
          return Container(
            height: 350,
            padding: EdgeInsets.only(bottom: 26, left: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(35.0),
                topLeft: Radius.circular(35.0),
              ),

              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 24,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 26, bottom: 16),
                  child: Text(
                    "Change Quantity",
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle( fontWeight: FontWeight.bold, fontSize: 28, color: Colors.black87),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey[300],
                  ),
                ),


                TxtIf(
                  txt: 'Quantity',
                  initialTxtValue: '',
                  hint: 'Enter qty here',
                  icon: null,
                  isReadOnly: false,
                  textInputType: TextInputType.text,
                  //validator: validator,
                  //onSaved: onSaved,
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 32, 20.0, 0),
                  child: Button(text: 'SUBMIT',
                    bgColor: Colors.amber, onPressed: () {

                  },),
                ),
              ],
            ),
          );
        });
      });
}