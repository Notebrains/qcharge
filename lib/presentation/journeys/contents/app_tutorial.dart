import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qcharge_flutter/presentation/widgets/appbar_ic_back.dart';


class AppTutorial extends StatefulWidget {
  @override
  _AppTutorialState createState() => _AppTutorialState();
}

class _AppTutorialState extends State<AppTutorial> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarIcBack(context, ""),
      body: InteractiveViewer(
        panEnabled: true, // Set it to false to prevent panning.
        minScale: 0.5,
        maxScale: 4,
        child: Image.asset('assets/images/app_tutorial_img.jpeg', fit: BoxFit.cover,),
      ),
    );
  }
}