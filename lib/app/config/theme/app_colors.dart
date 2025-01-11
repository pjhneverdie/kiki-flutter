import 'package:flutter/material.dart';

extension AppColorsShortCut on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}

class AppColors extends ThemeExtension<AppColors> {
  final Color strongWhite;
  final Color middleWhite;

  final Color strongBlack;
  final Color middleBlack;
  final Color weakBlack;

  final Color kakaoYellow;
  final Color kakaoBlue;

  final Color strongGray;
  final Color weakGray;
  final Color blueGray;

  const AppColors({
    required this.strongWhite,
    required this.middleWhite,
    required this.strongBlack,
    required this.middleBlack,
    required this.weakBlack,
    required this.kakaoYellow,
    required this.kakaoBlue,
    required this.strongGray,
    required this.weakGray,
    required this.blueGray,
  });

  factory AppColors.init() {
    return const AppColors(
      strongWhite: Colors.white,
      middleWhite: Color(0xFFF4F3F3),
      strongBlack: Colors.black,
      middleBlack: Color(0xFF1B1B1C),
      weakBlack: Color(0xFF1d1e20),
      kakaoYellow: Color(0xFFFEE500),
      kakaoBlue: Color(0xFF9bbbd4),
      strongGray: Color(0xFF6C6C6C),
      weakGray: Color(0xFFDADADB),
      blueGray: Color(0xFFF7FAFC),
    );
  }

  @override
  AppColors copyWith({
    Color? strongWhite,
    Color? middleWhite,
    Color? strongBlack,
    Color? middleBlack,
    Color? weakBlack,
    Color? kakaoYellow,
    Color? kakaoBlue,
    Color? strongGray,
    Color? weakGray,
    Color? blueGray,
    Color? middleGray,
  }) {
    return AppColors(
      strongWhite: strongWhite ?? this.strongWhite,
      middleWhite: middleWhite ?? this.middleWhite,
      strongBlack: strongBlack ?? this.strongBlack,
      middleBlack: middleBlack ?? this.middleBlack,
      weakBlack: weakBlack ?? this.weakBlack,
      kakaoYellow: kakaoYellow ?? this.kakaoYellow,
      kakaoBlue: kakaoBlue ?? this.kakaoBlue,
      strongGray: strongGray ?? this.strongGray,
      weakGray: weakGray ?? this.weakGray,
      blueGray: middleGray ?? this.blueGray,
    );
  }

  @override
  AppColors lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;

    return AppColors(
      strongWhite: Color.lerp(strongWhite, other.strongWhite, t)!,
      middleWhite: Color.lerp(middleWhite, other.middleWhite, t)!,
      strongBlack: Color.lerp(strongBlack, other.strongBlack, t)!,
      middleBlack: Color.lerp(middleBlack, other.middleBlack, t)!,
      weakBlack: Color.lerp(weakBlack, other.weakBlack, t)!,
      kakaoYellow: Color.lerp(kakaoYellow, other.kakaoYellow, t)!,
      kakaoBlue: Color.lerp(kakaoBlue, other.kakaoBlue, t)!,
      strongGray: Color.lerp(strongGray, other.strongGray, t)!,
      weakGray: Color.lerp(weakGray, other.weakGray, t)!,
      blueGray: Color.lerp(blueGray, other.blueGray, t)!,
    );
  }
}
