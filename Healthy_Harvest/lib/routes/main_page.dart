import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_harvest/bloc/user/auth/auth_bloc.dart';
import 'package:healthy_harvest/bloc/user/auth/auth_state.dart';
import 'package:healthy_harvest/config/color_config.dart';
import 'package:healthy_harvest/routes/coming_soon_page.dart';
import 'package:healthy_harvest/routes/home_page.dart';
import 'package:healthy_harvest/config/widget_config.dart';
import 'package:healthy_harvest/routes/login_page.dart';
import 'dart:async';


class Main extends StatefulWidget {
  static String routename = "mainScreen";
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int pageIndex =0 ;

  final pages = [
    Home(),
    ComingSoon(),
    ComingSoon(),
    ComingSoon()
  ];
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Login(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeIn;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return Align(
          child: SlideTransition(
            position: animation.drive(tween),
            child: child,
          ),
        );
      },
    );
  }
  Future<Timer> _changeRouteTimer(context) async =>
      Timer(const Duration(seconds: 3), () async {
        while (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
        Navigator.of(context).pop();
        Navigator.of(context).push(_createRoute());
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: BlocBuilder<AuthBloc,AuthState>(
        builder: (context,state){
          if(state is AuthAuthenticated){
            return Scaffold(
              body: pages[pageIndex],
              bottomNavigationBar: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0, // soften the shadow
                      spreadRadius: 2.0, //extend the shadow
                      offset: Offset(
                        0, // Move to right 5  horizontally
                        4.0, // Move to bottom 5 Vertically
                      ),
                    )
                  ],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        enableFeedback: false,
                        onPressed: () {
                          setState(() {
                            pageIndex = 0;
                          });
                        },
                        icon: pageIndex == 0
                            ? home(primaryColor)
                            : home(Colors.black)
                    )
                    ,
                    IconButton(
                        enableFeedback: false,
                        onPressed: () {
                          setState(() {
                            pageIndex = 1;
                          });
                        },
                        icon: pageIndex == 1
                            ? store(primaryColor)
                            : store(Colors.black)
                    ),
                    Image.asset('assets/logo2.png',height: MediaQuery.of(context).size.height*0.08,width: MediaQuery.of(context).size.width*0.08,),
                    IconButton(
                        enableFeedback: false,
                        onPressed: () {
                          setState(() {
                            pageIndex = 2;
                          });
                        },
                        icon: pageIndex == 2
                            ? users(primaryColor)
                            : users(Colors.black)
                    ),
                    IconButton(
                        enableFeedback: false,
                        onPressed: () {
                          setState(() {
                            pageIndex = 3;
                          });
                        },
                        icon: pageIndex == 3
                            ? user(primaryColor)
                            : user(Colors.black)
                    ),
                  ],
                ),
              ),
            );
          }else if(state is AuthUnauthenticated){
            _changeRouteTimer(context);
          }
            return Scaffold(
              backgroundColor: primaryColor,
            );

        },
      )
    );
  }
}
