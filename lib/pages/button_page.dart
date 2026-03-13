import 'package:flutter/material.dart';
import 'package:foodygo/feature/auth/presentation/pages/signup.dart';
import 'package:slidable_button/slidable_button.dart';

import '../admin/admin_login.dart';

class ClickableButton extends StatefulWidget {
  const ClickableButton({super.key});

  @override
  State<ClickableButton> createState() => _ClickableButtonState();
}

class _ClickableButtonState extends State<ClickableButton> {
  String result = "Let's slide!";
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:BoxDecoration(
          gradient:LinearGradient(colors:[Colors.
              black,Colors.green],
            begin:Alignment.topLeft,end:Alignment.bottomRight
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    const Text('Slide this button to admin or signup.',
                      style:TextStyle(fontSize:25,fontWeight:FontWeight.bold),),
                    const SizedBox(height: 16.0),
                    HorizontalSlidableButton(
                      initialPosition: SlidableButtonPosition.center,
                      width: MediaQuery.of(context).size.width / 1.5,
                      height:60,
                      buttonWidth: 80.0,
                      color:Colors.deepOrangeAccent,
                      buttonColor:Colors.blue,
                      dismissible: false,
                      label: const Center(child: Text('Slide Me',
                        style:TextStyle(fontSize:18,fontWeight:FontWeight.bold),)),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('SIGNUP',style:TextStyle(fontSize:15,fontWeight:FontWeight.bold),),
                            Text('ADMIN',style:TextStyle(fontSize:15,fontWeight:FontWeight.bold),),
                          ],
                        ),
                      ),
                      onChanged: (position) {
                        setState(() {
                          if (position == SlidableButtonPosition.end) {
                            Navigator.push(context,
                                MaterialPageRoute(builder:(context) =>AdminLogin(),));
                          } else {
                            Navigator.push(context,
                                MaterialPageRoute(builder:(context) =>Signup(),));;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




