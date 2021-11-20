import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/common_fun.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/data/models/home_banner_api_res_model.dart';
import 'package:qcharge_flutter/di/get_it.dart';
import 'package:qcharge_flutter/presentation/blocs/home/home_card_cubit.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:qcharge_flutter/presentation/widgets/cached_net_img_radius.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/presentation/widgets/no_data_found.dart';

import 'home_card_details.dart';


class HomeCards extends StatefulWidget{
  final String screenTitle;
  final String urlEndpoint;

  const HomeCards({Key? key, required this.screenTitle, required this.urlEndpoint}) : super(key: key);

  @override
  State<HomeCards> createState() => _HomeCardsState();
}

class _HomeCardsState extends State<HomeCards> {
  late HomeCardCubit _homeCardCubit;

  @override
  void initState() {
    super.initState();

    _homeCardCubit = getItInstance<HomeCardCubit>();
    _homeCardCubit.initiateHomeCard(widget.urlEndpoint);
  }

  @override
  void dispose() {
    super.dispose();

    _homeCardCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarIcBack(context, widget.screenTitle),
      body:  BlocProvider<HomeCardCubit>(
        create: (context) => _homeCardCubit,
        child: BlocBuilder<HomeCardCubit, HomeCardState>(
            bloc: _homeCardCubit,
            builder: (context, state) {
              if (state is HomeCardSuccess) {
                return Container(
                  margin: EdgeInsets.only(left: 16, right: 16,),
                  padding: EdgeInsets.only(top: 5),
                  child: ListView.builder(
                    itemCount: state.model.response!.length,
                    itemBuilder: (context, position) {
                      return InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 36),
                              child: Text(
                                parseHtmlString(state.model.response![position].title!),
                                style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
                                maxLines: 4,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 12, bottom: 14),
                              child: Text(
                                parseHtmlString(state.model.response![position].body!),
                                style: TextStyle(fontSize: 13, color: AppColor.app_txt_white),
                                maxLines: 4,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only( bottom: 12),
                              child: cachedNetImgWithRadius(state.model.response![position].image!, double.infinity, Sizes.dimen_70.h, 4),
                            ),
                          ],
                        ),

                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomeCardDetails(response: state.model.response![position],),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              } else {
                return NoDataFound(txt: TranslationConstants.loadingCaps.t(context), onRefresh: (){});
              }


            }),
      ),
    );
  }
}