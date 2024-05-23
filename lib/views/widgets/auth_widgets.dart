// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tablo/core/clippers/custom_clipper.dart';
import 'package:e_tablo/core/extensions.dart';
import 'package:e_tablo/core/widgets/custom_corner_frame.dart';
import 'package:flutter/material.dart';

class AuthCardWidget extends StatelessWidget {
  const AuthCardWidget({
    Key? key,
    required this.children,
  }) : super(key: key);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.85,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 350,
            child: Card(
              elevation: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: children,
                ),
              ),
            ),
          ),
          // TextButton(onPressed: () {}, child: const Text("Hesap Oluştur"))
        ],
      ),
    );
  }
}

class AuthClipDecoration extends StatelessWidget {
  const AuthClipDecoration({
    Key? key,
    required this.title,
    required this.buttonTitle,
    required this.colorGradient,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final String buttonTitle;
  final List<Color> colorGradient;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ContainerClipper(),
      child: Container(
        alignment: Alignment.center,
        width: context.width,
        height: 250,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: colorGradient)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CornerFrame(
                color: Colors.white70,
                edgeLength: 10,
                paddingInline: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  title,
                  style: context.texts.headlineMedium?.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                )),
            TextButton(
                style: const ButtonStyle(foregroundColor: MaterialStatePropertyAll(Colors.white)),
                onPressed: onPressed,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text(buttonTitle), const Icon(Icons.chevron_right_rounded)],
                ))
          ],
        ),
      ),
    );
  }
}

class MainAuthCompanents extends StatelessWidget {
  const MainAuthCompanents({
    super.key,
    required String title,
    required String buttonTitle,
    required List<Color> colorGradient,
    required List<Widget> authCardChildren,
    required VoidCallback authClipDecorationOnTap,
  })  : _title = title,
        _buttonTitle = buttonTitle,
        _authCardChildren = authCardChildren,
        _colorGradient = colorGradient,
        _authClipDecorationOnTap = authClipDecorationOnTap;

  final String _title;
  final String _buttonTitle;
  final List<Color> _colorGradient;
  final VoidCallback _authClipDecorationOnTap;
  final List<Widget> _authCardChildren;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
          child: Column(
        children: [
          AuthClipDecoration(
            colorGradient: _colorGradient,
            title: _title,
            buttonTitle: _buttonTitle,
            onPressed: _authClipDecorationOnTap,
          ),
          AuthCardWidget(children: _authCardChildren)
        ],
      )),
    );
  }
}
