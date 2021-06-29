import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/models/storage_item.dart';
import 'package:s_fam/view_models/user_provider.dart';
import 'package:s_fam/views/home/storage/home_items/item.dart';
import 'package:s_fam/views/home/storage/search.dart';

class HomeItems extends StatefulWidget {
  const HomeItems({Key? key}) : super(key: key);

  @override
  _HomeItemsState createState() => _HomeItemsState();
}

class _HomeItemsState extends State<HomeItems> {
  late UserProvider user;
  String query = '';
  bool isSearch = false;
  List<StorageItem> listItems = [];
  List<StorageItem> listSearch = [];
  List<StorageItem> allItems = [];
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted)
        Provider.of<UserProvider>(context, listen: false).getListStorageItem(
            success: (value) {
          setState(() {
            allItems = value;
            listItems = value;
          });
        });
    });
  }

  searchItem(String query) {
    setState(() {
      isSearch = true;
    });
    final items = allItems.where((item) {
      final nameLower = item.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower);
    }).toList();

    if(query=='')
      setState(() {
        this.query = query;
        listItems = items;
        isSearch = false;
      });
    else
    setState(() {
      this.query = query;
      listSearch = items;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context);

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              height: 28,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color(0xFFE8EAED),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              margin: EdgeInsets.symmetric(vertical: 8),
              child: SearchWidget(
                  text: query, onChanged: searchItem, hintText: "Tìm kiếm"),
            ),
            if (isSearch&&listSearch.isEmpty)
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Text(
                  "Không có dữ liệu",
                  style: kSubText16BlackBold,
                ),
              ),
            if (isSearch&&listSearch.isNotEmpty)
              Expanded(
                  child: ListView.separated(
                      itemBuilder: (_, index) {
                        return HomeItem(
                          nameItem: listSearch[index].name,
                          note: listSearch[index].detail,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(top: 8, bottom: 16),
                          child: Divider(
                            height: 1,
                            color: textSecondary,
                          ),
                        );
                      },
                      itemCount: listSearch.length)),
            if (!isSearch && listItems.isEmpty)
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Text(
                  "Không có dữ liệu",
                  style: kSubText16BlackBold,
                ),
              ),
            if (!isSearch &&listItems.isNotEmpty)
              Expanded(
                  child: ListView.separated(
                      itemBuilder: (_, index) {
                        return HomeItem(
                          nameItem: listItems[index].name,
                          note: listItems[index].detail,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(top: 8, bottom: 16),
                          child: Divider(
                            height: 1,
                            color: textSecondary,
                          ),
                        );
                      },
                      itemCount: listItems.length)),
          ],
        ),
      ),
    );
  }
}
