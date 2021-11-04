import 'package:flutter/material.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';

class VoucherCodeUi extends StatelessWidget {

  final String hint;
  final String applyBtnTxt;
  final TextInputType textInputType;
  final Function(String) onSaved;
  final Function onTap;
  final Function onIconTap;
  final TextEditingController controller;

  const VoucherCodeUi({
    Key? key,
    required this.hint,
    required this.applyBtnTxt,
    required this.textInputType,
    required this.onSaved,
    required this.onTap,
    required this.onIconTap,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)), color: AppColor.grey,
          boxShadow: [
            BoxShadow(
              color: Colors.white60,
              blurRadius: 1.0,
            ),
      ]),
      margin: EdgeInsets.fromLTRB(5.0, 8, 5.0, 12),
      padding: EdgeInsets.only(left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: (){onIconTap();},
            icon: Icon(Icons.playlist_add,size: 30, color: AppColor.border,),
          ),
          Expanded(
            child: TextFormField(
              enabled: true,
              autocorrect: true,
              keyboardType: textInputType,
              controller: controller,
              onFieldSubmitted: (value){
                onSaved(value);
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                filled: true,
                fillColor: AppColor.grey,
              ),
            ),
          ),


          InkWell(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
              width: 65,
              height: 55,
              decoration: BoxDecoration(
                color: AppColor.border,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Text(applyBtnTxt,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            onTap: (){
              onTap();
            },
          ),

          Visibility(
            visible: applyBtnTxt == 'APPLIED',
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(Icons.check_circle_outline_rounded,size: 26, color: AppColor.border,),
            ),
          ),
        ],
      ),
    );
  }
}
