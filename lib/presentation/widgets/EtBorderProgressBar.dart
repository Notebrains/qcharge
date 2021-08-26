import 'package:flutter/material.dart';

class EtBorderProgressBar extends StatelessWidget {
  final String text;
  final double width;
  final Function onTap;

  const EtBorderProgressBar({
    Key? key,
    required this.text,
    required this.width,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width * 0.8,
      margin: EdgeInsets.only(left: 10, right: 10),
      padding: EdgeInsets.fromLTRB(16, 5, 10, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: Colors.grey.shade400 ),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.shade600),),
          ),
          Text(
            text,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.black87),
          ),

          InkWell(child: Icon(Icons.close, color: Colors.grey[600],), onTap: (){

          }),

        ],
      ),
    );
  }
}
