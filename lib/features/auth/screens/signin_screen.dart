import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reddit/core/common/app_button.dart';
import 'package:reddit/core/constants/app_constant.dart';
import 'package:reddit/core/constants/image_path.dart';
import 'package:reddit/core/constants/string_utils.dart';
import 'package:reddit/features/auth/controller/auth_controller.dart';

import '../../../core/common/loader.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Image.asset(ImagePath.logo, height: AppConstant.height40),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text(
                StringUtils.skip,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ]),
      body: isLoading
          ? const Loader()
          : Column(
              children: [
                SizedBox(height: AppConstant.height40),
                Text(
                  StringUtils.diveIntoAnything,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppConstant.width25,
                      letterSpacing: 0.5),
                ),
                SizedBox(height: AppConstant.height20),
                Image.asset(ImagePath.loginEmote),
                SizedBox(height: AppConstant.height40),
                const AppButton(
                  text: StringUtils.continueWithGoogle,
                  icon: ImagePath.google,
                  isGoogleSignIn: true,
                ),
              ],
            ),
    );
  }
}
