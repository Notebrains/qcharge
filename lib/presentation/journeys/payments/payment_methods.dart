
import 'package:flutter/material.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';


final methodList = [
  PaymentMethodsModel('assets/images/credit2.png', 'Credit / Debit', true),
  PaymentMethodsModel('assets/images/truewallet.png', 'TrueMoney Wallet', false),
  //PaymentMethodsModel('assets/images/123download.png', '123 Payment', false),
];

class PaymentMethodsModel {
  final String image;
  final String paymentMethodName;
  final bool isSelected;

  PaymentMethodsModel(this.image, this.paymentMethodName, this.isSelected);
}

class PaymentMethods extends StatefulWidget {
  final Function (int paymentMthodId) onTap;

  const PaymentMethods({Key? key, required this.onTap}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PaymentMethodsState();
  }
}

class _PaymentMethodsState extends State <PaymentMethods> {
  bool isPaymentMethodSelected = false;
  int selectedIndex = -55;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBarIcBack(context, TranslationConstants.paymentMethod.t(context)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h, horizontal: 12),
              height: Sizes.dimen_230.w,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: List.generate(methodList.length, (i) =>
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.all(16),
                        padding: EdgeInsets.all(16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selectedIndex == i ? Colors.white24 : AppColor.grey,
                          border: Border.all(color: selectedIndex == i ? AppColor.border : Colors.white,),
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image(
                                  width: 60, height: 50,
                                  fit: BoxFit.cover,
                                  image: AssetImage(methodList[i].image),
                                ),
                              ),
                            ),

                            Txt(
                              txt: methodList[i].paymentMethodName,
                              txtColor: Colors.white,
                              txtSize: 14,
                              fontWeight: FontWeight.bold,
                              padding: 1,
                              onTap: () {},
                            ),

                            Visibility(
                                visible: selectedIndex == i,
                                child: Icon(Icons.check_circle, size: 25, color: Colors.white,)),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          selectedIndex = i;
                          isPaymentMethodSelected = true;
                        });
                      },
                    ),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 28, right: 28, top: 24),
              child: Button(
                text: TranslationConstants.continueNotCaps.t(context),
                bgColor: isPaymentMethodSelected ? [Color(0xFFEFE07D), Color(0xFFB49839)] : [Color(0xFFD7D3CB), Color(0xFFADADAD)],
                onPressed: () {
                  widget.onTap(selectedIndex);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

