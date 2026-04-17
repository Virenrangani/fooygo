import 'dart:async';
import 'package:flutter/material.dart';
import '../../../home/presentation/page/bottomnav.dart';

class ThankYou extends StatefulWidget {
  const ThankYou({super.key});

  @override
  State<ThankYou> createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYou> {
  void startTimer(){
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder:(context) =>BottomNav(),));
      setState(() {
      });
    });
  }
  @override
  void initState() {
    startTimer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration:BoxDecoration(
          gradient:LinearGradient(colors:
          [Colors.pinkAccent,Colors.cyan,Colors.redAccent,],
            begin:Alignment.topLeft,
              end:Alignment.bottomRight
          )
      ),
            child:Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                Center(child: Text('THANK YOU..!!',
                  style:TextStyle(fontSize:30,fontWeight:FontWeight.bold,),)),
                Container(
                    height:80,
                    width:80,
                    decoration:BoxDecoration(
                        color:Colors.black,
                        borderRadius:BorderRadius.circular(25)
                    ),
                    child: Icon(Icons.emoji_emotions_outlined,size:60,color:Colors.white,)
                )
              ],
            ),
      ),
    );
  }
}
