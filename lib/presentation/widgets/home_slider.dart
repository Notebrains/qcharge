import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';
import 'package:qcharge_flutter/data/models/home_banner_api_res_model.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/cached_net_img_radius.dart';

final List<String> imgList = [];

class HomeSliderCarouselWithIndicator extends StatefulWidget {
  final HomeBannerApiResModel model;

  const HomeSliderCarouselWithIndicator({Key? key, required this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<HomeSliderCarouselWithIndicator> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    imgList.clear();
    for(int i =0; i<widget.model.response!.length; i++){
      imgList.add(widget.model.response![i].image!);
    }


    return Scaffold(
      body: Column(children: [
        Expanded(
          child: CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                aspectRatio: 3/2,
                viewportFraction: 1,
                initialPage: 0,
                enlargeCenterPage: false,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 24.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.border.withOpacity(_current == entry.key ? 1.0 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }

  final List<Widget> imageSliders = imgList
      .map((item) => cachedNetImgWithRadius(Strings.imgUrlMeeting, double.infinity, double.infinity, 5),

      /*ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Image.asset(item, fit: BoxFit.cover, width: double.infinity),
          ),*/
  )
      .toList();
}
