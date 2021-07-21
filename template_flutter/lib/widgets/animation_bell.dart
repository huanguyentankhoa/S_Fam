

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/flutter_template.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnimationBell extends StatefulWidget {
  final Function(bool) onTap;
  const AnimationBell({Key? key, required this.onTap}) : super(key: key);

  @override
  _AnimationBellState createState() => _AnimationBellState();
}

class _AnimationBellState extends State<AnimationBell>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  bool isOn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    final curvedAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceIn,
      reverseCurve: Curves.easeOut,
    );

    animation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });

    animationController.forward();

    loadInit();

  }
  loadInit() async {
    final prefs = await SharedPreferences.getInstance();
    var resultAlarm = prefs.getBool("Alarm");
    if(resultAlarm!=null){
      setState(() {
        isOn = resultAlarm;
      });
    }else{
      setState(() {
        isOn = false;
      });
    }
  }
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();

  }

  saveEnableAlarm(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("Alarm", value);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () async {
            if(!isOn){
              bool result = await showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    content: Container(
                        height: 60,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Text(
                          "Bạn đang muốn bật cảnh báo?",
                          style: kText16Black,
                        )),
                    actions: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context, true);
                            },
                            child: Text(
                              "BẬT",
                              style: kText16RedBold,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context, false);
                            },
                            child: Text(
                              "HỦY",
                              style: kText16BlackBold,
                            ),
                          )
                        ],
                      )
                    ],
                  ));
           if(result){
             setState(() {
               isOn = true;
             });
           }
           else
             setState(() {
               isOn = false;
             });
            }else{
              setState(() {
                isOn = false;
              });
            }
            saveEnableAlarm(isOn);
            widget.onTap(isOn);
          },
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle
            ),
            child: isOn?Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle
              ),
              alignment: Alignment.center,
              child: Container(
                height: 15,
                width: 15,
                color: Colors.white,
              ),
            ):Transform.rotate(
              angle: animation.value/4,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset("assets/icons/bell.svg",color: Colors.white,width: 20,height: 20,),
              ),
            ),
          ),
        ),
      ],
    );
  }

}
