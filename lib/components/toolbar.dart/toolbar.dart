import 'package:flutter/material.dart';

getDynamicSizedBox({height, width}) {
  return SizedBox(height: height ?? 0, width: width ?? 0);
}

bool isSmallDevice(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  // Retrieve the screen height
  final screenHeight = mediaQuery.size.height;
  // Define the threshold height below which the device is considered small
  const smallDeviceHeightThreshold = 700.0;
  // Check if the device is small based on the screen height
  return screenHeight < smallDeviceHeightThreshold;
}
