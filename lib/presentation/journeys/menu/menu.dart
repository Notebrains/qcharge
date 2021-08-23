import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:qcharge_flutter/common/constants/route_constants.dart';
import 'package:qcharge_flutter/data/models/home_category_model.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/search_bar.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<HomeCategoryModel> categoryList = [];

  @override
  Widget build(BuildContext context) {
    addDataInModel();
    return Scaffold(
      body: Column(
        children: [
          SearchBar(),

          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: GridView.count(
                shrinkWrap: false,
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                physics: BouncingScrollPhysics(),
                children: List.generate(categoryList.length, (index) {
                  return InkWell(
                    child: SlideInUp(
                      child: Card(
                        elevation: 8,
                        color: Colors.white,
                        shadowColor: Colors.grey.withOpacity(0.2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                  width: 32,
                                  height: 18,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(right: 5, bottom: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade800,
                                    borderRadius: BorderRadius.circular(3.0),
                                  ),
                                  child: Txt(txt: categoryList[index].count, txtColor: Colors.white, txtSize: 11, fontWeight: FontWeight.normal, padding: 0, onTap: (){})),
                            ),

                            Icon(
                              categoryList[index].icon,
                              color: Colors.amber.shade600,
                              size: 55,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 20, bottom: 5),
                              child: Txt(
                                  txt: categoryList[index].category, txtColor: Colors.grey.shade600, txtSize: 16, fontWeight: FontWeight.bold, padding: 0, onTap: () {}),
                            ),

                            SizedBox(width: double.maxFinite,),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      openPage(context, categoryList[index].category);
                    },
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openPage(BuildContext context, String category) {
    switch (category) {
      case 'PRODUCT':
        //Navigator.of(context).pushNamed(RouteList.product);
        break;
      case 'REQUISITIONS':
        //Navigator.of(context).pushNamed(RouteList.requisitions);
        break;
      case 'PURCHASE ORDER':
        //Navigator.of(context).pushNamed(RouteList.purchase_order);
        break;
      case 'INVOICE':
        //Navigator.of(context).pushNamed(RouteList.invoice);
        break;
      case 'TRANSACTION':
        //Navigator.of(context).pushNamed(RouteList.transaction);
        break;
      case 'REVIEW':
        Navigator.of(context).pushNamed(RouteList.review);
        break;
    }
  }

  void addDataInModel() {
    categoryList.add(HomeCategoryModel(category: 'PRODUCT', icon: Icons.shopping_bag, count: '500'));
    categoryList.add(HomeCategoryModel(category: 'REQUISITIONS', icon: Icons.assignment_rounded, count: '10'));
    categoryList.add(HomeCategoryModel(category: 'PURCHASE ORDER', icon: Icons.account_tree_rounded, count: '15'));
    categoryList.add(HomeCategoryModel(category: 'INVOICE', icon: Icons.list_alt_rounded, count: '08'));
    categoryList.add(HomeCategoryModel(category: 'TRANSACTION', icon: Icons.account_balance_wallet_rounded, count: '08'));
    categoryList.add(HomeCategoryModel(category: 'REVIEW', icon: Icons.star_half_rounded, count: '800'));
  }
}
