import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class CustomFormField extends StatefulWidget {
  CustomFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
    this.onChanged,
    this.inputType = TextInputType.text,
    this.isPassword = false,
    this.isReadOnly = false,
    this.isEnabled = true,
  });

  final TextEditingController? controller;
  final String hintText;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final TextInputType inputType;
  final bool isPassword;
  final bool isReadOnly;
  final bool isEnabled;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.isEnabled,
      readOnly: widget.isReadOnly,
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      keyboardType: widget.inputType,
      obscureText: _obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.symmetric(
          horizontal: 4.w,
          vertical: Device.screenType == ScreenType.mobile ? 1.8.h : 2.5.w,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            Device.screenType == ScreenType.mobile ? 10 : 50,
          ),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            Device.screenType == ScreenType.mobile ? 10 : 50,
          ),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            Device.screenType == ScreenType.mobile ? 10 : 50,
          ),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            Device.screenType == ScreenType.mobile ? 10 : 50,
          ),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            Device.screenType == ScreenType.mobile ? 10 : 50,
          ),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        suffixIcon:
            widget.isPassword
                ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
                : null,
      ),
    );
  }
}
