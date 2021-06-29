import 'package:flutter/material.dart';
import 'package:s_fam/common/constants/texts_config.dart';
class AccountItem extends StatelessWidget {
  final nameItem;
  final note;
  const AccountItem({Key? key, this.nameItem, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(nameItem, style: kText14BlackBold,),
          SizedBox(height: 12,),
          Container(
            height: 60,
            child: Text(note,style: kSubText14Black,),
          ),
        ],
      ),
    );
  }
}
