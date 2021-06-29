import 'package:flutter/material.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
class AlbumItem extends StatelessWidget {
  final idCreator;
  final nameItem;
  final numberImage;
  const AlbumItem({Key? key, this.idCreator, this.nameItem, this.numberImage}) : super(key: key);

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
                Image.asset("assets/images/image2.png",fit: BoxFit.fill,),
                Container(
                  height: 24,
                  width: 24,
                  margin: EdgeInsets.only(bottom: 2,left: 2),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: primaryMain)
                  ),
                  child: Image.asset("assets/images/Ellipse873.png",fit: BoxFit.fill,),

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
                Text(nameItem, style: kText14BlackBold,),
                SizedBox(height: 12,),
                Container(
                  height: 42,
                  child: Text("$numberImage ảnh",style: kText14Black,),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
