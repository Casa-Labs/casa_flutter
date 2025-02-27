import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/color_constant.dart';
import '../utils/font.dart';

const ColorScheme lightColorScheme = ColorScheme.light(
  surface: BackgroundColor.white, // lightest // done
  primary: TextColor.black, // for text (say) // done
  secondary: Colors.blue, // 4th // done
  tertiary: TextColor.lightBlue, // same for both modes // done
  inversePrimary: Colors.blue, // darkest
  primaryFixed: Colors.blue, // done
  primaryFixedDim: Colors.blue,
  secondaryFixed: TextColor.black,
  secondaryFixedDim: Colors.blue,
  tertiaryFixed: Colors.blue,
);

ThemeData lightMode = ThemeData(
  fontFamily: GoogleFonts.publicSans().fontFamily, // does not work
  colorScheme: ColorScheme.light(
      surface: lightColorScheme.surface, // lightest // for background
      tertiary: lightColorScheme.tertiary, // 2nd lightest
      primary: lightColorScheme.primary, // 3rd
      secondary: lightColorScheme.secondary, // 4th
      inversePrimary: lightColorScheme.inversePrimary, // darkest
      primaryFixed: lightColorScheme.primaryFixed,
      primaryFixedDim: lightColorScheme.primaryFixedDim,
      secondaryFixed: lightColorScheme.secondaryFixed,
      secondaryFixedDim: lightColorScheme.secondaryFixedDim,
      tertiaryFixed: lightColorScheme.tertiaryFixed,
      error: Colors.red),
  // cardColor: BackgroundColor.lightWhite,
  scaffoldBackgroundColor: lightColorScheme.surface,
  textTheme: Typography.material2021().black.copyWith(
        //https://api.flutter.dev/flutter/material/TextTheme-class.html
        displayLarge: TextStyle(
          //size 57
          fontFamily: Font.shafarik,
        ),
        displayMedium: TextStyle(
          //size 45
          fontFamily: Font.shafarik,
        ),
        displaySmall: TextStyle(
          //size 36
          fontFamily: Font.shafarik,
        ),
        headlineLarge: TextStyle(
          // size 32
          fontFamily: Font.shafarik,
        ),
        headlineMedium: TextStyle(
          // size 28
          fontFamily: Font.shafarik,
        ),
        headlineSmall: TextStyle(
          // size 24
          fontFamily: Font.shafarik,
        ),
        titleLarge: TextStyle(
          // size 22
          fontFamily: Font.shafarik,
        ),
        titleMedium: TextStyle(
          // size 16
          // fontSize: 36.fSize, //done // don't change
          fontFamily: Font.shafarik,
        ),
        titleSmall: TextStyle(
          // size 14
          fontFamily: Font.shafarik,
        ),
        bodyLarge: TextStyle(
          // size 16
          // fontSize: 18.fSize, // done // don't change
          fontFamily: Font.shafarik,
        ),
        bodyMedium: TextStyle(
          // size 14
          fontFamily: Font.shafarik,
        ),
        bodySmall: TextStyle(
          // size 12
          fontFamily: Font.shafarik,
        ),
        labelLarge: TextStyle(
          // size 14
          fontFamily: Font.shafarik,
        ),
        labelMedium: TextStyle(
          // size 12
          fontFamily: Font.shafarik,
        ),
        labelSmall: TextStyle(
          // size 11
          fontFamily: Font.shafarik,
        ),
      ),
  appBarTheme: AppBarTheme(
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    titleTextStyle: TextStyle(color: lightColorScheme.primary, fontSize: 24),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.red,
    foregroundColor: Colors.white,
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      fontFamily: GoogleFonts.publicSans().fontFamily,
      color: Colors.black,
      fontSize: 18,
    ),
    errorStyle: TextStyle(
      color: ErrorColor.red,
      fontSize: 12,
    ),
    errorMaxLines: 4,
    fillColor: BackgroundColor.white,
    contentPadding: EdgeInsets.all(10),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        color: BorderColor.black,
        width: 0.5,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        color: BorderColor.black,
        width: 0.5,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        color: BorderColor.black,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: ErrorColor.red,
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: ErrorColor.red,
      ),
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  chipTheme: ChipThemeData(
    labelPadding: EdgeInsets.symmetric(horizontal: 20),
  ),
);
