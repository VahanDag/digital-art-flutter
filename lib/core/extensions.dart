import 'package:flutter/material.dart';

extension CustomExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  TextTheme get texts => Theme.of(this).textTheme;
}