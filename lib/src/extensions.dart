import 'package:flutter/widgets.dart';
import 'size_config.dart';

extension FontScaling on num {
  /// Content text (full scaling)
  double sp(BuildContext context) {
    return SizeConfig.sp(toDouble());
  }

  /// Chrome text (capped scaling)
  double spChrome(BuildContext context, {double maxFactor = 1.3}) {
    return SizeConfig.spCapped(
      context,
      toDouble(),
      maxFactor: maxFactor,
    );
  }
}
extension SizeScaling on num {
  double h() => SizeConfig.h(toDouble());
  double w() => SizeConfig.w(toDouble());
  double scale() => SizeConfig.scale(toDouble());
}