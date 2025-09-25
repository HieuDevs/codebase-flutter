import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  ColorScheme get getColor => Theme.of(this).colorScheme;

  TextTheme get getTextTheme => Theme.of(this).textTheme;
}
