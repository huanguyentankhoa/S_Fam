import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';

class AppBarGenerated extends StatefulWidget implements PreferredSizeWidget {
  @override
  _AppBarGeneratedState createState() => _AppBarGeneratedState();

  @override
  Size get preferredSize {
    return new Size.fromHeight(110.0);
  }
}

class _AppBarGeneratedState extends State<AppBarGenerated> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      color: Colors.white,
      padding: EdgeInsets.only(left: 24, bottom: 10),
      alignment: AlignmentDirectional.bottomStart,
      child: InkWell(
        onTap: (){
          Navigator.pop(context);
        },
        child: Container(
          height: 20,
          width: 200,
          child: Row(
            children: [
              Container(
                height: 11,
                width: 16,
                child:SvgPicture.asset("assets/icons/back.svg",color: textSecondary,),
              ),
              SizedBox(
                width: 12,
              ),
              Text("Quay lại",style: kSubText16Black,),
            ],
          ),
        ),
      ),
    );
  }
}
