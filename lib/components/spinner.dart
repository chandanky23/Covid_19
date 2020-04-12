import 'package:flutter/material.dart';
import 'dart:math';

class Spinner extends StatefulWidget {
  const Spinner({Key key}) : super(key:key);
  @override
  _SpinnerState createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animationRotation;
  Animation<double> animationRadiusIn;
  Animation<double> animationRadiusOut;

  final double initialradius = 30.0;

  double radius = 0.0;

  @override
  void dispose() {
    if(controller.status == AnimationStatus.forward || controller.status == AnimationStatus.reverse) {
      controller.notifyStatusListeners(AnimationStatus.dismissed);
    }
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(seconds: 5));
    animationRotation = Tween<double>(
      begin: 0.0,
      end: 1.0
    ).animate(CurvedAnimation(parent: controller, curve: Interval(0.0, 1.0, curve: Curves.linear)));

    animationRadiusIn = Tween<double>(
      begin: 1.0,
      end: 0.0
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0.75, 1.0, curve: Curves.elasticIn))
    );

    animationRadiusOut = Tween<double>(
      begin: 0.0,
      end: 1.0
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0.0, 0.25, curve: Curves.elasticInOut))
    );

    controller.addListener(() {
      setState(() {
        if(controller.value >= 0.75 && controller.value <= 1.0) {
          radius = animationRadiusIn.value * initialradius;
        } else if(controller.value >= 0.0 && controller.value <= 0.25) {
          radius = animationRadiusOut.value * initialradius;
        }
      });
    });
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Center(
        child: RotationTransition(
          turns: animationRotation,
          child: Stack(
            children: <Widget>[
              Dot(
                radius: 30.0,
                color: Colors.grey
              ),
              Transform.translate(
                offset: Offset(radius * cos(pi/4), radius * sin(pi/4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.greenAccent,
                ),
              ),
              Transform.translate(
                offset: Offset(radius * cos(2 * pi/4), radius * sin(2 * pi/4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.redAccent,
                ),
              ),
              Transform.translate(
                offset: Offset(radius * cos(3 * pi/4), radius * sin(3 * pi/4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.blueAccent,
                ),
              ),
              Transform.translate(
                offset: Offset(radius * cos(4 * pi/4), radius * sin(4*pi/4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.yellow[900],
                ),
              ),
              Transform.translate(
                offset: Offset(radius * cos(5*pi/4), radius * sin(5*pi/4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.purpleAccent,
                ),
              ),
              Transform.translate(
                offset: Offset(radius * cos(6*pi/4), radius * sin(6*pi/4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.orangeAccent,
                ),
              ),
              Transform.translate(
                offset: Offset(radius * cos(7*pi/4), radius * sin(7*pi/4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.pinkAccent,
                ),
              ),
              Transform.translate(
                offset: Offset(radius * cos(8*pi/4), radius * sin(8*pi/4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.amberAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  Dot({ this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: this.radius,
        width: this.radius,
        decoration: BoxDecoration(
          color: this.color, shape: BoxShape.circle
        ),
      ),
    );
  }
}