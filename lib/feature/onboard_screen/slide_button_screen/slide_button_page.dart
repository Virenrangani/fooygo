import 'package:flutter/material.dart';
import 'package:foodygo/core/constant/color/custom_color.dart';
import 'package:foodygo/core/constant/font_size/custom_text_style.dart';
import 'package:foodygo/core/constant/padding/custom_padding.dart';
import 'package:foodygo/core/constant/string/custom_string.dart';
import 'package:foodygo/feature/auth/presentation/pages/login.dart';
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
      backgroundColor: CustomColor.primaryLight,
      body: Center(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

               Flexible(
                 child: Padding(
                   padding: CustomPadding.edgeAll12,
                   child: Text(CustomString.slideButtonForSignAdmin,
                    style:CustomTextStyles.h3),
                 ),
               ),

              const SizedBox(height: 16.0),

              HorizontalSlidableButton(
                initialPosition: SlidableButtonPosition.center,
                width: MediaQuery.of(context).size.width / 1.5,
                height:60,
                buttonWidth: 80.0,
                color:CustomColor.textPrimary,
                buttonColor:CustomColor.background,
                dismissible: false,
                label: const Center(child: Text(CustomString.slidMe,overflow:TextOverflow.ellipsis,
                  style:CustomTextStyles.bodyLarge
                )
                ),
                child: Padding(
                  padding: CustomPadding.edgeAll8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text(CustomString.login,
                        style:CustomTextStyles.h3.copyWith(color:CustomColor.background),),

                      Text(CustomString.admin,
                        style:CustomTextStyles.h3.copyWith(color:CustomColor.background),),
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
      ),
    );
  }
}




