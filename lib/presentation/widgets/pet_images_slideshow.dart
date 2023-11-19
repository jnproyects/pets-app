import 'dart:io';

import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';


class PetImagesSlideShow extends StatelessWidget {
  
  final List<String?> petImages;

  const PetImagesSlideShow( {super.key, required this.petImages } );

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Swiper( 
        viewportFraction: 0.9,
        scale: 0.9,
        autoplay: false,
        pagination: SwiperPagination(
          margin: const EdgeInsets.only( top: 0 ),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: colors.secondary
          )
        ),
        itemCount: petImages.length,
        itemBuilder: (context, index) {
          final petImage = petImages[index];
          return _Slide( petImage: petImage! );
        },
      ),
    );
  }


}


class _Slide extends StatelessWidget {

  final String petImage;

  const _Slide({ required this.petImage });

  @override
  Widget build(BuildContext context) {

    ImageProvider imageProvider;

    if( petImage.startsWith('/data/') ){
      imageProvider = FileImage( File( petImage ) );
    } else {
      imageProvider = AssetImage( petImage );
    }
    
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular( 20 ),
      boxShadow: const [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 10,
          offset: Offset(0, 10)
        )
      ]
    );
    
    return Padding(
      padding: const EdgeInsets.only( bottom: 30 ),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular( 20 ),
          // child: Image.network(
          //   petImage,
          //   fit: BoxFit.cover,
          child: FadeInImage(
            image: imageProvider,
            fit: BoxFit.cover,
            placeholder: const AssetImage('assets/footprint-loading.gif'),
            // loadingBuilder: (context, child, loadingProgress) {

            //   if ( loadingProgress != null ) {
            //     return const DecoratedBox(
            //       decoration: BoxDecoration(
            //         color: Colors.black12
            //       )
            //     );
            //   }

            //   return GestureDetector(
            //     onTap: () => context.push('/home/0/movie/${ movie.id }'),
            //     child: FadeIn(
            //       child: child
            //     )
            //   );

            // },
          )
          
        ),
      ),
    );
  }



}