import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/core/constants/app_constant.dart';
import 'package:reddit/core/constants/image_path.dart';
import 'package:reddit/features/auth/controller/auth_controller.dart';
import 'package:reddit/theme/palette.dart';

class AppButton extends ConsumerWidget {
  const AppButton(
      {Key? key, required this.text, this.onPressed, required this.icon, this.isGoogleSignIn = false})
      : super(key: key);

  final String text;
  final void Function()? onPressed;
  final String icon;
  final bool isGoogleSignIn;

  void signInWithGoogle(WidgetRef ref) {
   ref.read(authControllerProvider).signInWithGoogle();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(AppConstant.width15),
      child: ElevatedButton.icon(
        onPressed: isGoogleSignIn ? () => signInWithGoogle(ref) : onPressed,
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
