import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wave/app/theme/color_theme.dart';

var kHeadTextStyle = GoogleFonts.lato(
  textStyle: TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    height: 1.2,
  ),
);
var kPlayingFromTextStyle = GoogleFonts.openSans(
  textStyle: TextStyle(
    fontSize: 10,
    //fontWeight: FontWeight.w700,
    height: 1.2,
    color: secondaryDBlue,
  ),
);
var kAlbumTitleTextStyle = GoogleFonts.openSans(
  textStyle: TextStyle(
    fontSize: 10,
    //fontWeight: FontWeight.w700,
    height: 1.2,
    color: white1,
  ),
);
var kSongTitleTextStyle = GoogleFonts.openSans(
  textStyle: TextStyle(
    fontSize: 24,
    //fontWeight: FontWeight.w700,
    height: 1.2,
    color: white1,
  ),
);
var kSongArtistTextStyle = GoogleFonts.openSans(
  textStyle: TextStyle(
    fontSize: 14,
    //fontWeight: FontWeight.w700,
    height: 1.2,
    color: secondaryDBlue,
  ),
);

const kDefaultShadow = BoxShadow(
  offset: Offset(0, 0),
  blurRadius: 90,
  color: Color(0xff42426F),
);
