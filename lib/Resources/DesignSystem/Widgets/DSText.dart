import 'package:flutter/widgets.dart';

class DSText {
  static Widget large(String text,
      {TextAlign? textAlign,
      Color? color,
      FontWeight? fontWeight,
      TextOverflow? overflow,
      int? maxLines}) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: 16,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? const Color(0xFF000000),
      ),
    );
  }

  static Widget medium(String text,
      {TextAlign? textAlign,
      Color? color,
      FontWeight? fontWeight,
      TextOverflow? overflow,
      int? maxLines}) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: 14,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? const Color(0xFF000000),
      ),
    );
  }

  static Widget compact(String text,
      {TextAlign? textAlign,
      Color? color,
      FontWeight? fontWeight,
      TextOverflow? overflow,
      bool? softWrap,
      int? maxLines}) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      style: TextStyle(
        fontSize: 12,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? const Color(0xFF000000),
      ),
    );
  }

  static Widget extraCompact(String text,
      {TextAlign? textAlign, Color? color, FontWeight? fontWeight}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: 10,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? const Color(0xFF000000),
      ),
    );
  }

  // Methods with TextDecoration support
  static Widget largeWithDecoration(String text,
      {TextAlign? textAlign,
      Color? color,
      FontWeight? fontWeight,
      TextDecoration? decoration}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: 16,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? const Color(0xFF000000),
        decoration: decoration,
      ),
    );
  }

  static Widget mediumWithDecoration(String text,
      {TextAlign? textAlign,
      Color? color,
      FontWeight? fontWeight,
      TextDecoration? decoration}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: 14,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? const Color(0xFF000000),
        decoration: decoration,
      ),
    );
  }

  static Widget compactWithDecoration(String text,
      {TextAlign? textAlign,
      Color? color,
      FontWeight? fontWeight,
      TextDecoration? decoration}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: 12,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? const Color(0xFF000000),
        decoration: decoration,
      ),
    );
  }
}
