import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/common/constants/languages.dart';
import 'package:qcharge_flutter/presentation/journeys/home_screen/home_card.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';

import '../../../common/constants/route_constants.dart';
import '../../../common/constants/size_constants.dart';
import '../../../common/constants/translation_constants.dart';
import '../../../common/extensions/size_extensions.dart';
import '../../../common/extensions/string_extensions.dart';
import '../../blocs/language/language_cubit.dart';
import '../../blocs/login/login_cubit.dart';
import '../../themes/theme_color.dart';
import '../../widgets/app_dialog.dart';
import '../../widgets/logo.dart';
import 'navigation_list_item.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer();

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(Sizes.dimen_40.w, 36, 24, 36),
          margin: EdgeInsets.only(top: statusBarHeight),
          color: AppColor.grey,
          width: Sizes.dimen_350.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12, bottom: 5),
                child: Txt(
                  txt: TranslationConstants.hello.t(context),
                  txtColor: Colors.white,
                  txtSize: 24,
                  fontWeight: FontWeight.bold,
                  padding: 0,
                  onTap: () {},
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteList.update_profile);
                },
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black,
                  primary: AppColor.border,
                  minimumSize: Size(180, 30),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
                child: Txt(
                  txt: TranslationConstants.updateProfile.t(context),
                  txtColor: Colors.black,
                  txtSize: 13,
                  fontWeight: FontWeight.bold,
                  padding: 0,
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteList.update_profile);
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(
              left: Sizes.dimen_24.w,
            ),
            width: Sizes.dimen_350.w,
            color: Colors.black,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                NavigationListItem(
                  title: TranslationConstants.home.t(context),
                  onPressed: () {
                    Navigator.of(context).pushNamed(RouteList.home_screen);
                  },
                ),

                NavigationListItem(
                  title: TranslationConstants.newsAndUpdate.t(context),
                  onPressed: () {
                    //Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeCards(
                          screenTitle: TranslationConstants.newsAndUpdate.t(context),
                          urlEndpoint: 'news', //change here
                        ),
                      ),
                    );
                  },
                ),
                NavigationListItem(
                  title: TranslationConstants.subscribePlan.t(context),
                  onPressed: () {
                    //Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(RouteList.subscription);
                  },
                ),
                NavigationListItem(
                  title: TranslationConstants.faq.t(context),
                  onPressed: () {
                    Navigator.of(context).pushNamed(RouteList.faq);
                  },
                ),

                BlocListener<LoginCubit, LoginState>(
                  listenWhen: (previous, current) => current is LogoutSuccess,
                  listener: (context, state) {
                    Navigator.of(context).pushNamedAndRemoveUntil(RouteList.initial, (route) => false);
                  },
                  child: NavigationListItem(
                    title: TranslationConstants.logout.t(context),
                    onPressed: () {
                      BlocProvider.of<LoginCubit>(context).logout();
                    },
                  ),
                ),

                /*
                NavigationListItem(
                  title: TranslationConstants.setting.t(context),
                  onPressed: () {
                    Navigator.of(context).pushNamed(RouteList.setting);
                  },
                ),

                 NavigationExpandedListItem(
                  title: TranslationConstants.language.t(context),
                  children: Languages.languages.map((e) => e.value).toList(),
                  onPressed: (index) => _onLanguageSelected(index, context),
                ),


                NavigationListItem(
                  title: 'Map',
                  onPressed: () {
                    //Navigator.of(context).pushNamed(RouteList.favorite);
                  },
                ),


                NavigationListItem(
                  title: 'Top Up',
                  onPressed: () {
                    Navigator.of(context).pop();
                    //_showDialog(context);
                  },
                ),

                NavigationListItem(
                  title: 'Profile',
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(RouteList.profile);

                  },
                ),




                BlocBuilder<ThemeCubit, Themes>(builder: (context, theme) {
                  return Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                      icon: Icon(
                        theme == Themes.dark
                            ? Icons.brightness_4_sharp
                            : Icons.brightness_7_sharp,
                        color: context.read<ThemeCubit>().state == Themes.dark
                            ? Colors.white
                            : AppColor.primary_color,
                        size: Sizes.dimen_40.w,
                      ),
                    ),
                  );
                }),*/
              ],
            ),
          ),
        ),
        Container(
          color: Colors.black,
          width: Sizes.dimen_350.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: Sizes.dimen_50.w,
                  top: Sizes.dimen_8.h,
                ),
                child: Logo(
                  height: Sizes.dimen_16.h,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Sizes.dimen_40.w,
                  top: 5,
                  bottom: Sizes.dimen_50.h,
                ),
                child: Txt(
                  txt: 'Q CHARGE',
                  txtColor: Colors.white,
                  txtSize: 16,
                  fontWeight: FontWeight.normal,
                  padding: 0,
                  onTap: () {},
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void _onLanguageSelected(int index, BuildContext context) {
    BlocProvider.of<LanguageCubit>(context).toggleLanguage(
      Languages.languages[index],
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AppDialog(
        title: TranslationConstants.about,
        description: TranslationConstants.aboutDescription,
        buttonText: TranslationConstants.okay,
        image: Image.asset(
          'assets/icons/pngs/account_register_2.png',
          height: Sizes.dimen_32.h,
        ),
      ),
    );
  }
}
