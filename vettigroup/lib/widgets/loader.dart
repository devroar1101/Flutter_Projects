import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:vettigroup/config/palette.dart';

class Loader extends StatelessWidget {
  const Loader({super.key, required this.type});

  final int type;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: type == 1
          ? LoadingAnimationWidget.inkDrop(
              color: Palette.vettiGroupColor, size: 50)
          : LoadingAnimationWidget.fallingDot(
              color: Palette.vettiGroupColor, size: 30),
    );
  }
}
