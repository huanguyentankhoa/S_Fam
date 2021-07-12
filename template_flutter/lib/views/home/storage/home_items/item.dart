import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:s_fam/common/config.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/common/tools.dart';
import 'package:s_fam/models/storage_item.dart';

class HomeItem extends StatelessWidget {
  final StorageItem item;

  const HomeItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            height: 75,
            width: 104,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  height: 75,
                  width: 104,
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: item.image != null
                        ? Tools().getImage("${serverConfig["url"]}" +
                        "api/v1/image/download?path=item/${item.id}&name=${item.image}")
                        : Image.asset(
                      "assets/images/image2.png",
                      fit: BoxFit.fill,
                    ),
                  )
                ),
                Container(
                  height: 24,
                  width: 24,
                  margin: EdgeInsets.only(bottom: 2, left: 2),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: primaryMain)),
                  child: ClipOval(
                    child: item.owner.avatarUrl != null &&
                            item.owner.avatarUrl != ""
                        ? Tools().getImage("${serverConfig["url"]}" +
                            "api/v1/image/${item.owner.email}/avt/download")
                        : Image.asset(
                            "assets/icons/logo.png",
                            fit: BoxFit.contain,
                          ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: kText14BlackBold,
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  height: 42,
                  child: Text(
                    item.detail,
                    style: kText14Black,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
