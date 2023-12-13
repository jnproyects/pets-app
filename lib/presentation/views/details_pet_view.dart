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
    fontSize: 20,
    color: Colors.black
  );
  

  @override
  Widget build(BuildContext context) {

    context.watch<PetsCubit>();
    final registerCubit = context.watch<RegisterCubit>();

    return Padding(
      padding: const EdgeInsets.only( top: 50 ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
              colorPrimario: const Color.fromARGB(255, 146, 68, 255),
              // colorSecundario: Colors.gre,
            ),
      
            const SizedBox(
              height: 15,
            ),
      
            Text(
              'Race: ${ pet.race }', 
              style: textStyle,
            ),
      
            const SizedBox(
              height: 10,
            ),
      
            Text(
              'Sex: ${ pet.sex }', 
              style: textStyle
            ),
      
            const SizedBox(
              height: 10,
            ),
      
            Text(
              'Specie: ${ pet.specie }', 
              style: textStyle
            ),
      
            const SizedBox(
              height: 10,
            ),
      
            Text(
              'Size: ${ pet.size }', 
              style: textStyle
            ),
      
            const SizedBox(
              height: 10,
            ),

            if ( pet.age != "null" )
              Container(
                margin: const EdgeInsets.only( bottom: 10 ),
                child: Text(
                  registerCubit.calculatePetAge( DateTime.parse( pet.age ) ),
                  style: textStyle
                ),
              ),

            Text(
              'Vaccines: ${ ( pet.vaccines! ) ? 'Yes' : 'No' }', 
              style: textStyle
            ),
      
            const SizedBox(
              height: 150,
            ),
      
          ],
        ),
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
            subTitle: 'The information will be permanently deleted.',
            okButtonText: 'Delete'
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

