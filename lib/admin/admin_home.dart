import 'package:flutter/material.dart';

import 'add_food.dart';


class adminHome extends StatefulWidget {
  const adminHome({super.key});

  @override
  State<adminHome> createState() => _adminHomeState();
}

class _adminHomeState extends State<adminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        padding:EdgeInsets.only(top:10),
        margin:EdgeInsets.only(left:50,right: 50,top:50),
        child:Column(
          children: [
            Center(
              child:Text('ADMIN HOME',style:TextStyle
                (fontWeight:FontWeight.bold,fontSize:25),),
            ),
            SizedBox(height:30,),
            GestureDetector(onTap:(){
              Navigator.push(context,MaterialPageRoute(builder:(context) =>AddFood(),));
            },
              child: Material(elevation:15,borderRadius:BorderRadius.circular(10),
                child: Container(decoration:BoxDecoration(
                    color:Colors.black,
                    borderRadius:BorderRadius.circular(10)
                ),
                  child:Row(
                    children: [
                      Image.asset('assets/image/salad2.png',
                        height: 100,width: 100,fit: BoxFit.cover,),
                      Text('ADD FOOD ITEMS',style:TextStyle
                        (fontWeight:FontWeight.bold,fontSize:23,color:Colors.white),)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
