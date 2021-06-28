import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:youreal/view_models/app_model.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Widget imageContainer(String link) {
    if (link.contains('http://') || link.contains('https://')) {
      return Image.network(
        link,
        fit: BoxFit.fill,
      );
    }
    return Image.asset(
      "assets/$link",
      fit: BoxFit.fill,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    return SafeArea(
      child: Drawer(
        child: Container(
          color: yrColor1,
          height: MediaQuery.of(context).size.height-150.h,
          child: Column(
            children: [
              Container(
                height: 112.h,
                margin: EdgeInsets.only(top: 16.h,left: 15),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: yrColor3)
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 65.h,
                          width: 65.h,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child:
                              ClipOval(child: imageContainer("images/avatar.png")),
                        ),
                        Container(
                          height: 15.h,
                          width: 15.h,
                          margin: EdgeInsets.only(top: 2,right: 2),
                          decoration: BoxDecoration(
                            color:yrColor16,
                            shape: BoxShape.circle
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                      height: 65.h,
                      alignment: Alignment.center,
                      child: Text(
                        "Nguyễn Thị B",
                        style: kText18_3,

                      ),
                    ),

                  ],
                ),
              ),

              SizedBox(height: 27.h,),

              ///Thông tin cá nhân
              InkWell(
                onTap: (){},
                child: Container(
                  height: 65.h,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 40.w),
                  child: Text("THÔNG TIN CÁ NHÂN",style: kText16_3,),
                ),
              ),
              SizedBox(height: 20.h,),


              ///Lịch sử
              InkWell(
                onTap: (){},
                child: Container(
                  height: 65.h,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 40.w),
                  child: Text("LỊCH SỬ",style: kText16_3,),
                ),
              ),
              SizedBox(height: 20.h,),

              ///Lưu deal nháp
              InkWell(
                onTap: (){},
                child: Container(
                  height: 65.h,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 40.w),
                  child: Text("LƯU DEAL NHÁP",style: kText16_3,),
                ),
              ),
              SizedBox(height: 20.h,),

              ///Đề nghị vai trò
              InkWell(
                onTap: (){},
                child: Container(
                  height: 65.h,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 40.w),
                  child: Text("ĐỀ NGHỊ VAI TRÒ",style: kText16_3,),
                ),
              ),


              InkWell(
                onTap: (){},
                child: Container(
                  height: 20.h,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 70.w),
                  child: Text("Leader",style: kText16_3,),
                ),
              ),
              SizedBox(height: 20.h,),


              InkWell(
                onTap: (){},
                child: Container(
                  height: 20.h,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 70.w),
                  child: Text("Người thẩm định",style: kText16_3,),
                ),
              ),
              SizedBox(height: 20.h,),

              Expanded(
                child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: InkWell(
                    onTap: () {
                      appModel.logout();
                    },
                    child: Container(
                      height: 90.h,
                      padding: EdgeInsets.only(bottom: 30.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: AlignmentDirectional.center,
                            height: 30.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                              color: yrColor3,
                              shape: BoxShape.circle
                            ),
                            child: Icon(Icons.arrow_back,color: yrColor1,size: 15,),
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Text(
                          "ĐĂNG XUẤT",
                            style: kText16_3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
