

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/flutter_template.dart';

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
  bool isOn = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: (){

            setState(() {
              isOn = !isOn;
            });
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
