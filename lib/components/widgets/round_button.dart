import 'package:flutter/material.dart';
import 'package:flutterchatapp/configs/colors_constant.dart';
import 'package:sizer/sizer.dart';

class RoundButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  const RoundButton({super.key, required this.title, required this.onPressed});

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5.h,
      width: 40.w,

      decoration: BoxDecoration(
        color: greylight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          widget.onPressed();
        },
        child: SizedBox(child: Center(child: Text(widget.title))),
      ),
    );
  }
}
