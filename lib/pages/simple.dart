import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class simple extends StatefulWidget {
  const simple({super.key});

  @override
  State<simple> createState() => _simpleState();
}

class _simpleState extends State<simple> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.only(top:50),
        child: Container(
          child:Column(
            children: [
              SizedBox(
                child:SingleChildScrollView(
                  scrollDirection:Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        color:Colors.red,
                        height:300,
                        width:200,
                      ),
                      Container(
                        color:Colors.green,
                        height:300,
                        width:200,
                      ),
                      Container(
                        color:Colors.red,
                        height:300,
                        width:200,
                      ),
                      Container(
                        color:Colors.green,
                        height:300,
                        width:200,
                      ),
                      Container(
                        color:Colors.red,
                        height:300,
                        width:200,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height:50,),
              SizedBox(
                child:SingleChildScrollView(
                  scrollDirection:Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        color:Colors.red,
                        height:200,
                      ),
                      Container(
                        color:Colors.green,
                        height:300,
                      ),
                      Container(
                        color:Colors.red,
                        height:200,
                      ),
                      Container(
                        color:Colors.green,
                        height:300,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
