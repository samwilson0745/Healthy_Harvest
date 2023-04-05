import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

final Widget humidity = SvgPicture.asset(
  'assets/Humidity.svg',
  semanticsLabel: 'Humidity',
);
final Widget Group1 = SvgPicture.asset(
  'assets/Group1.svg',
  height: 100,
);
Widget home(Color color){
  return SvgPicture.asset(
  'assets/HouseLine.svg',
    color: color,
    height: 25,
    width: 25,
  );
}
Widget store(Color color){
  return SvgPicture.asset('assets/Storefront.svg',color: color,height: 25,
    width: 25,);
}
Widget users(Color color){
  return SvgPicture.asset('assets/UsersThree.svg',color: color,height: 25,
    width: 25,);
}
Widget user(Color color){
  return SvgPicture.asset('assets/User.svg',color: color,height: 25,
    width: 25,);
}
final Widget NotCrop = SvgPicture.asset(
    'assets/NotCrop.svg'
);
final Widget ErrorSvg = SvgPicture.asset(
  'assets/error.svg'
);
final Widget Group2 = SvgPicture.asset(
    'assets/Group2.svg',
  height: 100,
);
final Widget Group3 = SvgPicture.asset(
    'assets/Group4.svg',
  height: 100,
);
final Widget camera = SvgPicture.asset(
  'assets/camera.svg',
  color: Colors.white,
);

final Widget logo = SvgPicture.asset(
    'assets/logo.svg',
);
final Widget gallery = SvgPicture.asset(
  'assets/gallery.svg',
  color: Colors.white,
);
final Widget sun = SvgPicture.asset(
  'assets/Sunny.svg',
  semanticsLabel: 'Sun',
);
final Widget bullet = SvgPicture.asset(
  'assets/bullet.svg',
  height: 15,
  width: 15,
);
final Widget wind = SvgPicture.asset(
  'assets/Wind.svg',
  semanticsLabel: 'Wind',
);

Widget BoxConatiner(Widget icon,String heading,String rate){
  return Container(
    height: 77,
    width: 67,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        icon,
        Text(heading,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
        Text(rate)
      ],
    ),
  );
}

Widget MyDivider(double height){
  return Container(
    height: height*0.08,
    width: 0.6,
    color: Color(0xa1000000),
  );
}

Widget MyColumn(Widget widget,String text){
  return Column(
    children: [
      widget,
      Text(text,style: TextStyle(color:  Color(0xff086972),fontSize: 14),textAlign: TextAlign.center,)
    ],
  );
}