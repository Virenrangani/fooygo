import 'package:flutter/material.dart';
import 'package:foodygo/core/constant/string/custom_string.dart';
import 'package:foodygo/feature/auth/presentation/pages/login.dart';
import 'package:foodygo/feature/auth/presentation/pages/signup.dart';
import 'package:slidable_button/slidable_button.dart';
import '../../admin_login/presentation/page/admin_login_page.dart';

class ClickableButton extends StatefulWidget {
  const ClickableButton({super.key});

  @override
  State<ClickableButton> createState() => _ClickableButtonState();
}

class _ClickableButtonState extends State<ClickableButton> {
  String result = CustomString.letsSlide;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:BoxDecoration(
          gradient:LinearGradient(colors:[Colors.
              deepOrange,Colors.deepOrangeAccent],
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
                     Flexible(
                       child: Padding(
                         padding: const EdgeInsets.all(10),
                         child: Text(CustomString.slideButtonForSignAdmin,
                          style:TextStyle(fontSize:25,fontWeight:FontWeight.bold),),
                       ),
                     ),
                    const SizedBox(height: 16.0),
                    HorizontalSlidableButton(
                      initialPosition: SlidableButtonPosition.center,
                      width: MediaQuery.of(context).size.width / 1.5,
                      height:60,
                      buttonWidth: 80.0,
                      color:Colors.black,
                      buttonColor:Colors.white,
                      dismissible: false,
                      label: const Center(child: Text(CustomString.slidMe,overflow:TextOverflow.ellipsis,
                        style:TextStyle(fontSize:18,fontWeight:FontWeight.bold,color: Colors.black),)),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(CustomString.login,style:TextStyle(fontSize:15,fontWeight:FontWeight.bold,color: Colors.white),),
                            Text(CustomString.admin,style:TextStyle(fontSize:15,fontWeight:FontWeight.bold,color: Colors.white),),
                          ],
                        ),
                      ),
                      onChanged: (position) {
                        setState(() {
                          if (position == SlidableButtonPosition.end) {
                            Navigator.push(context,
                                MaterialPageRoute(builder:(context) =>AdminLoginPage(),));
                          } else {
                            Navigator.push(context,
                                MaterialPageRoute(builder:(context) =>Login(),));;
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




