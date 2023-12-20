
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pets_app/config/config.dart';

class NotificationsService {

  // Dialogs - Alerts
  static showCustomDialog({
    required BuildContext context, 
    required String title, 
    required String subTitle, 
    required String okButtonText
  }) {

    if ( Platform.isAndroid ){

      return showDialog(

        context: context, 
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          // shape: RoundedRectangleBorder( borderRadius: BorderRadiusDirectional.circular(10) ),
          title: Text( title ),
          content: Text( subTitle ),
          actions: [

            FilledButton(
              onPressed: () => Navigator.pop(context),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all( AppTheme.primary ),
              ),
              child: const Text('Cancel'),
              
            ),

            TextButton(
              onPressed: () => Navigator.pop(context, 'ok'),
              child: Text(
                okButtonText, 
                style: const TextStyle( color: Colors.red ),
              )
            )

          ],
        ),
      );

    }

    showCupertinoDialog(
      barrierDismissible: false,
      context: context, 
      builder: ( context ) {
        return CupertinoAlertDialog(
          title: Text( title ),
          content: Text( subTitle ),
          actions: [

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle( color: Colors.red ),)
            ),

            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: Text(okButtonText, style: const TextStyle( color: Colors.red ))
            )
          ],

        );
      }
    );

  }

  // Snackbars
  static void showCustomSnackbar({ required BuildContext context, required String mensaje, bool error = false }) {

    // ScaffoldMessenger.of(context).clearSnackBars();

    final snackbar = SnackBar(
      backgroundColor: (error) ? Colors.red.withOpacity(0.9) : Color(0xff09B394) ,
      content: Text(
        mensaje,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15 
        )
      ),
      // action: SnackBarAction(
      //   label: 'Ok!', 
      //   onPressed: (){}
      // ),
      duration: const Duration( seconds: 2 ),
      
    );
    
    ScaffoldMessenger.of(context).showSnackBar( snackbar );
  
  }


  // loading Indicator
  static void showCustomLoadingIndicator( BuildContext context ) {
    
    const AlertDialog dialog = AlertDialog(
      
      content: SizedBox(
        width: 100,
        height: 100,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )
    );

    showDialog(
      context: context, 
      builder: (context) => dialog,
    );

  }

  // About Dialog
  static void showCustomAboutDialog( BuildContext context ) {

    showAboutDialog(
      context: context,
      children: [
        const Text('Est reprehenderit sunt ut excepteur qui consectetur. Consequat quis duis pariatur incididunt et et. Minim et nulla est sunt exercitation consequat sint exercitation dolor nostrud. Aliqua duis labore est ullamco deserunt do nostrud dolore cillum. Ut do sit consectetur duis proident ut sit. Occaecat aliquip minim consectetur mollit. Sint cillum irure velit enim.')
      ]
    );

  }














  




}