import 'package:flutter/material.dart';
import 'package:reddit/core/constants/app_constant.dart';
import 'package:reddit/core/constants/image_path.dart';
import 'package:reddit/theme/palette.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {Key? key, required this.text, this.onPressed, required this.icon})
      : super(key: key);

  final String text;
  final void Function()? onPressed;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppConstant.width15),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Image.asset(ImagePath.google, width: AppConstant.width35,),
        label: Text(text, style: TextStyle(fontSize: AppConstant.width15),),
        style: ElevatedButton.styleFrom(
          backgroundColor: Palette.greyColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstant.radius25)),
          minimumSize: Size(double.infinity, AppConstant.height50),
        ),
      ),
    );
  }
}
