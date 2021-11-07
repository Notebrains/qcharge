import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/common/constants/languages.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/presentation/blocs/language/language_cubit.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';

PreferredSizeWidget appBarHome(BuildContext context) {
  final ValueNotifier<String> _langValueLister = ValueNotifier<String>('EN');
  return AppBar(
    toolbarHeight: Sizes.dimen_70.w,
    title: Image.asset('assets/icons/pngs/q_charge_logo_1.png', fit: BoxFit.cover, width: 30),
    centerTitle: true,
    backgroundColor: AppColor.grey,
    elevation: 3,
    actions: <Widget>[
      Icon(
          Icons.language,
          size: 22,
      ),

      ValueListenableBuilder(
        builder: (context, String lang, child) {
          print('----Language 1: $lang');
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 12, bottom: 5),
              child: PopupMenuButton<String>(
                icon: Center(
                  child: Text(lang, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),),
                ),
                onSelected: (value) {
                  //print('----Language 2: $value');
                  value == 'EN' ? _onLanguageSelected(0, context) : _onLanguageSelected(1, context);
                  _langValueLister.value = value;
                },
                itemBuilder: (BuildContext context) {
                  return {'EN', 'TH' }.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: ListTile(
                        leading: Image.asset(
                          choice == 'TH' ? 'assets/icons/pngs/account_register_3.png' : 'assets/icons/pngs/eng_lang.jpg',
                          fit: BoxFit.contain,
                          width: 20,
                          height: 40,
                        ),

                        title: Text(choice,
                          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: Colors.white),
                        ),
                      ),
                    );
                  }).toList();
                },
              ),
            ),
          );
        },
        valueListenable: _langValueLister,
      ),

    ],
  );
}


void _onLanguageSelected(int index, BuildContext context) {
  BlocProvider.of<LanguageCubit>(context).toggleLanguage(
    Languages.languages[index],
  );
}
