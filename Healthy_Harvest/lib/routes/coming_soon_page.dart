import 'package:flutter/material.dart';
import 'package:healthy_harvest/config/color_config.dart';

class ComingSoon extends StatefulWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Image.asset('assets/cat.png'),
                ),
                Text('THIS PAGE IS COMING\nSOON!',style: TextStyle(letterSpacing: 2,color: secondaryColor,fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.center,),
              ],
            ),
          )
      ),
    );
  }
}
