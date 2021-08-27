import 'package:flutter/material.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';

import '../../../common/constants/size_constants.dart';
import '../../../common/extensions/size_extensions.dart';

class NavigationListItem extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const NavigationListItem({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, letterSpacing: 1, color: AppColor.app_txt_white),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(right: 24, top: 12),
          child: Divider(
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ),
    );
  }
}

class NavigationSubListItem extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const NavigationSubListItem({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.7),
              blurRadius: 2,
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: Sizes.dimen_32.w),
          title: Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ),
    );
  }
}
