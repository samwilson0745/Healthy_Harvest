import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_harvest/bloc/predictor/predictor_bloc.dart';
import 'package:healthy_harvest/bloc/user/auth/auth_bloc.dart';
import 'package:healthy_harvest/bloc/user/auth/auth_event.dart';
import 'package:healthy_harvest/store/login/auth_repo.dart';
import 'package:healthy_harvest/store/predictor/predictor_repo.dart';
import 'routes/main_page.dart';
import 'routes/camera_page.dart';
import 'routes/result_page.dart';
import 'routes/splash_screen.dart';
import 'routes/login_page.dart';
import 'routes/register_page.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final predictor_repo repo_predictor = new predictor_repo();
  final auth_repo repo_auth = new auth_repo();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context)=>PredictorBloc(repo: repo_predictor)
        ),
        BlocProvider(
            create: (context)=>AuthBloc(repo: repo_auth)..add(AppStarted())
        )
      ],
      // create: (context)=>PredictorBloc(repo: repo),
      child: MaterialApp(
        initialRoute: SplashScreen.routeName,
        routes: {
          Register.routename:(context)=>Register(),
          Login.routename:(context)=>Login(),
          SplashScreen.routeName:(context)=>SplashScreen(),
          Main.routename:(context)=>Main(),
          Camera.routeName:(context)=>Camera(),
          Diagnose.routeName:(context)=>Diagnose()
        },
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
