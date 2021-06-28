import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youreal/model/chat.dart';
import 'package:youreal/view_models/chat/chat_provider.dart';
import 'package:youreal/views/chat/chat_item.dart';
import 'package:youreal/views/menu/menu.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _key = GlobalKey<ScaffoldState>();

  List<GroupChat> _listGroupChat = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listGroupChat =
        Provider.of<ChatProvider>(context, listen: false).listGroupChat;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool result = await showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Container(
                  height: 60,
                  color: yrColor4,
                  alignment: Alignment.center,
                  child: Text(
                    "Bạn chắc chắn muốn thoát?",
                    style: kText16Bold_1,
                  )),
              actions: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: Text(
                        "THOÁT",
                        style: kText16Bold_5,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context, false);
                      },
                      child: Text(
                        "HỦY",
                        style: kText16Bold_1,
                      ),
                    )
                  ],
                )
              ],
            ));
        return result;
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
              "Chat",
              style: kText18Bold_3,
            ),
          ),
        ),
        body: ListView.separated(
          itemCount: _listGroupChat.length,
          padding: EdgeInsets.only(left: 10.w,right: 10.w,bottom: 50.w),
          itemBuilder: (_, index) {
            return ChatItem(_listGroupChat[index]);
          },
          separatorBuilder: (_, index) {
            return SizedBox(
              height: 5,
            );
          },
        ),
      ),
    );
  }
}
