import 'package:flutter/material.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopupDocOfOwner extends StatefulWidget {
  final Function(String) onSelect;
  const PopupDocOfOwner({Key? key,required this.onSelect}) : super(key: key);

  @override
  _PopupDocOfOwnerState createState() => _PopupDocOfOwnerState();
}

class _PopupDocOfOwnerState extends State<PopupDocOfOwner> {
  List<Item> listSelect = [
    Item("Sổ hộ khẩu", true),
    Item("CMND", false),
    Item("Căn cước công dân", false),
    Item("Passport", false),
    Item("Thẻ BHYT", false),

  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 296.h,
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Column(
        children: [
          Container(
            height: 6.h,
            width: 148.w,
            margin: EdgeInsets.only(top: 14.h),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(15.h)),
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: false,
                physics: NeverScrollableScrollPhysics(),
                itemCount: listSelect.length,
                itemBuilder: (_,index){
                  return InkWell(
                    onTap: (){
                      listSelect.forEach((i) {
                        i.isSelected = false;
                      });
                      setState(() {
                        listSelect[index].isSelected = true;
                      });
                      widget.onSelect(listSelect[index].name);
                    },
                    child: Container(
                      height: 50.h,
                      color: listSelect[index].isSelected?yrColor1:yrColor4,
                      padding: EdgeInsets.only(left: 16.w),
                      alignment: Alignment.centerLeft,
                      child: Text(listSelect[index].name,style: listSelect[index].isSelected?kText16_3:kText16_1,),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
class Item {
  late String name;
  late bool isSelected;

  Item(this.name, this.isSelected);
}
