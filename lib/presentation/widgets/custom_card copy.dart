import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pets_app/config/theme/app_theme.dart';


class CustomCard extends StatelessWidget {

  final String imageUrl;
  final String? name;

  const CustomCard({
    super.key, 
    required this.imageUrl,
    this.name,
  });


  @override
  Widget build(BuildContext context) {

    late ImageProvider imageProvider;

    if ( imageUrl.startsWith('/data/') ) {
      imageProvider = FileImage( File(imageUrl) );
    } else {
      imageProvider = AssetImage( imageUrl );
    }
      

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      elevation: 0,
      shadowColor: AppTheme.primary.withOpacity(0.5),
      child: Column(

        children: [

          FadeInImage(
            image: imageProvider,
            placeholder: const AssetImage('assets/footprint-loading.gif'),
            width: double.infinity,
            height: 350,
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 300),
          ),

          if ( name != null )
            Container(
              alignment: AlignmentDirectional.topCenter,
              padding: const EdgeInsets.only( right: 20, top: 10, bottom: 10 ),
              child: Text(
                name!,
                style: const TextStyle(
                  fontSize: 17,
                ),
              )
          ),

        ],

      )
    );
  }
  
}