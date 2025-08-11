import 'package:flutter/material.dart';

@immutable
class GradientsExtension extends ThemeExtension<GradientsExtension> {
  final LinearGradient greenGradient;
  final LinearGradient beigeGradient;

  const GradientsExtension({
    required this.greenGradient,
    required this.beigeGradient,
  });

  @override
  GradientsExtension copyWith({
    LinearGradient? greenGradient,
    LinearGradient? beigeGradient,
  }) {
    return GradientsExtension(
      greenGradient: greenGradient ?? this.greenGradient,
      beigeGradient: beigeGradient ?? this.beigeGradient,
    );
  }

  @override
  GradientsExtension lerp(ThemeExtension<GradientsExtension>? other, double t) {
    if (other is! GradientsExtension) {
      return this;
    }
    return t < 0.5 ? this : other;
  }
}