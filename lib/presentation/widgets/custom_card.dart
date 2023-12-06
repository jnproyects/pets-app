import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pets_app/config/theme/app_theme.dart';
import 'package:pets_app/presentation/widgets/image_gallery.dart';


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

    final size = MediaQuery.of(context).size;

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
      child: SizedBox(
        width: double.infinity,
        child: Stack(
        
          children: [
        
            FadeInImage(
              image: imageProvider,
              placeholder: const AssetImage('assets/footprint-loading.gif'),
              width: double.infinity,
              height: 350,
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 300),
            ),
        
            const CustomGradient(
              colors: [
                Colors.transparent,
                Colors.black54
              ],
              stops: [
                0.8, 
                1.0
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            ),

            if( name != null )
              Positioned(
                width: size.width * 0.90,
                bottom: 15,
                left: 15,
                child: SizedBox(
                  child: Text( 
                    name!, 
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25
                    ),
                  ),
                )
              ),
        
          ],
        
        ),
      )
    );
  }
  
}