import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String time;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.isMe,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(
            left: isMe ? 20.w : 4.w,
            right: isMe ? 4.w : 20.w,
          ),
          decoration: BoxDecoration(
            color: isMe ? const Color(0xFF8B5CF6) : const Color(0xFFF1F0F5),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: Radius.circular(isMe ? 0 : 20),
              bottomLeft: Radius.circular(isMe ? 20 : 0),
              bottomRight: const Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.2.h),
          child: Text(
            message,
            style: TextStyle(
              color: isMe ? Colors.white : Colors.black87,
              fontSize: 18.sp,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 0.5.h,
            left: isMe ? 0 : 5.w,
            right: isMe ? 5.w : 0,
            bottom: 1.h,
          ),
          child: Text(
            time,
            style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
