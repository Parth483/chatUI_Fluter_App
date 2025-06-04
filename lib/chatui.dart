import 'package:flutter/material.dart';
import 'package:flutterchatapp/chatuiCtr.dart';
import 'package:flutterchatapp/components/chat_bubble.dart';
import 'package:flutterchatapp/configs/colors_constant.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class Chatui extends StatefulWidget {
  const Chatui({super.key});

  @override
  State<Chatui> createState() => _ChatuiState();
}

class _ChatuiState extends State<Chatui> {
  final controller = Get.put(ChatController());
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToBottom = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.hasClients) {
      final position = _scrollController.position;
      setState(() {
        _showScrollToBottom = position.pixels > 100;
      });
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: darkPurple,
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black87,
                            size: 2.5.h,
                          ),
                        ),
                      ),
                      // IconButton(
                      //   icon: Icon(
                      //     Icons.arrow_back,
                      //     color: Colors.black87,
                      //     size: 2.5.h,
                      //   ),
                      //   onPressed: () => Get.back(),
                      // ),
                      SizedBox(width: 3.w),
                      Stack(
                        children: [
                          Container(
                            width: 6.h,
                            height: 6.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.amber,
                            ),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 3.h,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Obx(
                              () => Container(
                                width: 1.5.h,
                                height: 1.5.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      controller.isOnline.value
                                          ? Colors.green
                                          : Colors.grey,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 3.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ms. Emily',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Online',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Chat List
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.w,
                        vertical: 2.h,
                      ),
                      itemCount: controller.messages.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        final message = controller.messages[index];
                        final time = DateFormat(
                          'h:mm a',
                        ).format(message.createdAt.toLocal());
                        return ChatBubble(
                          message: message.text,
                          isMe: message.authorId == controller.currentUserId,
                          time: time,
                        );
                      },
                    ),
                  ),
                ),
                // Input Field
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F0F5),
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _textController,
                                  style: TextStyle(fontSize: 15.sp),
                                  decoration: InputDecoration(
                                    hintText: 'Type message...',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 15.sp,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 6.w,
                                      vertical: 2.h,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(0.8.h),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF8B5CF6),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(
                                    minWidth: 5.h,
                                    minHeight: 5.h,
                                  ),
                                  icon: Transform.translate(
                                    offset: Offset(0.5.w, 0),
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.white,
                                      size: 2.5.h,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_textController.text
                                        .trim()
                                        .isNotEmpty) {
                                      controller.addMessage(
                                        _textController.text,
                                      );
                                      _textController.clear();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (_showScrollToBottom)
              Positioned(
                right: 4.w,
                bottom: 12.h,
                child: FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.white,
                  elevation: 2,
                  onPressed: _scrollToBottom,
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: const Color(0xFF8B5CF6),
                    size: 3.h,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
