import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/di/get_it.dart';
import 'package:qcharge_flutter/presentation/blocs/contents/faq_cubit.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/no_data_found.dart';


class Faqs extends StatefulWidget {
  @override
  _FaqsState createState() => _FaqsState();
}

class _FaqsState extends State<Faqs> {
  late FaqCubit faqCubit;
  bool isExpanded = true;

  @override
  void initState() {
    super.initState();
    faqCubit = getItInstance<FaqCubit>();
    faqCubit.initiateFaq();
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
                        itemCount: state.model.response!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ExpansionPanelList(
                            animationDuration: Duration(milliseconds: 700),
                            dividerColor: AppColor.app_txt_amber_light,
                            elevation: 16,
                            children: [
                              ExpansionPanel(
                                isExpanded: isExpanded,
                                body: Container(
                                  padding: EdgeInsets.fromLTRB(16, 0, 16, 24),
                                  child: Text(
                                    state.model.response![index].answer!,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        letterSpacing: 0.2,
                                        height: 1.3,
                                    ),
                                  ),
                                ),
                                headerBuilder: (BuildContext context, bool isExpanded) {
                                  return Padding(
                                    padding: EdgeInsets.fromLTRB(12, 5, 12, 0),
                                    child: Text(
                                      state.model.response![index].question!,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
                            expansionCallback: (int item, bool status) {
                              setState(() {
                                //itemData[index].expanded = !itemData[index].expanded;
                                isExpanded? isExpanded = false : isExpanded = true;

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
              return NoDataFound(txt: TranslationConstants.loadingCaps.t(context), onRefresh: (){
              },);
            }
          },
        ),
      ),
    );
  }
}