import 'package:flutter/material.dart';
import 'dart:async';
import 'package:healthy_harvest/config/color_config.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "splashscreen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomAnimation(),
    );
  }
}
class CustomAnimation extends StatefulWidget {
  const CustomAnimation({Key? key}) : super(key: key);

  @override
  State<CustomAnimation> createState() => _CustomAnimationState();
}

class _CustomAnimationState extends State<CustomAnimation> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    controller =AnimationController(vsync: this,duration: Duration(milliseconds: 1000));
    _animation = Tween(begin:2.0,end:0.0).animate(controller);
    Timer(Duration(milliseconds: 2000),(){
      Navigator.popAndPushNamed(context, "mainScreen");
    });
  }


  @override
  void dispose() {
    super.dispose();
    controller.dispose();// TODO: implement dispose
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return Stack(children: [
      AnimatedReveal(),
      Center(
        child:FadeTransition(
          opacity: _animation,
          child: Image.asset('assets/logo2.png',color: Colors.white,height: 50,width: 50,),
        )
      )
    ]);
  }
}

class AnimatedReveal extends StatelessWidget {
  const AnimatedReveal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween(begin:  0.0,end: 2.0),
        duration: Duration(milliseconds: 1000),
        builder:(context,double value,child){
          return ClipPath(
            child: child,
            clipper: MyClipper(value),
          );
        },
      child: Container(
        color: primaryColor,
      ),
    );
  }
}
class MyClipper extends CustomClipper<Path>{
  final double value;
  MyClipper(this.value);

  @override
  Path getClip(Size size){
    var path = Path();
    path.addOval(Rect.fromCircle(center: Offset(size.width/2,size.height/2), radius: value*size.width));
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

