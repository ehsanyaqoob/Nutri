import 'package:flutter/widgets.dart';

class OnBoardingModel {
  final String title;
  final String image;
  final Color? backgroundColor;

  const OnBoardingModel({
    required this.title,
    required this.image,
    this.backgroundColor,
  });
}
