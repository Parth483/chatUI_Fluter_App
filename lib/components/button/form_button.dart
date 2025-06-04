import 'package:flutter/material.dart';
import 'package:flutterchatapp/components/toolbar.dart/toolbar.dart';
import 'package:flutterchatapp/configs/colors_constant.dart';
import 'package:flutterchatapp/utils/helper.dart';
import 'package:sizer/sizer.dart';

getFormButton(
  BuildContext context,
  Function fun,
  str, {
  required bool validate,
  isdelete = false,
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(
      Device.screenType == ScreenType.mobile ? 5.h : 1.4.h,
    ),
    focusColor: primaryColor,
    hoverColor: primaryColor,
    radius: 10.32,
    onTap: () {
      fun();
    },
    child: Container(
      height:
          Device.screenType == ScreenType.mobile
              ? isSmallDevice(context)
                  ? 8.h
                  : 6.h
              : 5.9.h,
      alignment: Alignment.center,
      //  padding: EdgeInsets.only(top: 1.h),
      width:
          Device.screenType == ScreenType.mobile
              ? Device.width / 1
              : Device.width / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Device.screenType == ScreenType.mobile ? 1.h : 1.4.h,
        ),
        color:
            validate
                ? isDarkMode()
                    ? white
                    : isdelete
                    ? red
                    : white
                : grey,
        boxShadow: [
          BoxShadow(
            color: validate ? black.withOpacity(0.2) : grey.withOpacity(0.2),
            blurRadius: 10.0,
            offset: const Offset(0, 1),
            spreadRadius: 3.0,
          ),
        ],
      ),
      child: Text(
        str,
        style: TextStyle(
          color: isDarkMode() ? white : black,
          // fontFamily: dM_sans_bold,
          fontSize: Device.screenType == ScreenType.mobile ? 18.sp : 9.sp,
        ),
      ),
    ),
  );
}
