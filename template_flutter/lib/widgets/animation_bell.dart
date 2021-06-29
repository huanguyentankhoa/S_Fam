
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/flutter_template.dart';

class AnimationBell extends StatefulWidget {
  const AnimationBell({Key? key}) : super(key: key);

  @override
  _AnimationBellState createState() => _AnimationBellState();
}

class _AnimationBellState extends State<AnimationBell>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

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
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    bool isOn = false;
    int alarmId = 1;
    return Stack(
      children: [
        InkWell(
          onTap: (){
            AndroidAlarmManager.oneShot(
                Duration(seconds: 5), alarmId, fireAlarm);
            // setState(() {
            //   isOn = !isOn;
            // });
            // if (isOn) {
            //   print("alo");
            //   AndroidAlarmManager.periodic(
            //       Duration(seconds: 60), alarmId, fireAlarm);
            // } else {
            //   AndroidAlarmManager.cancel(alarmId);
            //   print('Alarm Timer Canceled');
            // }
          },
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle
            ),
            child: Transform.rotate(
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
  void fireAlarm() {
    print('Alarm Fired at ${DateTime.now()}');
  }
}
