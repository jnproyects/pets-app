import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:pets_app/domain/entities/pet.dart';
import 'package:pets_app/presentation/cubits/cubits.dart';
import 'package:pets_app/presentation/widgets/widgets.dart';
import 'package:pets_app/shared/services/services.dart';

enum PetDetailsOptions { edit, delete }

class DetailsPetView extends StatelessWidget {
  
  final Pet pet;

  const DetailsPetView({
    super.key,
    required this.pet,
  });
  
  final textStyle =  const TextStyle(
    fontSize: 18,
    color: Colors.black
  );
  

  @override
  Widget build(BuildContext context) {

    context.watch<PetsCubit>();
    final registerCubit = context.watch<RegisterCubit>();

    return Padding(
      padding: const EdgeInsets.only( top: 50 ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only( left:  15 ),
                  width: 220,
                  child: Text(
                    pet.name.toUpperCase(), 
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    
                  ),
                ),
              ),
            
              PopupMenuButton(
                iconColor: Colors.white,
                iconSize: 35,
                padding: const EdgeInsets.only( right: 15),
                itemBuilder: ( context ) => _petDetailsMenuItems(context)
              ),
                 
            
            ],
          ),
            
          const SizedBox(
            height: 15,
          ),
            
          SizedBox(
            height: 300,
            child: ImageGallery( images: pet.images )
          ),
            
          Dots(
            cantImages: pet.images.length,
            bulletPrimario: 10,
            bulletSecundario: 8,
          ),
            
          const SizedBox(
            height: 15,
          ),
            
          Padding(
            padding: const EdgeInsets.symmetric( horizontal: 20 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    RichText(
                      text: TextSpan(
                        text: 'Specie: ',
                        style: textStyle,
                        children: [
                          TextSpan(
                            text: pet.specie, 
                            style: textStyle.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ]
                      )
                    ),
                      
                    const SizedBox(
                      height: 10,
                    ),
                      
                    Text(
                      'Sex: ${ pet.sex }', 
                      style: textStyle
                    ),
                  ],
                ),
            
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    

                    RichText(
                      text: TextSpan(
                        text: 'Race: ',
                        style: textStyle,
                        children: [
                          TextSpan(
                            text: pet.race, 
                            style: textStyle.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ]
                      )
                    ),
                      
                    const SizedBox(
                      height: 10,
                    ),
                      
                    Text(
                      'Size: ${ pet.size }', 
                      style: textStyle
                    ),
                  ],
                )
              ],
            ),
          ),
          

          // const SizedBox(
          //   height: 10,
          // ),
      
      
          if ( pet.age != "null" )
            Container(
              margin: const EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
              child: Text(
                'Age: ${registerCubit.calculatePetAge( DateTime.parse( pet.age ) )}',
                style: textStyle
              ),
            ),
      
          Padding(
            padding: const EdgeInsets.symmetric( horizontal: 20 ),
            child: Text(
              'Vaccines: ${ ( pet.vaccines! ) ? 'Yes' : 'No' }', 
              style: textStyle
            ),
          ),
      
          const SizedBox(
            height: 10,
          ),
      
          if( pet.observations != null && pet.observations != '' )
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 20, vertical: 5 ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Text(
                    'Observations:', 
                    style: textStyle.copyWith(
                      fontWeight: FontWeight.bold
                    )
                  ),
                    
                  Container(
                    margin: EdgeInsets.symmetric( vertical: 5 ),
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.transparent
                    ),
                    child: Text(
                      '${pet.observations}',
                      style: textStyle
                    ),
                  )
                ],
              ),
            ),
            
          // const SizedBox(
          //   height: 150,
          // ),
            
        ],
      ),
    );
  }
  
  List<PopupMenuEntry<PetDetailsOptions>> _petDetailsMenuItems(BuildContext context) {
    
    return <PopupMenuEntry<PetDetailsOptions>>[
                
      PopupMenuItem<PetDetailsOptions>(
        onTap: () {
          context.read<PetsCubit>().isEditingToggle();
          // context.read<RegisterCubit>().disposePageController;
        },
        value: PetDetailsOptions.edit,
        child: const Text('Edit'),
      ),

      PopupMenuItem<PetDetailsOptions>(
        onTap: () async {

          final resp = await NotificationsService.showCustomDialog(
            context: context, 
            title: 'Are you sure?', 
            subTitle: 'The information will be permanently deleted!',
            okButtonText: 'Yes, Delete',
          );

          if ( resp == 'ok' ) {
            await context.read<PetsCubit>().deletePet( pet.id! );              
            // await petsCubit.deletePet( pet.id! );   

            context.go('/');

            NotificationsService.showCustomSnackbar(
              context: context, 
              mensaje: 'Pet information removed'
            );
          }
        },
        value: PetDetailsOptions.delete,
        child: const Text('Delete'),
        

      ),
    ];
  }

}

