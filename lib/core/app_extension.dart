import 'package:flutter/material.dart';
import 'package:flutter_template/widgets/fade_in_animation.dart';

extension WidgetExtension on Widget {
  Widget fadeAnimation(double delay) {
    return FadeInAnimation(delay: delay, child: this);
  }
}
