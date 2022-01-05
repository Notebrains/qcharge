import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/extensions/common_fun.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/data/models/home_card_api_res_model.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/cached_net_img_radius.dart';


class HomeCardDetails extends StatelessWidget {
  final Response response;

  const HomeCardDetails({Key? key,required this.response}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.app_bg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            snap: false,
            pinned: false,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                margin: const EdgeInsets.fromLTRB(12, 42, 12, 12),
                child: FadeIn(
                  child: cachedNetImgWithRadius(response.image!, double.infinity, Sizes.dimen_150.h, 12),
                ),
              ),
            ),
            expandedHeight: Sizes.dimen_150.h,
            backgroundColor: AppColor.app_bg,
            leading: IconButton(
              icon: const Padding(
                padding: EdgeInsets.all(22.0),
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              tooltip: 'Back to previous page',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(_buildList(context)),
          )
        ],
      ),
    );
  }

  List<Widget> _buildList(BuildContext context) {
    List<Widget> listItems = [];
    listItems.add(
      Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 24, right: 24, top: 8),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              response.title!,
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: AppColor.border),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12, 8, 16, 16),
              child: Text(
                parseHtmlString(response.body!),
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );

    return listItems;
  }
}
