import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servefirst_admin/theme/app_theme.dart';

class MyTextField extends StatefulWidget {
  final String? Function(String?)? validation;
  final Function()? onEditComplete;
  final TextEditingController? textEditingController;
  final String hint;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final bool enable;
  final String? initialValue;
  final bool obsecureText;
  final IconData? prefixIcon;
  final TextAlign textAlign;
  final TextInputAction textInputAction;
  final Function(String val)? onChange;
  final double? width;
  final double? height;

  MyTextField(
      {Key? key,
      this.width,
      this.height,
      this.validation,
      this.textEditingController,
      this.hint = "",
      this.onChange,
      this.textInputType,
      this.inputFormatters,
      this.enable = true,
      this.initialValue,
      this.obsecureText = false,
      this.prefixIcon,
      this.textAlign = TextAlign.left,
      this.onEditComplete,
      this.textInputAction = TextInputAction.next})
      : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isVisible = false;

  @override
  void initState() {
    _isVisible = widget.obsecureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        textDirection: TextDirection.ltr,
        controller: widget.textEditingController,
        initialValue: widget.initialValue,
        validator: widget.validation ??
            (val) {
              return null;
            },
        keyboardType: widget.textInputType,
        inputFormatters: widget.inputFormatters,
        textInputAction: widget.textInputAction,
        cursorColor: AppTheme.lightPrimaryColor,
        enabled: widget.enable,
        onChanged: (val) {
          if (widget.onChange != null) {
            widget.onChange!(val);
          }
        },
        onEditingComplete: widget.onEditComplete,
        obscureText: _isVisible,
        style: TextStyle(
            color: Colors.black, fontSize: 13.sp, fontWeight: FontWeight.w500),
        textAlign: widget.textAlign,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          errorStyle: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
          hintText: widget.hint,
          hintStyle: TextStyle(
              color: Colors.black,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500),
            suffixIcon: widget.obsecureText
                ? GestureDetector(
              child: _isVisible
                  ? Icon(
                Icons.visibility_off,
                size: 18.sp,
                color: Colors.grey,
              )
                  : Icon(
                Icons.visibility,
                size: 18.sp,
                color: Colors.grey,
              ),
              onTap: () => setState(() {
                _isVisible = !_isVisible;
              }),
            ) : null,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w,
              vertical: 5.h),
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon, color: Colors.black)
              : null,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(color: Colors.grey, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(color: Colors.grey, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(color: Colors.grey, width: 1)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(color: Colors.grey, width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(color: Colors.grey, width: 1)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(color: Colors.grey, width: 1)),
        ),
      ),
    );
  }
}
