import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/models/work.dart';
import 'package:s_fam/view_models/user_provider.dart';

import 'item.dart';

class ListWorkScreen extends StatefulWidget {
  final List<Work> works;
  const ListWorkScreen({Key? key,required this.works}) : super(key: key);

  @override
  _ListWorkScreenState createState() => _ListWorkScreenState();
}

class _ListWorkScreenState extends State<ListWorkScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _appBarBuild(),
            Expanded(
              child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.works.length,
                  separatorBuilder: (context, index) {
                    return Container(
                      child: Divider(
                        height: 1,
                        color: textSecondary,
                      ),
                    );
                  },
                  itemBuilder: (context, index) {
                    Work work = widget.works[index];
                    return Container(
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      child: Item(
                        name: work.name,
                        date: work.startDay,
                        time: work.startTime,
                        sub: work.detail,
                      ),
                    );
                  })
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBarBuild() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 80,
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(left: 16),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/back.svg",
                  color: Colors.black,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Danh sách công việc",
                  style: kText20BlackBold,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
