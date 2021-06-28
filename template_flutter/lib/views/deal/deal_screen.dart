import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youreal/routes/ui_pages.dart';
import 'package:youreal/view_models/app_model.dart';
import 'package:youreal/views/create_deal/create_deal.dart';
import 'package:youreal/views/deal/my_appraisal.dart';
import 'package:youreal/views/deal/my_deal.dart';
import 'package:youreal/views/deal/statistics_by_role.dart';
import 'package:youreal/views/deal/statistics_by_status.dart';
import 'package:youreal/views/menu/menu.dart';
class DealScreen extends StatefulWidget {
  const DealScreen({Key? key}) : super(key: key);

  @override
  _DealScreenState createState() => _DealScreenState();
}

class _DealScreenState extends State<DealScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    return WillPopScope(
      onWillPop: () async {
        // bool result = await showDialog(
        //     context: context,
        //     builder: (_) => AlertDialog(
        //       content: Container(
        //           height: 60,
        //           color: yrColor4,
        //           alignment: Alignment.center,
        //           child: Text(
        //             "Bạn chắc chắn muốn thoát?",
        //             style: kText16Bold_1,
        //           )),
        //       actions: [
        //         Row(
        //           children: [
        //             InkWell(
        //               onTap: () {
        //                 Navigator.pop(context, true);
        //               },
        //               child: Text(
        //                 "THOÁT",
        //                 style: kText16Bold_5,
        //               ),
        //             ),
        //             SizedBox(
        //               width: 20,
        //             ),
        //             InkWell(
        //               onTap: () {
        //                 Navigator.pop(context, false);
        //               },
        //               child: Text(
        //                 "HỦY",
        //                 style: kText16Bold_1,
        //               ),
        //             )
        //           ],
        //         )
        //       ],
        //     ));
        return true;
      },
      child: Scaffold(
        key: _key,
        backgroundColor: yrColor1,
        drawer: Menu(),
        appBar: AppBar(
          backgroundColor: yrColor1,
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              _key.currentState!.openDrawer();
            },
            child: Container(
              child: Icon(
                Icons.menu,
                color: yrColor4,
                size: 38.w,
              ),
            ),
          ),
          title: Container(
            alignment: Alignment.center,
            child: Text(
              "Deal",
              style: kText18Bold_3,
            ),
          ),
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // appModel.currentAction = PageAction(
                    //     state: PageState.addPage,
                    //     page: CreateDealConfig);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        settings: RouteSettings(name: '/createDeal'),
                        builder: (context) => CreateDealScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: 97.w,
                    height: 41.h,
                    margin: EdgeInsets.only(right: 14.w),
                    decoration: BoxDecoration(
                      color: yrColor4,
                      borderRadius: BorderRadius.circular(8.h)
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: yrColor1,
                          size: 25.w,
                        ),
                        Text("Tạo Deal",style: kText16Bold_1,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
             children: [
               SizedBox(
                 height: 40.h,
               ),
               StatisticsByRole(),
               SizedBox(
                 height: 28.h,
               ),
               StatisticsByStatus(),
               SizedBox(
                 height: 36.h,
               ),

               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text("Danh sách Deal của tôi",style: kText14Bold_4,),
                   InkWell(
                     onTap: (){},
                       child: Text("Xem toàn bộ",style: kText14_4,))
                 ],
               ),
               Container(
                   margin: EdgeInsets.only(top: 8.h),
                   child: MyDeal()),
               SizedBox(
                 height: 26.h,
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text("Danh sách Thẩm định của tôi",style: kText14Bold_4,),
                   InkWell(
                       onTap: (){},
                       child: Text("Xem toàn bộ",style: kText14_4,))
                 ],
               ),
               Container(
                 margin: EdgeInsets.only(top: 8.h),
                   child: MyAppraisal()),
               SizedBox(
                 height: 50.h,
               ),
             ],
            ),
          ),
        ),
      ),
    );
  }
}
