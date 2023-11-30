import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pets_app/presentation/cubits/cubits.dart';

class ImageGallery extends StatelessWidget {

  final List<String> images;
  final bool isEdit;

  const ImageGallery({
    super.key, 
    required this.images, 
    this.isEdit = false,
  });

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

    return _Slides( images: images, isEdit: isEdit, );

  }
}

class _Slides extends StatelessWidget {

  final List<String> images;
  final bool isEdit;
  
  const _Slides({
    super.key,
    required this.images, 
    required this.isEdit, 
  });

  @override
  Widget build(BuildContext context) {

    final pageController = context.read<RegisterCubit>().pageContoller; 

    pageController.addListener(() {

      context.read<RegisterCubit>().changeCurrentPage( pageController.page! );

    });

    return PageView(
      scrollDirection: Axis.horizontal,
      controller: pageController,
      
      children: images.map((imagePath) {
        
        late ImageProvider imageProvider;
    
        if ( imagePath.startsWith('http') ) {
          imageProvider = NetworkImage( imagePath );
        } else if ( imagePath.startsWith('/data/') ) {
          imageProvider = FileImage( File( imagePath ) );
        } else {
          imageProvider = AssetImage( imagePath );
        }

        // si es registro o edición
        if ( isEdit ) {
    
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
      
                const CustomImageGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black26
                  ],
                  stops:  [
                    0.8, 
                    1.0
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight
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
                ),
      
            ],
          );

        }

        // si pasa aca quiere decir que es el screen de detalle
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
        
            const CustomImageGradient(
              colors: [
                Colors.transparent,
                Colors.black26
              ],
              stops:  [
                0.8, 
                1.0
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
            ),
        
            Positioned(
              bottom: 5,
              right: 10,
              child: IconButton(
                splashColor: Colors.transparent,
                onPressed: (){},
                icon: const Icon(
                  Icons.zoom_in,
                  color: Colors.white70, 
                  size: 35
                )
              ),
            )
          ],
        );
    
      }).toList(),
    );
  }
}

class CustomImageGradient extends StatelessWidget {

  final List<Color> colors;
  final List<double>? stops;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  const CustomImageGradient({
    super.key, 
    required this.colors, 
    this.stops,
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Padding(
        padding: const EdgeInsets.symmetric( horizontal: 10 ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
                stops: stops,
                begin: begin,
                end: end
              )
            ),
          ),
        ),
      ),
    );
  }
}



class Dots extends StatelessWidget {

  final int cantImages;
  final bool dotsUp;
  final Color colorPrimario;
  final Color colorSecundario;
  final double bulletPrimario;
  final double bulletSecundario;

  const Dots({
    super.key, 
    required this.cantImages, 
    this.dotsUp = false, 
    this.colorPrimario = Colors.blue, 
    this.colorSecundario = Colors.grey, 
    this.bulletPrimario = 10, 
    this.bulletSecundario = 8
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: List.generate(
          cantImages, (index) => _Dot(
            index: index,
            dotsUp: dotsUp,
            colorPrimario: colorPrimario,
            colorSecundario: colorSecundario,
            bulletPrimario: bulletPrimario,
            bulletSecundario: bulletSecundario,
          )
        ),

      ),
    );
  }
}

class _Dot extends StatelessWidget {

  final int index;

  final bool dotsUp;
  final Color colorPrimario;
  final Color colorSecundario;
  final double bulletPrimario;
  final double bulletSecundario;

  const _Dot({
    super.key, 
    required this.index, 
    required this.dotsUp, 
    required this.colorPrimario, 
    required this.colorSecundario, 
    required this.bulletPrimario, 
    required this.bulletSecundario, 
  });

  @override
  Widget build(BuildContext context) {

    final currentPage = context.read<RegisterCubit>().state.currentPage;
    double tamano;
    Color color;

    if ( currentPage >= (index - 0.5) && currentPage < index + 0.5 ) {
      tamano = bulletPrimario;
      color = colorPrimario;
    } else {
      tamano = bulletSecundario;
      color = colorSecundario;
    }

    return AnimatedContainer(
      duration: const Duration( milliseconds: 200 ),
      width: tamano,
      height: tamano,
      margin: const EdgeInsets.symmetric( horizontal: 5 ),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle
      ),
    );
  }
}