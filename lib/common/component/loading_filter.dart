import 'dart:ui';

import 'package:flutter/material.dart';

List<Widget> buildLoadingFilter({required bool isLoading}) {
  return [
    isLoading
        ? Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10.0,
                sigmaY: 10.0,
              ),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          )
        : const SizedBox(),
    if (isLoading)
      const Center(
        child: CircularProgressIndicator(),
      )
    else
      const SizedBox()
  ];
}
