// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tablo/core/widgets/custom_corner_frame.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.hintText,
    this.suffix,
    required this.controller,
    this.isPassword,
  }) : super(key: key);
  final String hintText;
  final Widget? suffix;
  final TextEditingController controller;
  final bool? isPassword;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isVisible;

  @override
  void initState() {
    _isVisible = widget.isPassword ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CornerFrame(
        strokeWidth: 2,
        paddingInline: const EdgeInsets.symmetric(horizontal: 15),
        child: TextFormField(
          controller: widget.controller,
          obscureText: _isVisible,
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: (widget.isPassword ?? false)
                ? PasswordVisibility(visibilityCallback: (isVisible) {
                    setState(() {
                      _isVisible = isVisible;
                    });
                  })
                : widget.suffix,
          ),
        ));
  }
}

class PasswordVisibility extends StatefulWidget {
  const PasswordVisibility({
    Key? key,
    required this.visibilityCallback,
  }) : super(key: key);
  final Function(bool isVisible) visibilityCallback;

  @override
  State<PasswordVisibility> createState() => _PasswordVisibilityState();
}

class _PasswordVisibilityState extends State<PasswordVisibility> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isVisible = !_isVisible;
          widget.visibilityCallback.call(_isVisible);
        });
      },
      child: Container(
        constraints: BoxConstraints.loose(Size.zero),
        alignment: Alignment.centerRight,
        child: AnimatedCrossFade(
            firstChild: const Icon(Icons.visibility_rounded, size: 20),
            secondChild: const Icon(Icons.visibility_off_rounded, size: 20),
            crossFadeState: _isVisible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 500)),
      ),
    );
  }
}
