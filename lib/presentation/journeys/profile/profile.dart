import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qcharge_flutter/common/constants/route_constants.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/cached_net_img_radius.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_input_field.dart';

class Profile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 24),
              child: cachedNetImgWithRadius(
                  Strings.imgUrlNotFoundYellowAvatar, 150,
                  150,
                  30,
              ),
            ),

            TxtIf(
              txt: 'Name',
              initialTxtValue: '',
              hint: 'Enter full name here',
              icon: Icons.person,
              isReadOnly: false,
              textInputType: TextInputType.text,
              //validator: validator,
              //onSaved: onSaved,
            ),

            TxtIf(
              txt: 'Email',
              initialTxtValue: '',
              hint: 'Enter email id here',
              icon: Icons.email,
              isReadOnly: false,
              textInputType: TextInputType.text,
              //validator: validator,
              //onSaved: onSaved,
            ),

            TxtIf(
              txt: 'Phone',
              initialTxtValue: '',
              hint: 'Enter phone number here',
              icon: Icons.call,
              isReadOnly: false,
              textInputType: TextInputType.text,
              //validator: validator,
              //onSaved: onSaved,
            ),

            TxtIf(
              txt: 'Gender',
              initialTxtValue: '',
              hint: 'Enter gender here',
              icon: Icons.assignment_ind_rounded,
              isReadOnly: false,
              textInputType: TextInputType.text,
              //validator: validator,
              //onSaved: onSaved,
            ),

            TxtIf(
              txt: 'DOB',
              initialTxtValue: '',
              hint: 'Enter date of birth here',
              icon: Icons.date_range_rounded,
              isReadOnly: false,
              textInputType: TextInputType.text,
              //validator: validator,
              //onSaved: onSaved,
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 24, 20.0, 0),
              child: Button(text: 'UPDATE', onPressed: () {  },),
            ),


            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
              child: Button(text: 'LOGOUT', onPressed: () {

                showDialog(
                    context: context,
                    builder: (BuildContext context) => CupertinoAlertDialog(
                      title: new Text("LOGOUT ?"),
                      content: new Text("Are you sure you want to logout?"),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text("Cancel", style: TextStyle(color: Colors.black87),),
                        ),

                        CupertinoDialogAction(
                          isDefaultAction: true,
                          onPressed: (){
                            Navigator.pop(context);
                            Navigator.of(context).pushNamed(RouteList.login);
                          },
                          child: Text('Logout', style: TextStyle(color: Colors.redAccent),),
                        ),
                      ],
                    )
                );
              },),
            ),
          ],
        ),
      ),
    );
  }
}