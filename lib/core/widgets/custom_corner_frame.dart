
import 'package:e_tablo/core/clippers/custom_clipper.dart';
import 'package:flutter/material.dart';

class CornerFrame extends StatelessWidget {
  final Widget child;
  final double edgeLength;
  final double strokeWidth;
  final EdgeInsetsGeometry? paddingOutline;
  final EdgeInsetsGeometry? paddingInline;
  final Color? color;

  const CornerFrame({
    super.key,
    this.color,
    required this.child,
    this.edgeLength = 10.0,
    this.strokeWidth = 2.0,
    this.paddingInline,
    this.paddingOutline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingOutline,
      child: CustomPaint(
        painter: CornerFramePainter(color: color, strokeWidth: strokeWidth, edgeLength: edgeLength),
        child: Container(padding: paddingInline, child: child),
      ),
    );
  }
}