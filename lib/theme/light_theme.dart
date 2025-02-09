import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/color_constant.dart';

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
          fontFamily: GoogleFonts.publicSans().fontFamily,
        ),
        displayMedium: TextStyle(
          //size 45
          fontFamily: GoogleFonts.publicSans().fontFamily,
        ),
        displaySmall: TextStyle(
          //size 36
          fontFamily: GoogleFonts.publicSans().fontFamily,
        ),
        headlineLarge: TextStyle(
          // size 32
          fontFamily: GoogleFonts.publicSans().fontFamily,
        ),
        headlineMedium: TextStyle(
          // size 28
          fontFamily: GoogleFonts.publicSans().fontFamily,
        ),
        headlineSmall: TextStyle(
          // size 24
          fontFamily: GoogleFonts.publicSans().fontFamily,
        ),
        titleLarge: TextStyle(
          // size 22
          fontFamily: GoogleFonts.publicSans().fontFamily,
        ),
        titleMedium: TextStyle(
          // size 16
          // fontSize: 36.fSize, //done // don't change
          fontFamily: GoogleFonts.publicSans().fontFamily,
        ),
        titleSmall: TextStyle(
          // size 14
          fontFamily: GoogleFonts.publicSans().fontFamily,
        ),
        bodyLarge: TextStyle(
          // size 16
          // fontSize: 18.fSize, // done // don't change
          fontFamily: GoogleFonts.publicSans().fontFamily,
        ),
        bodyMedium: TextStyle(
          // size 14
          fontFamily: GoogleFonts.publicSans().fontFamily,
        ),
        bodySmall: TextStyle(
          // size 12
          fontFamily: GoogleFonts.publicSans().fontFamily,
        ),
        labelLarge: TextStyle(
          // size 14
          fontFamily: GoogleFonts.publicSans().fontFamily,
        ),
        labelMedium: TextStyle(
          // size 12
          fontFamily: GoogleFonts.publicSans().fontFamily,
        ),
        labelSmall: TextStyle(
          // size 11
          fontFamily: GoogleFonts.publicSans().fontFamily,
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
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(
        color: BorderColor.black,
        width: 0.5,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(
        color: BorderColor.black,
        width: 0.5,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(
        color: BorderColor.black,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: ErrorColor.red,
      ),
      borderRadius: BorderRadius.circular(6),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: ErrorColor.red,
      ),
      borderRadius: BorderRadius.circular(6),
    ),
  ),
  chipTheme: ChipThemeData(
    labelPadding: EdgeInsets.symmetric(horizontal: 20),
  ),
);
