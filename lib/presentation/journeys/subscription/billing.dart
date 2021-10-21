import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/common_fun.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/di/get_it.dart';
import 'package:qcharge_flutter/presentation/blocs/home/bill_cubit.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:qcharge_flutter/presentation/widgets/no_data_found.dart';


class Billing extends StatefulWidget {
  final String userId;

  const Billing({Key? key, required this.userId}) : super(key: key);

  @override
  _BillingState createState() => _BillingState();
}

class _BillingState extends State<Billing> {
  late BillCubit billCubit;

  @override
  void initState() {
    super.initState();
    billCubit = getItInstance<BillCubit>();
    billCubit.initiateBill('1');
  }

  @override
  void dispose() {
    super.dispose();

    billCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarIcBack(context, 'Your Billing'),
      body:  BlocProvider<BillCubit>(
        create: (context) => billCubit,
        child: BlocBuilder<BillCubit, BillState>(
          builder: (BuildContext context, state) {
            if (state is BillSuccess) {
              //print('---- : ${state.model.response![0].image}');
              return Column(
                children: [
                  Container(
                    height: 160,
                    margin: EdgeInsets.all(12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColor.grey,
                      border: Border.all(color: AppColor.border, width: 0.3),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    child: InkWell(
                      onTap: (){

                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'total spend',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14, ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: RichText(
                              text: TextSpan(
                                text: '',
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(text: convertStrToDoubleStr(state.model.response!.totalBilling.toString()),
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34, color: Colors.white)),
                                  TextSpan(text: ' THB',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white)),
                                ],
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 8, bottom: 6),
                            child: RichText(
                              text: TextSpan(
                                text: 'from  ',
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(text: state.model.response!.startDate!,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),

                                  TextSpan(text: '  to  ',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),

                                  TextSpan(text: state.model.response!.endDate!,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                                 ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(left: 12, right: 12,),
                    padding: const EdgeInsets.fromLTRB(6, 8, 6, 8),
                    decoration: BoxDecoration(
                      color: AppColor.grey,
                      border: Border.all(color: AppColor.border, width: 0.3),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(6),
                          child: Text(
                            'Date',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              letterSpacing: 0.2,
                              height: 1.3,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(6),
                          child: Text(
                            'Time',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              letterSpacing: 0.2,
                              height: 1.3,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(6),
                          child: Text(
                            'Duration',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              letterSpacing: 0.2,
                              height: 1.3,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(6),
                          child: Text(
                            'Unit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              letterSpacing: 0.2,
                              height: 1.3,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(6),
                          child: Text(
                            'Price',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              letterSpacing: 0.2,
                              height: 1.3,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                      padding: const EdgeInsets.fromLTRB(6, 8, 6, 8),
                      decoration: BoxDecoration(
                        color: AppColor.grey,
                        border: Border.all(color: AppColor.border, width: 0.3),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: ListView.builder(
                        itemCount: state.model.response!.history!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(6),
                                child: Text(
                                  state.model.response!.history![index].date!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    letterSpacing: 0.2,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(6),
                                child: Text(
                                  state.model.response!.history![index].startTime!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    letterSpacing: 0.2,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(6),
                                child: Text(
                                  state.model.response!.history![index].duration!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    letterSpacing: 0.2,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(6),
                                child: Text(
                                  state.model.response!.history![index].unit!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    letterSpacing: 0.2,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(6),
                                child: Text(
                                  '${convertStrToDoubleStr(state.model.response!.history![index].price!)} THB',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    letterSpacing: 0.2,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return NoDataFound(txt: 'No Data Found', onRefresh: (){
              },);
            }
          },
        ),
      ),

      floatingActionButton: Visibility(
        visible: false,
        child: FloatingActionButton.extended(
          backgroundColor: AppColor.alert_color,
          label: Text('Download Invoice', style: TextStyle(color: AppColor.border, fontWeight: FontWeight.bold,),),
          icon: Icon(Icons.download_rounded, color: AppColor.border,),
          onPressed: () {

          },
        ),
      ),
    );
  }
}