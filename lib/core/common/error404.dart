
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reddit/core/common/svg_render_widget.dart';

import '../constants/svg_path.dart';
class Error404Page extends StatelessWidget {
  final String? error;
  const Error404Page({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const SvgRenderWidget(svgPath: SvgPath.frameFour04),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(height: 220.h,),
                SvgRenderWidget(svgPath: SvgPath.four04, width: 400.w,),
                SizedBox(height: 20.h,),
                Text('Oops, you’ve lost in space $error'),
                const Text(
                  'We can’t find the page that you’re looking for'
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgRenderWidget(svgPath: SvgPath.blob1, width: 550.w,),
          ),
        ],
      ),
    );
  }
}