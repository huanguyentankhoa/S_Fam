import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/models/event.dart';
import 'package:s_fam/view_models/user_provider.dart';
import 'package:s_fam/views/home/item.dart';

class ListEventScreen extends StatefulWidget {
  final List<EventModel> events;
  const ListEventScreen({Key? key,required this.events}) : super(key: key);

  @override
  _ListEventScreenState createState() => _ListEventScreenState();
}

class _ListEventScreenState extends State<ListEventScreen> {
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
                  itemCount: widget.events.length,
                  separatorBuilder: (context, index) {
                    return Container(
                      child: Divider(
                        height: 1,
                        color: textSecondary,
                      ),
                    );
                  },
                  itemBuilder: (context, index) {
                    EventModel event = widget.events[index];
                    return Container(
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      child: Item(
                        name: event.name,
                        date: event.date,
                        time: event.startTime,
                        sub: event.detail,
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
                  "Danh sách sự kiện",
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
