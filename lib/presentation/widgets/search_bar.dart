import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';

class SearchBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SlideInDown(
      child: Container(
        height: 55,
        margin: const EdgeInsets.fromLTRB(16, 22, 16, 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [BoxShadow(color: Colors.grey.shade400, spreadRadius: 0, blurRadius: 3),],
        ),
        child: ListTile(
          leading: Icon(Icons.search),
          title: TextField(
            //controller: controller,
            decoration: InputDecoration(
              hintText: 'Search anything...',
              border: InputBorder.none,
              enabledBorder: InputBorder.none
            ),
            //onChanged: onSearchTextChanged,
          ),
          trailing: Visibility(
            //visible: controller.text.isNotEmpty,
            child: IconButton(
              icon: Icon(Icons.close_rounded),
              onPressed: () {
                //controller.clear();
                //onSearchTextChanged('');
              },
            ),
          ),
        ),
      ),
    );
  }
}