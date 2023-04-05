import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_harvest/bloc/predictor/predictor_bloc.dart';
import 'package:healthy_harvest/bloc/predictor/predictor_states.dart';
import 'package:healthy_harvest/config/color_config.dart';
import 'package:bulleted_list/bulleted_list.dart';
import 'package:healthy_harvest/config/url_config.dart';
import 'package:healthy_harvest/config/widget_config.dart';


class Diagnose extends StatefulWidget {
  static String routeName = "diagnose";
  const Diagnose({Key? key}) : super(key: key);

  @override
  State<Diagnose> createState() => _DiagnoseState();
}

class _DiagnoseState extends State<Diagnose> {
  Widget _buildPlayerModelListWithArrays(String title,List<dynamic> data){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ExpansionTile(
          iconColor: secondaryColor,
          textColor: secondaryColor,
          title: Text(
            title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
          ),
          children: <Widget>[
            BulletedList(
              listItems: data,
              bullet: bullet,
              style: TextStyle(
                fontSize: 15
              ),
            ),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
  Widget _buildPlayerModelList(String title,String description) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Card(
        elevation: 3,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ExpansionTile(
          iconColor: secondaryColor,
          textColor: secondaryColor,
          title: Text(
            title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
          ),
          children: <Widget>[
            ListTile(
              title: Text(
                description,
                style: TextStyle(fontWeight: FontWeight.w400,letterSpacing: 1),
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocBuilder<PredictorBloc,PredictorState>(
            bloc: context.read<PredictorBloc>(),
            builder: (context,state){
              if(state is PredictorCompleted){
                if(state.prediction.args['name']=="Not A crop !!"){
                  return Scaffold(
                    backgroundColor: Colors.white,
                    body: Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Image.asset('assets/gogreen.png'),
                              ),
                              Text('THIS IS NOT A CROP',style: TextStyle(letterSpacing: 2,color: secondaryColor,fontWeight: FontWeight.bold,fontSize: 18),),
                              SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                              Text('Make Sure You Click A\nClear Picture Of The\nAffected Leaf',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,letterSpacing: 2,fontWeight: FontWeight.w400),),
                              SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                              Container(
                                height: height*0.07,
                                width: width*0.4,
                                child: ElevatedButton(
                                  style:ElevatedButton.styleFrom(
                                    backgroundColor: newColor,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(15))
                                    )
                                  ),
                                  onPressed: ()async{
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('TRY AGAIN',style: TextStyle(letterSpacing: 2,fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                  );
                }

                List medications = state.prediction.args['medications'];
                List maintaining = state.prediction.args['maintaining'];

                return Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios,size: 18,),
                        color: Colors.white,
                      ),
                      title: Text(state.prediction.args['crop_type'],style: TextStyle(color:Colors.white,fontWeight: FontWeight.w600 ,letterSpacing: 1,fontSize: 18),),
                      centerTitle: true,
                      backgroundColor: newColor,
                      elevation: 0.0,
                    ),
                    body: ListView(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: newColor,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff000000).withOpacity(0.25),
                                blurRadius:15.0, // soften the shadow
                                spreadRadius: 5, //extend the shadow
                                offset: Offset(
                                  2.0, // Move to right 5  horizonta  lly
                                  0.0, // Move to bottom 5 Vertically
                                ),
                              )
                            ],
                          ),
                          child:Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                  child: Container(
                                    height: height*0.25,
                                    width: width,
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xff000000).withOpacity(0.25),
                                          blurRadius:15.0, // soften the shadow
                                          spreadRadius: 5, //extend the shadow

                                          offset: Offset(
                                            2.0, // Move to right 5  horizontally
                                            0.0, // Move to bottom 5 Vertically
                                          ),
                                        )
                                      ],
                                      image: DecorationImage(
                                        image: NetworkImage('${url}${state.prediction.args['image']}'),
                                        fit: BoxFit.fitWidth,
                                      )
                                    ),
                                  )
                              ),
                              Flexible(
                                  fit: FlexFit.loose,
                                  child: Container(
                                    padding: EdgeInsets.only(left: width*0.05,right: width*0.05 ,top: 15,bottom: 5),
                                    child: Text(state.prediction.args["name"],style: TextStyle(color: Colors.white,fontSize: width*0.08,fontWeight: FontWeight.bold,letterSpacing: 1),)
                                  )
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                  child: Container(
                                    padding: EdgeInsets.only(left: width*0.05,right: width*0.05,top: 5,bottom: 20),
                                    child: Text(state.prediction.args['description'],style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 15),textAlign: TextAlign.justify,),
                                  )
                              )
                            ],
                          ) ,
                        ),
                        state.prediction.args['cure']==""?Container():_buildPlayerModelList("TREATMENT", state.prediction.args['cure']),
                        medications==[]?Container():_buildPlayerModelListWithArrays("MEDICATION", state.prediction.args['medications']),
                        maintaining==[]?Container():_buildPlayerModelListWithArrays("MAINTAINANCE", state.prediction.args['maintaining'])
                      ]
                    )
                );
              }else if(state is PredictorError){
                return Scaffold(
                  body: Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Image.asset('assets/Error.png'),
                            ),
                            Text('SOMETHING WENT WRONG',style: TextStyle(letterSpacing: 2,color: secondaryColor,fontWeight: FontWeight.bold,fontSize: 18),),
                            SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                            Text('We Can’t Find The Item\nYou Are Looking For',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,letterSpacing: 2,fontWeight: FontWeight.w400)),
                            SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                            Container(
                              height: height*0.07,
                              width: width*0.4,
                              child: ElevatedButton(
                                style:ElevatedButton.styleFrom(
                                    backgroundColor: newColor,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(15))
                                    )
                                ),
                                onPressed: ()async{
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('TRY AGAIN',style: TextStyle(letterSpacing: 2,fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                );
              }else{
                return Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
            },
      );
  }
}
