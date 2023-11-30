import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pets_app/presentation/cubits/cubits.dart';

class ImageGallery extends StatelessWidget {

  final List<String> images;

  const ImageGallery({super.key, required this.images});

  @override
  Widget build(BuildContext context) {

    if ( images.isEmpty ) {
      return Padding(
        padding: const EdgeInsets.symmetric( horizontal: 16 ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all( Radius.circular(20) ),
          child: Image.asset(
            'assets/no-photo.png', 
            fit: BoxFit.cover
          )
        ),
      );
    }

    return PageView(
      scrollDirection: Axis.horizontal,
      controller: PageController(
        // viewportFraction: 0.9
      ),
      children: images.map((imagePath) {
        
        late ImageProvider imageProvider;

        if ( imagePath.startsWith('http') ) {
          imageProvider = NetworkImage( imagePath );
        } else if ( imagePath.startsWith('/data/') ) {
          imageProvider = FileImage( File( imagePath ) );
        } else {
          imageProvider = AssetImage( imagePath );
        }

        return Stack(
          fit: StackFit.expand,
          children: [

            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 10 ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: const AssetImage('assets/footprint-loading.gif'), 
                  image: imageProvider
                ),
              ),
            ),

            // gradient y sombra sólo si existen fotos
            if ( imagePath != 'assets/no-photo.png' )

              const Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.symmetric( horizontal: 10 ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black26
                          ],
                          stops: [
                            0.8, 
                            1.0
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight
                        )
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 5,
                // left: 15,
                right: 10,
                // bottom: 10,
                child: IconButton(
                  color: Colors.white,
                  // iconSize: 30,
                  icon: const Icon(
                    Icons.delete,
                    size: 35,
                  ),
                  onPressed: (){
                    context.read<RegisterCubit>().deletePetImage( images: images, imagePath: imagePath );
                  }
                  
                )
              )

          ],
        );

      }).toList(),
    );
  }
}