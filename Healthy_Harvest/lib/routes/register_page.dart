import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_harvest/bloc/user/auth/auth_bloc.dart';
import 'package:healthy_harvest/bloc/user/auth/auth_state.dart';
import 'package:healthy_harvest/bloc/user/login/login_bloc.dart';
import 'package:healthy_harvest/bloc/user/register/register_bloc.dart';
import 'package:healthy_harvest/bloc/user/register/register_event.dart';
import 'package:healthy_harvest/bloc/user/register/register_state.dart';
import 'package:healthy_harvest/config/widget_config.dart';
import 'package:healthy_harvest/config/color_config.dart';
import 'dart:async';
import 'package:healthy_harvest/store/register/register_repo.dart';

class Register extends StatefulWidget {
  static final routename  = "register";
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final register_repo repo = register_repo();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _usernameController = new TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool isChecked = false;
  String username="";
  String email="";
  String password="";
  bool _passwordVisible=true;
  Future<Timer> _changeRouteTimer(context) async =>
      Timer(const Duration(seconds: 5), () async {
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
    return BlocProvider<RegisterBloc>(
      create: (context)=>RegisterBloc(repo: repo, loginBloc: LoginBloc(repo: context.read<AuthBloc>().repo,authenticationBloc: context.read<AuthBloc>())),
      child: MultiBlocListener(
        listeners: [
          BlocListener<RegisterBloc,RegisterState>(
              listener: (context,state){
                if(state is UserRegistered){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("User registered Successfuly"))
                  );
                }
                else if(state is RegistrationError){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error.toString()))
                  );
                }
              }
          ),
          BlocListener<AuthBloc,AuthState>(
              listener: (context,state){
                if(state is AuthAuthenticated){
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Login Successfuly...Redirecting"))
                  );
                  _changeRouteTimer(context);
                }
              }
          )
        ],
        child: BlocBuilder<RegisterBloc,RegisterState>(
          builder: (context,state) {
            return GestureDetector(
              onTap: (){
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Scaffold(
                body: Center(
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
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text("Sign Up",style:TextStyle( color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25)),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Form(
                                      key: _key,
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            TextFormField(
                                                controller: _usernameController,
                                                onChanged: (value){
                                                  setState(() {
                                                    username=value;
                                                  });
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
                                                  hintText: "Username",
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
                                            TextFormField(
                                                controller: _emailController,
                                                onChanged: (value){
                                                  setState(() {
                                                    email=value;
                                                  });
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
                                            ),],),),
                                    )),
                                Expanded(
                                  child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Checkbox(
                                            value: isChecked,
                                            onChanged: (bool? value){
                                              setState(() {
                                                isChecked=value!;
                                              });
                                            }
                                        )),
                                    Expanded(
                                        flex: 5,
                                        child: Text(
                                          "I would like to receive your newsletter and other promotional information",style: TextStyle(
                                            color: Color(0xff666666)
                                        ),
                                        ))
                                  ],
                                ),),
                                Expanded(
                                    flex:2,
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
                                                  if(username=='' && email=="" && password==""){
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Feilds cannot be empty")));

                                                  }else if(username==''){
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill username")));
                                                  }else if(email==""){
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill email")));
                                                  }else if(password==""){
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill password")));
                                                  }else{
                                                    _key.currentState!.save();
                                                    BlocProvider.of<RegisterBloc>(context).add(RegisterButtonPressed(username: username, email: email, password: password));
                                                  }
                                                }
                                              },
                                              child: (state is RegisterLoading)?CircularProgressIndicator(color: Colors.white,):Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text('SIGN UP',style: TextStyle(letterSpacing: 2,fontWeight: FontWeight.bold),),
                                                  SizedBox(width: 10,),
                                                  user(Colors.white)
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(onTap: (){
                                            Navigator.pushNamed(context, "login");
                                          },child: Text('Already have an account?',style: TextStyle(color: newColor),),)
                                        ],
                                      ),
                                    ))
                              ],
                            )
                        )

                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
