import 'package:flutter/material.dart';

T useColorMode<T>(BuildContext context, T light, T dark) {
  Brightness brightness = Theme.of(context).brightness;

  if (brightness == Brightness.light) {
    return light;
  } else {
    return dark;
  }
}
