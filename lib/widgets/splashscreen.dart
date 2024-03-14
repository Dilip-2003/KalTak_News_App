import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kaltak/widgets/homescreen.dart';
// import 'package:google_fonts/google_fonts.dart';

class SpalashScreen extends StatefulWidget {
  const SpalashScreen({super.key});

  @override
  State<SpalashScreen> createState() => _SpalashScreenState();
}

class _SpalashScreenState extends State<SpalashScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 1), () { 
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        
        return HomeScreen();
      },));
    });
  }
  @override

  Widget build(BuildContext context) {
  var height = MediaQuery.of(context).size.height*1;
  var width = MediaQuery.of(context).size.width*1;
    return Scaffold(
      // backgroundColor: Colors.,
      body: Container(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            Image.asset(
              'images/splash_pic.jpg',fit: BoxFit.cover, height: height*0.45,width: width,
            ),

            SizedBox(height: height * 0.04,),
            Text('KALTAK' , style: TextStyle(
              fontSize: 20,
              color: Colors.black45,
              fontWeight: FontWeight.w700,
            )),
            Text(' Breaking News, Breaking Norms!',style: TextStyle(
              fontSize: 16,
              color: Colors.black45,
            ) ,),
            SizedBox(height: height * 0.04,),
            SpinKitChasingDots(
              color: Colors.blue ,
                size: 40,
            ),

            
          ],
        ),
      ),
    );
  }
}