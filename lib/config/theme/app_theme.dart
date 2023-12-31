
import 'package:flutter/material.dart';


class AppTheme {

  static const Color primary = Color(0xC5086474);

  static final ThemeData ligthTheme = ThemeData.light().copyWith(

    // color primario
    primaryColor: const Color(0xC657DFF7),

    // AppBar theme
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 25
      ) 
    ),

    // TextButton theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary
      ),
    ),

    // FloatingActionButton
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xff09B394),
      elevation: 5
    ),

    // ElevatedButton
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff09B394),
        shape: const StadiumBorder(),
        elevation: 0,
        foregroundColor: Colors.white
      )
    ),

    // InputDecorationTheme
    inputDecorationTheme: const InputDecorationTheme(
      
      floatingLabelStyle: TextStyle( color: primary ),
      
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide( color: primary ),
        borderRadius: BorderRadius.only( 
          bottomLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        )
      ),

      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide( color: primary ),
        borderRadius: BorderRadius.only( 
          bottomLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        )
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.only( 
          bottomLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        )
      ),

    ),

    // drawerTheme: const DrawerThemeData(
    //   
    // )

  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(

    // color primario
    // primaryColor: Colors.indigo,
    primaryColor: const Color(0xC657DFF7),

    // AppBar themen
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0
    ),

    scaffoldBackgroundColor: Colors.black

  );

}