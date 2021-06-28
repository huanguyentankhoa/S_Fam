import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youreal/common/tools.dart';
import 'package:youreal/model/chat.dart';

class ChatItem extends StatefulWidget {
  final GroupChat groupChat;

  const ChatItem(this.groupChat, {Key? key}) : super(key: key);

  @override
  _ChatItemState createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  List<Widget> iconAvatarMember = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.groupChat.numberMember <= 4) {
      for (int i = 0; i < widget.groupChat.numberMember; i++) {
        iconAvatarMember.add(Container(
          height: 23.h,
          width: 23.h,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          child: ClipOval(
              child: getImage(
            "avatar.png",
            fit: BoxFit.fill,
          )),
        ));
      }
    } else {
      for (int i = 0; i < 4; i++) {
        iconAvatarMember.add(Container(
          height: 23.h,
          width: 23.h,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          child: ClipOval(
              child: getImage(
            "avatar.png",
            fit: BoxFit.fill,
          )),
        ));
      }
      iconAvatarMember.add(Container(
        height: 23.h,
        width: 23.h,
        decoration: BoxDecoration(color: yrColor1, shape: BoxShape.circle),
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        child: ClipOval(
            child: Text(
          "+${widget.groupChat.numberMember - 4}",
          style: kText10_4,
        )),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
          color: yrColor4, borderRadius: BorderRadius.circular(10.h)),
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  height: 49.h,
                  width: 49.h,
                  child: SvgPicture.asset(
                    getIcon("home.svg"),
                    color: yrColor1,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 90.w,
                  padding: EdgeInsets.only(left: 10.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.groupChat.name,
                                style: kText16Bold_2,
                              )),
                          Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "15:35",
                                style: kText10_1,
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.groupChat.message,
                                style: kText16Bold_2,
                              )),
                          if (widget.groupChat.numberMessageWait > 0)
                            Container(
                                alignment: Alignment.center,
                                width: 22.h,
                                height: 22.h,
                                decoration: BoxDecoration(
                                    color: yrColor5, shape: BoxShape.circle),
                                child: Text(
                                  widget.groupChat.numberMessageWait.toString(),
                                  style: kText10_4,
                                )),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(right: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: iconAvatarMember,
            ),
          )
        ],
      ),
    );
  }
}
