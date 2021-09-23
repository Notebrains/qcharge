import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/di/get_it.dart';
import 'package:qcharge_flutter/domain/usecases/faq_usecase.dart';
import 'package:qcharge_flutter/presentation/blocs/contents/faq_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/loading/loading_cubit.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/no_data_found.dart';
import 'faq_model.dart';

class Faqs extends StatefulWidget {
  @override
  _FaqsState createState() => _FaqsState();
}

class _FaqsState extends State<Faqs> {
  late FaqCubit faqCubit;

  @override
  void initState() {
    super.initState();
    faqCubit = getItInstance<FaqCubit>();

  }

  @override
  void dispose() {
    super.dispose();

    faqCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context),
      body:  BlocProvider<FaqCubit>(
        create: (context) => faqCubit,
        child: BlocBuilder<FaqCubit, FaqState>(
          builder: (BuildContext context, state) {
            if (state is FaqSuccess) {
              //print('---- : ${state.model.response![0].image}');
              return Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 24),
                      child: Text(
                        TranslationConstants.faqFullForm.t(context),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColor.app_txt_amber_light,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                    Expanded(
                      child: ListView.builder(
                        itemCount: itemData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ExpansionPanelList(
                            animationDuration: Duration(milliseconds: 700),
                            dividerColor: AppColor.app_txt_amber_light,
                            elevation: 16,
                            children: [
                              ExpansionPanel(
                                isExpanded: itemData[index].expanded,
                                body: Container(
                                  padding: EdgeInsets.fromLTRB(16, 0, 16, 24),
                                  child: Text(
                                    itemData[index].description,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        letterSpacing: 0.2,
                                        height: 1.3),
                                  ),
                                ),
                                headerBuilder: (BuildContext context, bool isExpanded) {
                                  return Container(
                                    padding: EdgeInsets.fromLTRB(12, 5, 12, 0),
                                    child: Text(
                                      itemData[index].headerItem,
                                      style: TextStyle(
                                        color: itemData[index].colorsItem,
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
                            expansionCallback: (int item, bool status) {
                              setState(() {
                                itemData[index].expanded = !itemData[index].expanded;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return NoDataFound(txt: 'No Data Found', onRefresh: (){
              },);
            }
          },
        ),
      ),
    );
  }

  List<ItemModel> itemData = <ItemModel>[
    ItemModel(
        headerItem: 'What is Q Charge?',
        description:
        "Android is a mobile operating system based on a modified version of the Linux kernel and other open source software, designed primarily for touchscreen mobile devices such as smartphones and tablets. ... Some well known derivatives include Android TV for televisions and Wear OS for wearables, both developed by Google.",
        colorsItem: AppColor.app_txt_amber_light,
        img: 'assets/icons/pngs/account_register_2.png'
    ),

    ItemModel(
        headerItem: 'What is Flutter?',
        description:
        "Flutter is Google’s portable UI toolkit for crafting beautiful, natively compiled applications for mobile, web, and desktop from a single codebase. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source.",
        colorsItem: AppColor.app_txt_amber_light,
        img: 'assets/icons/pngs/account_register_2.png'
    ),

    ItemModel(
        headerItem: 'Who is Flutter for?',
        description:
        "For developers, Flutter lowers the bar to entry for building apps. It speeds app development and reduces the cost and complexity of app production across platforms.",
        colorsItem: AppColor.app_txt_amber_light,
        img: 'assets/icons/pngs/account_register_2.png'
    ),

    ItemModel(
        headerItem: 'What makes Flutter unique?',
        description:
        "Flutter is different than most other options for building mobile apps because it doesn’t rely on web browser technology nor the set of widgets that ship with each device.",
        colorsItem: AppColor.app_txt_amber_light,
        img: 'assets/icons/pngs/account_register_2.png'
    ),

    ItemModel(
        headerItem: 'Who uses Flutter?',
        description:
        "Developers inside and outside of Google use Flutter to build beautiful natively-compiled apps for iOS and Android. To learn about some of these apps, visit the showcase.",
        colorsItem: AppColor.app_txt_amber_light,
        img: 'assets/icons/pngs/account_register_2.png'
    ),

    ItemModel(
        headerItem: 'What kinds of apps can I build with Flutter?',
        description:
        "Apps that need to deliver highly branded designs are particularly well suited for Flutter. However, you can also create pixel-perfect experiences that match the Android and iOS design languages with Flutter.",
        colorsItem: AppColor.app_txt_amber_light,
        img: 'assets/icons/pngs/account_register_2.png'
    ),

  ];
}