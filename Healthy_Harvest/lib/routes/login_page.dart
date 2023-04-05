import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_harvest/bloc/user/auth/auth_bloc.dart';
import 'package:healthy_harvest/bloc/user/auth/auth_state.dart';
import 'package:healthy_harvest/bloc/user/login/login_bloc.dart';
import 'package:healthy_harvest/bloc/user/login/login_event.dart';
import 'package:healthy_harvest/bloc/user/login/login_state.dart';
import 'package:healthy_harvest/config/color_config.dart';
import 'package:healthy_harvest/config/widget_config.dart';
import 'dart:async';


Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Login(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
class Login extends StatefulWidget {
  static String routename = "login";
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String email="";
  String password="";
  bool _passwordVisible=true;

  Future<Timer> _changeRouteTimer(context) async =>
      Timer(const Duration(seconds: 3), () async {
        while (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
        Navigator.of(context).pop();
        Navigator.pushNamed(context, 'mainScreen');
      });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider<LoginBloc>(
      create:(BuildContext context)=>LoginBloc(repo: context.read<AuthBloc>().repo, authenticationBloc: context.read<AuthBloc>()),
      child: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          body: MultiBlocListener(
            listeners: [
              BlocListener<LoginBloc,LoginState>(listener: (context,state){
                if(state is LoginError){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error.toString()))
                  );
                }
                else if(state is LoginLoading){
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('loading...')));
                }
              }),
              BlocListener<AuthBloc,AuthState>(listener: (context,state){
                if(state is AuthAuthenticated){
                  _changeRouteTimer(context);
                }
              })
            ],
            child: BlocBuilder<LoginBloc,LoginState>(
              builder: (context,state){
                return Center(
                    child: Container(
                        width: width*0.8,
                        height: height*0.8,
                        child: Column(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Column(children: [
                                  Image.asset('assets/logo.png',height: MediaQuery.of(context).size.height*0.11,width: MediaQuery.of(context).size.width*0.14,),
                                  Text("Healthy Harvest",style: TextStyle(color: newColor,fontSize: 25,fontWeight: FontWeight.bold,letterSpacing: 0.3),),
                                ],)),
                            Expanded(
                                flex: 6,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 20),
                                      child: Text("Log in",style:TextStyle( color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25)),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Container(
                                          child: Form(
                                            key: _key,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                TextFormField(
                                                    controller: _emailController,
                                                    onChanged: (value){
                                                      setState(() {
                                                        email=value;
                                                      });
                                                    },
                                                    validator: (value){
                                                      if(value == ""){

                                                        return "Please fill email";
                                                      }

                                                    },
                                                    decoration:InputDecoration(
                                                      fillColor: Color(0xffF6F6F6),
                                                      filled: true,
                                                      isDense: true,
                                                      focusedErrorBorder:OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.red,width: 2),
                                                          borderRadius: BorderRadius.all(Radius.circular(10))
                                                      ),
                                                      errorBorder:  OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.red,width: 2),
                                                          borderRadius: BorderRadius.all(Radius.circular(10))
                                                      ),
                                                      hintText: "Email",
                                                      hintStyle: TextStyle(color: Colors.black),
                                                      contentPadding: EdgeInsets.symmetric(horizontal: width*0.025,vertical: height*0.02),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Color(
                                                              0xFFD9D9D9),width:0.5),
                                                          borderRadius: BorderRadius.all(Radius.circular(12))
                                                      ),
                                                      focusedBorder:  OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.black,width: 0.5),
                                                          borderRadius: BorderRadius.all(Radius.circular(12))
                                                      ),
                                                    )
                                                ),
                                                Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(primaryColor: primaryColor,),
                                                  child: TextFormField(
                                                      obscureText: _passwordVisible,
                                                      controller: _passwordController,
                                                      onChanged: (value){
                                                        setState(() {
                                                          password=value;
                                                        });
                                                      },
                                                      validator: (value){
                                                        if(value == ""){
                                                          return "Please fill password";
                                                        }

                                                      },
                                                      decoration:InputDecoration(
                                                        fillColor: Color(0xffF6F6F6),
                                                        filled: true,
                                                        isDense: true,
                                                        focusedErrorBorder:OutlineInputBorder(
                                                            borderSide: BorderSide(color: Colors.red,width: 2),
                                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                                        ),
                                                        errorBorder:  OutlineInputBorder(
                                                            borderSide: BorderSide(color: Colors.red,width: 2),
                                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                                        ),
                                                        hintText: "Password",
                                                        hintStyle: TextStyle(color: Colors.black),
                                                        contentPadding: EdgeInsets.symmetric(horizontal: width*0.025,vertical: height*0.02),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(color: Color(
                                                                0xFFD9D9D9),width:0.5),
                                                            borderRadius: BorderRadius.all(Radius.circular(12))
                                                        ),
                                                        suffixIcon: GestureDetector(
                                                          onTap: (){
                                                            setState(() {
                                                              _passwordVisible=!_passwordVisible;
                                                            });
                                                          },
                                                          child: Icon(
                                                            _passwordVisible?Icons.visibility_off:Icons.visibility,
                                                            color: primaryColor,
                                                          ),
                                                        ),
                                                        focusedBorder:  OutlineInputBorder(
                                                            borderSide: BorderSide(color: Colors.black,width: 0.5),
                                                            borderRadius: BorderRadius.all(Radius.circular(12))
                                                        ),
                                                      )
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 10,),
                                                  child: Text('Forgot password?',style: TextStyle(color: newColor),),
                                                )
                                              ],
                                            ),
                                          ),)),

                                    Expanded(
                                        flex:4,
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Container(
                                                height: height*0.065,
                                                margin: EdgeInsets.symmetric(vertical:15),
                                                child: ElevatedButton(
                                                  style:ElevatedButton.styleFrom(
                                                      backgroundColor: newColor,
                                                      elevation: 3,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(15))
                                                      )
                                                  ),
                                                  onPressed: ()async{
                                                    FocusScope.of(context).unfocus();
                                                    if(_key.currentState!.validate()){
                                                      _key.currentState!.save();
                                                      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(email: email, password: password));
                                                    }
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text('LOG IN',style: TextStyle(letterSpacing: 2,fontWeight: FontWeight.bold),),
                                                      SizedBox(width: 10,),
                                                      user(Colors.white)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(onTap: (){
                                                Navigator.pushNamed(context, "register");
                                              },child: Text('Create an account?',style: TextStyle(color: newColor),),)
                                            ],
                                          ),
                                        ))
                                  ],
                                )
                            )

                          ],
                        )
                    )

                );
              },
            ),
          ),

        ),
      ),
    );
  }
}
