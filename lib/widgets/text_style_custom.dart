import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyleCustom(
    {required double fontSize, Color? color, FontWeight? fontWeight}) {
  return GoogleFonts.poppins(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}
