import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/view_models/user_provider.dart';
import 'package:s_fam/views/home/storage/account/acccout.dart';
import 'package:s_fam/views/home/storage/account/add_item_account.dart';
import 'package:s_fam/views/home/storage/account/pin_code%20_account.dart';
import 'package:s_fam/views/home/storage/album/album.dart';
import 'package:s_fam/views/home/storage/home_items/add_item.dart';
import 'package:s_fam/views/home/storage/home_items/home_items.dart';
import 'package:s_fam/widgets/text_input.dart';

import '../../menu.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context);
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
                height: 20,
                color: Color(0xFFC8C9CD),
                child: TabBar(
                  controller: _controller,
                  indicator: BoxDecoration(
                    color: primaryMain,
                  ),
                  onTap: (index) async {
                    // if (index == 1) {
                    //   setState(() {
                    //     _controller.index = 0;
                    //   });
                    //   var result = await showDialog(
                    //     context: context,
                    //     builder: (context) => PinCodeAccount(),
                    //   );
                    //   if (result != null && result)
                    //     setState(() {
                    //       _controller.index = index;
                    //     });
                    // }
                  },
                  unselectedLabelStyle: kText14Black,
                  unselectedLabelColor: Colors.black,
                  labelStyle: kText14White,
                  tabs: [
                    Tab(
                      text: "Vật dụng",
                    ),
                    Tab(
                      text: "Tài khoản",
                    ),
                    Tab(
                      text: "Album ảnh",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _controller,
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
                            "Vui lòng nhập mã pin để truy cập",
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
                                fail: (){}
                              );
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
              setState(() {

              });
            }
          },
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
