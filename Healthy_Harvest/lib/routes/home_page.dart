import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_harvest/bloc/user/auth/auth_bloc.dart';
import 'package:healthy_harvest/bloc/user/auth/auth_state.dart';
import 'package:healthy_harvest/bloc/weather/weather_bloc.dart';
import 'package:healthy_harvest/bloc/weather/weather_events.dart';
import 'package:healthy_harvest/bloc/weather/weather_states.dart';
import 'package:healthy_harvest/store/location/location_repo.dart';
import 'package:healthy_harvest/store/weather/weather_repo.dart';
import 'package:healthy_harvest/config/color_config.dart';
import 'package:healthy_harvest/config/widget_config.dart';
import 'package:intl/intl.dart';
import 'dart:async';
class Home extends StatefulWidget {
  static String routeName = "home";

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {

  final weather_repo repo_weather = new weather_repo();
  final location_repo repo_location = new location_repo();
  DateTime time = DateTime.now();

  Future<Timer> _changeRouteTimer(context) async =>
      Timer(const Duration(seconds: 3), () async {
        while (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
        Navigator.of(context).pop();
        Navigator.pushNamed(context, 'login');
      });

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>WeatherBloc(repo_weather: repo_weather,repo_location: repo_location)..add(GetWeather(key: "c3e048eecef528e4924a44d601e84409")),),
      ],
      child: Scaffold(
        body: BlocBuilder<WeatherBloc,WeatherState>(
                builder: (context,state) {
                  if(state is WeatherCompleted){
                    double _temp=state.data.temperature_C-273;
                    double _tF = (_temp*1.8)+32;
                    String t=_temp.toStringAsFixed(1);
                    String _t2 = _tF.toStringAsFixed(1);

                    return SingleChildScrollView(

                      child: Container(
                        height: height,
                        width: width,
                        child: Stack(
                            children: [
                              Positioned(
                                left: 0,right: 0,top: 0,
                                child: Container(
                                    height: height*0.37,
                                    padding: EdgeInsets.symmetric(vertical: height*0.055,horizontal: width*0.07),
                                    width: width,
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        image: DecorationImage(
                                            image: AssetImage('assets/Scene_Plants.png'),
                                            fit: BoxFit.contain,
                                            opacity: 0.5
                                        )
                                    ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("WELCOME",style:TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500,letterSpacing: 2),),
                                          IconButton(
                                            onPressed: (){
                                              context.read<AuthBloc>().repo.deleteToken();
                                              _changeRouteTimer(context);
                                            },
                                            icon: Icon(Icons.logout_outlined,size: 28,color: Colors.white,),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: BlocBuilder<AuthBloc,AuthState>(
                                            builder:(context,state){
                                              if(state is AuthAuthenticated){
                                                return Text(state.User,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,letterSpacing: 1),);
                                              }else {
                                                return Text('user',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,letterSpacing: 1));
                                              }
                                            }
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text("${t}°C",style:TextStyle(color: Colors.white,fontSize: 52,fontWeight: FontWeight.w600,letterSpacing: 1)),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("${DateFormat('EEEE').format(time).substring(0,3)}, ${DateFormat('h:mm a').format(time)}",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w400),),
                                                Text("${_t2}°F",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w400),)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: height*0.01),
                                        child: Text('India / ${state.data.city}',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400),),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: height*0.3,
                                  left: width*0.08,
                                  child: Container(
                                    height: height*0.17,
                                    width: width*0.85,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
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
                                        ]
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                            flex:2,
                                            child: BoxConatiner(sun, "UV Index", "High")),
                                        MyDivider(height),
                                        Expanded(
                                            flex:2,
                                            child: BoxConatiner(humidity, "Humidity", "${state.data.humidity}%")),
                                        MyDivider(height),
                                        Expanded(
                                            flex:2,
                                            child: BoxConatiner(wind, "Wind", "${state.data.wind_kph}km/h")),
                                      ],
                                    ),
                                  )
                              ),
                              Positioned(
                                top: height*0.5,
                                left: width*0.08,
                                child: Container(
                                  width: width*0.87,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Healthify Your Crops',style: TextStyle(letterSpacing:1,fontSize: 17,fontWeight: FontWeight.bold,color: secondaryColor),),
                                            SizedBox(width: width*0.2),
                                            IconButton(onPressed: (){}, icon: Icon(Icons.more_time,color: primaryColor,size: width*0.08,))
                                          ],
                                        ),
                                        SizedBox(height: height*0.02,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            MyColumn(Group1, 'Take a\npicture'),
                                            MyDivider(height),
                                            MyColumn(Group2, 'Get AI aided\nDiagnosis'),
                                            MyDivider(height),
                                            MyColumn(Group3, 'Get the best\nmedicines')
                                          ],
                                        ),
                                        SizedBox(height: height*0.025,),
                                        Container(
                                          height: height*0.065,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors:[
                                                    primaryColor,
                                                    buttonColor
                                                  ]
                                              ),
                                              borderRadius: BorderRadius.all(Radius.circular(25))
                                          ),
                                          child: ElevatedButton(
                                            style:ElevatedButton.styleFrom(
                                              backgroundColor: Colors.transparent,
                                              shadowColor: Colors.transparent,
                                            ),
                                            onPressed: ()async{
                                              SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
                                                SystemUiOverlay.top,
                                                SystemUiOverlay.bottom
                                              ]);
                                              Navigator.pushNamed(context, 'camerascreen');
                                            },
                                            child: Container(
                                              constraints: BoxConstraints(minWidth: width*0.85,),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text('TAKE A PICTURE',style: TextStyle(letterSpacing: 1),),
                                                  SizedBox(width: 5,),
                                                  camera
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ),
                              ),
                            ],

                        ),
                      ),
                    );
                  }else if(state is WeatherError){
                    return Text(state.error.toString());
                  }else{
                    return Center(child: CircularProgressIndicator(
                      color: primaryColor,
                    ));
                  }
                }
            ),

      ),
    );
  }
}