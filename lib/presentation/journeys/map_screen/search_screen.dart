import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in.dart';
import 'package:qcharge_flutter/data/models/map_api_res_model.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Response> locationList;
  final Function(int index) onTap;

  CustomSearchDelegate({required this.locationList, required this.onTap,});


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      Visibility(
        visible: query.isNotEmpty,
        child: IconButton(
          icon: Icon(Icons.clear),
          color: Colors.white,
          onPressed: () {
            query = '';
          },
        ),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      /*
      // this ui called when pressed on keyboard search button
      child: ListView(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        scrollDirection: Axis.vertical,
        children: List.generate(locationList.length, (index) {
          return Card(
            //color: Colors.white,
            child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  locationList[index].stationName!,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
          );
        }),
      ),*/
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ? locationList : locationList.where((element) => element.stationName!.toLowerCase().startsWith(query)).toList();
    return FadeIn(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColor.grey,
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    child: suggestionList[index].type == 'Ac'?
                    Image.asset('assets/icons/pngs/map__type_1.png') :
                    Image.asset('assets/icons/pngs/map__type_12.png'),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(
                          '${suggestionList[index].stationName}  (Type-${suggestionList[index].type})',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color:  Colors.white),
                          maxLines: 8,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 3),
                        child: Text(
                          '${suggestionList[index].city}, ${suggestionList[index].state}, ${suggestionList[index].country}, ${suggestionList[index].zipcode},',
                          style: TextStyle( fontSize: 12, color: Colors.white),
                          maxLines: 8,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            onTap: () {
              onTap(index);
              close(context, null);
            },
          ),
          itemCount: suggestionList.length,
        ),
      ),
    );
  }
}
