import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterchatapp/components/toolbar.dart/toolbar.dart';
import 'package:flutterchatapp/configs/assets_constant.dart';
import 'package:flutterchatapp/configs/colors_constant.dart';
import 'package:sizer/sizer.dart';

Widget getCenterappbar({title}) {
  return Center(
    child: Text(
      title,
      style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.bold),
    ),
  );
}

Widget getleftsidebackbtn({required backFunction, required title}) {
  return Container(
    height: 10.h,
    decoration: BoxDecoration(color: transparent),
    child: Row(
      children: [
        Container(
          decoration: BoxDecoration(color: grey, shape: BoxShape.circle),
          child: InkWell(
            onTap: () {
              backFunction();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.arrow_back, color: darkPurple),
            ),
          ),
        ),
        getDynamicSizedBox(width: 1.w),
        Row(
          children: [
            CircleAvatar(
              backgroundColor: grey,
              backgroundImage: AssetImage(Assets.person),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget featureIcon({
  required IconData icon,
  required String title,
  required String subtitle,
}) {
  return Container(
    width: 28.w,
    height: 12.h,
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: grey, width: 0.5.w),
    ),
    child: Column(
      children: [
        Icon(icon, size: 20.sp),

        Text(title),

        Text(subtitle, style: TextStyle(color: grey, fontSize: 13.sp)),
      ],
    ),
  );
}
