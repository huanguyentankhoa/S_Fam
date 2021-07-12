import 'package:flutter/material.dart';
import 'package:s_fam/common/config.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/common/tools.dart';
import 'package:s_fam/models/album.dart';

class AlbumItem extends StatelessWidget {
  final Album album;

  const AlbumItem({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
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
                      child: album.listImage.isNotEmpty
                          ? Tools().getImage("${serverConfig["url"]}" +
                              "api/v1/image/download?path=album/${album.id}&name=${album.listImage.first}")
                          : Image.asset(
                              "assets/images/image2.png",
                              fit: BoxFit.fill,
                            ),
                    )),
                Container(
                  height: 24,
                  width: 24,
                  margin: EdgeInsets.only(bottom: 2, left: 2),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: primaryMain)),
                  child: ClipOval(
                    child: album.owner.avatarUrl != null &&
                            album.owner.avatarUrl != ""
                        ? Tools().getImage("${serverConfig["url"]}" +
                            "api/v1/image/${album.owner.email}/avt/download")
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
                  album.name,
                  style: kText14BlackBold,
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  height: 42,
                  child: Text(
                    "${album.listImage.length} ảnh",
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
