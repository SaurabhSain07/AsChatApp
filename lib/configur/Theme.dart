import 'package:aschatapp/configur/Colors.dart';
import 'package:flutter/material.dart';


var lightTheme=ThemeData();
var darkTheme=ThemeData(
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    backgroundColor: dContanerColor,
  ),
  useMaterial3: true,
  inputDecorationTheme:const InputDecorationTheme(
    border: UnderlineInputBorder(
      borderSide: BorderSide.none
    ),
    fillColor: dBackgroundColor,
    filled: true
  ),
  colorScheme:const ColorScheme.dark(
    primary: dPrimaryColor,
    onPrimary: dOnBackgroundColor,
    background: dBackgroundColor,
    onBackground: dOnBackgroundColor,
    primaryContainer: dContanerColor,
    onPrimaryContainer: dOnContanerColor,
  ),

  textTheme:const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      color: dPrimaryColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w800,
    ),

    headlineMedium: TextStyle(
      fontSize: 30,
      color: dOnBackgroundColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w600,
    ),

    headlineSmall: TextStyle(
      fontSize: 20,
      color: dOnBackgroundColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w600,
    ),

    bodyLarge: TextStyle(
      fontSize: 18,
      color: dOnBackgroundColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w500,
    ),
    
    bodyMedium: TextStyle(
      fontSize: 15,
      color: dOnBackgroundColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w500,
    ),
    labelLarge: TextStyle(
      fontSize: 15,
      color: dOnContanerColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400,
    ),

    labelMedium: TextStyle(
      fontSize: 12,
      color: dOnContanerColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400,
    ),

    labelSmall: TextStyle(
      fontSize: 10,
      color: dOnContanerColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w300,
    ),
  )
);