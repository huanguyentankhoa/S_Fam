import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../main_screen.dart';
class CreateDealComplete extends StatefulWidget {
  const CreateDealComplete({Key? key}) : super(key: key);

  @override
  _CreateDealCompleteState createState() => _CreateDealCompleteState();
}

class _CreateDealCompleteState extends State<CreateDealComplete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yrColor1,
      appBar: AppBar(
        backgroundColor: yrColor1,
        centerTitle: true,
        elevation: 0,
        leading: Container(),
        title: Text(
          "Khởi tạo Deal",
          style: kText18Bold_3,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          height: MediaQuery.of(context).size.height-200.h,
          child: Column(
            children: [
              Container(
                height: 190.h,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                decoration: BoxDecoration(
                  color: yrColor4,
                  borderRadius: BorderRadius.circular(10.h)
                ),
                child: Text("Hồ sơ tài sản của bạn đã được tiếp nhận. "
                    "Vui lòng đợi bộ phận thẩm định kiểm tra",style: kText20_1,),
              ),
              Expanded(child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child:    InkWell(
                  onTap: (){
                    Navigator.popUntil(context, (route){
                      return route.settings.name == "/9f580fc5-c252-45d0-af25-9429992db112";
                    });
                  },
                  child: Container(
                    height: 48.h,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
                    decoration: BoxDecoration(
                        color: yrColor4,
                        borderRadius: BorderRadius.circular(15.h)
                    ),
                    alignment: Alignment.center,
                    child: Text("DANH SÁCH DEAL",style: kText16Bold_1,),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
