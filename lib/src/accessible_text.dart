import 'package:flutter/cupertino.dart';
import 'package:flutter_accessible_text/src/size_config.dart';
import 'package:flutter_accessible_text/src/text_role.dart';




class AccessibleText {
  static Widget text(
      BuildContext context,
      String text, {
        TextStyle? style,
        TextRole role = TextRole.content,
        TextAlign? align,
        int? maxLines,
        TextOverflow? overflow,
        String? semanticLabel,
      }) {
    final fontSize = style?.fontSize ?? 14;

    final scaledSize = role == TextRole.chrome
        ? SizeConfig.spCapped(context, fontSize)
        : SizeConfig.sp(fontSize);

    final finalStyle = style?.copyWith(fontSize: scaledSize) ??
        TextStyle(fontSize: scaledSize);

    return Semantics(
      label: semanticLabel ?? text,
      child: Text(
        text,
        style: finalStyle,
        textAlign: align,
        maxLines: SizeConfig.isXLText ? null : maxLines,
        overflow:
        SizeConfig.isXLText ? TextOverflow.visible : overflow,
      ),
    );
  }
}