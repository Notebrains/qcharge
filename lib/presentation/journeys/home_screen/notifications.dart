import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qcharge_flutter/data/core/api_constants.dart';
import 'package:qcharge_flutter/data/data_sources/authentication_local_data_source.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:http/http.dart' as http;


class NotificationsScreen extends StatefulWidget {


  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late Future<bool> _future;
  late bool isDataAvailable = false;
  late List<dynamic> notifications = [];

  @override
  void initState() {
    super.initState();
    _future = getNotifications();

  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> getNotifications()async{
    String? userId = await AuthenticationLocalDataSourceImpl().getSessionId();
    try{
      http.Response response = await http.get(Uri.parse("https://mridayaitservices.com/demo/qcharge/api/v1/notification/"+ userId!),);
      //print("${ApiConstants.BASE_URL}notification/1");
      //print("notification: ${response.statusCode}");
      print("notification: ${response.body}");

      if(response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        notifications = data["response"];
        if(notifications.length > 0)
          isDataAvailable = true;
      }
    } catch(error){
       print("notification: $error");
    }
    return isDataAvailable;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: AppColor.grey,
        child: FutureBuilder(
          future: _future,
          builder: (context, snapShot){
            if(snapShot.hasData){
              if(isDataAvailable){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: List.generate(notifications.length, (index) => Card(
                      color: Colors.grey.shade800,
                      elevation: 1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: Text(notifications.elementAt(index)["title"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),)),
                                Text(notifications.elementAt(index)["time"] + "  " + notifications.elementAt(index)["date"], style: TextStyle( fontSize: 12, color: AppColor.app_txt_white),)
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 8),
                              child: Text(notifications.elementAt(index)["body"], style: TextStyle(color: AppColor.app_txt_white),),
                            )
                          ],
                        ),
                      ),
                    )),
                  ),
                );
              }
              else
                return Center(child: Text("No Notifications to show!"));
            }else
              return Center(child: CircularProgressIndicator(
                color: Colors.amber,
              ));
          },
        ),
      ),
    );
  }
}