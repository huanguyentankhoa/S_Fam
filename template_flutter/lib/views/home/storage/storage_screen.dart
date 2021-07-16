import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/models/member.dart';
import 'package:s_fam/view_models/app_provider.dart';
import 'package:s_fam/view_models/user_provider.dart';
import 'package:s_fam/views/home/storage/account/acccout.dart';
import 'package:s_fam/views/home/storage/account/add_item_account.dart';
import 'package:s_fam/views/home/storage/account/create_pin_code.dart';
import 'package:s_fam/views/home/storage/album/album.dart';
import 'package:s_fam/views/home/storage/home_items/add_item.dart';
import 'package:s_fam/views/home/storage/home_items/home_items.dart';
import 'package:s_fam/widgets/text_input.dart';

import '../../menu.dart';
import 'account/pin_code _account.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({Key? key}) : super(key: key);

  @override
  _StorageScreenState createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen>
    with
        AutomaticKeepAliveClientMixin<StorageScreen>,
        SingleTickerProviderStateMixin {
  late TabController _controller;
  GlobalKey<ScaffoldState> _key = GlobalKey();

  TextEditingController addAlbum = TextEditingController();
  late UserProvider user;
  Member? member;
  bool isEnterPinCode = false;
  late AppProvider app;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    member = Provider.of<UserProvider>(context, listen: false).userCurrentLogin;
    if (Provider.of<AppProvider>(context, listen: false).fromMenu) {
      setState(() {
        _controller.index =
            Provider.of<AppProvider>(context, listen: false).tabStorageSelected;
        Provider.of<AppProvider>(context, listen: false).fromMenu = false;
        isEnterPinCode = true;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  void _onItemTap(int index) {
    setState(() {
      app.tabStorageSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context);
    app = Provider.of<AppProvider>(context);

    return SafeArea(
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 95,
          toolbarHeight: 80,
          leading: Container(
            margin: EdgeInsets.only(bottom: 10),
            alignment: Alignment.bottomRight,
            child: Text(
              "Lưu trữ",
              style: kText24BlackBold,
            ),
          ),
        ),
        drawer: Menu(),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                height: 25,
               // color: Color(0xFFC8C9CD),
                child: TabBar(
                  controller: _controller,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    color: primaryMain,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  onTap: (index) async {
                    _onItemTap(index);
                    if (index == 1 && !isEnterPinCode) {
                      setState(() {
                        _controller.index = 0;
                      });
                      if (user.userCurrentLogin.pinCode != null) {
                        var result = await showDialog(
                          context: context,
                          builder: (context) => PinCodeAccount(),
                        );
                        if (result != null && result)
                          setState(() {
                            _controller.index = index;
                            isEnterPinCode = true;
                          });
                      } else {
                        await showDialog(
                          context: context,
                          builder: (context) => CreatePinCode(
                            success: (pinCode) {
                              setState(() {
                                _controller.index = index;
                                isEnterPinCode = true;
                              });
                            },
                          ),
                        );
                      }
                    }
                  },
                  unselectedLabelStyle: kText14Black,
                  unselectedLabelColor: primaryMain,
                  labelStyle: kText14White,
                  tabs: [
                    Tab(
                     // text: "Vật dụng",
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: primaryMain, width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Vật dụng"),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: primaryMain, width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Tài khoản"),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: primaryMain, width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Album"),
                        ),
                      ),

                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _controller,
                  physics: NeverScrollableScrollPhysics(),
                  children: [HomeItems(), Account(), AlbumScreen()],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () async {
            if (_controller.index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddItem(),
                ),
              );
            }
            if (_controller.index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddItemAccount(),
                ),
              );
            }
            if (_controller.index == 2) {
              await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.transparent,
                  contentPadding: EdgeInsets.zero,
                  insetPadding: EdgeInsets.only(left: 10, right: 10),
                  titlePadding: EdgeInsets.zero,
                  content: Container(
                    height: 158,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            "Vui lòng nhập tên album của bạn:",
                            style: kText18BlueBold,
                          ),
                        ),
                        TextInput(
                            height: 48,
                            labelText: "Tên Album",
                            controller: addAlbum),
                      ],
                    ),
                  ),
                  actionsPadding: EdgeInsets.only(bottom: 22),
                  actions: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 52,
                              width: MediaQuery.of(context).size.width / 2 - 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                "Hủy bỏ",
                                style: kText16BlueBold,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              user.createAlbum(
                                  name: addAlbum.text,
                                  email: user.userCurrentLogin.email,
                                  success: () {
                                    Navigator.pop(context);
                                  },
                                  fail: () {});
                            },
                            child: Container(
                              height: 52,
                              width: MediaQuery.of(context).size.width / 2 - 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: primaryMain,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                "Lưu",
                                style: kText16WhiteBold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
              setState(() {});
            }
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
