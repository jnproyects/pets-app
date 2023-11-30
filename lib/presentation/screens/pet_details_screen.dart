import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pets_app/config/config.dart';

import 'package:pets_app/domain/entities/pet.dart';
import 'package:pets_app/presentation/cubits/cubits.dart';
import 'package:pets_app/presentation/widgets/widgets.dart';
import 'package:pets_app/shared/services/services.dart';


class PetDetailsScreen extends StatefulWidget {

  static const String routeName = 'pet_details_screen';

  final int petId;

  const PetDetailsScreen({ super.key, required this.petId });

  @override
  State<PetDetailsScreen> createState() => _PetDetailsScreenState();
}

class _PetDetailsScreenState extends State<PetDetailsScreen> {

  late Pet pet;

  @override
  void initState() {
    super.initState();
    pet = context.read<PetsCubit>().loadPetDetails( widget.petId );
  }

  @override
  Widget build(BuildContext context) {

    final petsCubit = context.watch<PetsCubit>();

    return BlocProvider(
      create:  ( _ ) => RegisterCubit(),
      child: Scaffold(
    
        body: SafeArea(
          child: Stack(
            children: [

              const Positioned(
                bottom: 0,
                // left: 10,
                // right: 10,
                child: HeaderCuadrado()
              ),

              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                
                child: Padding(
                  padding: const EdgeInsets.only( top: 50 ),
                  child: ( !petsCubit.state.isEdit ) 
                    ? _PetDetails( pet: pet )
                    : _EditPetForm( pet: pet ),
                ),
              
              ),
            ],
          ),
        ),
    
        floatingActionButton: ( !petsCubit.state.isEdit ) ? FloatingActionButton(
          backgroundColor: const Color(0xFF615AAB),
          onPressed: () => context.go('/'),
          elevation: 0,
          child: const Icon(
            Icons.close,
            color: Colors.white,
            size: 25,
          )
        ) : null,
    
       ),
    );
  }
}

enum PetDetailsOptions { edit, delete }

class _PetDetails extends StatelessWidget {
  
  final Pet pet;

  const _PetDetails({
    super.key,
    required this.pet,
  });
  
  final textStyle =  const TextStyle(
    fontSize: 20,
    color: Colors.white
  );
  

  @override
  Widget build(BuildContext context) {

    context.watch<PetsCubit>();
    context.watch<RegisterCubit>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          // IconButton(
          //   onPressed: () => context.go('/'),
          //   icon: const Icon(
          //     // Icons.close_outlined,
          //     Icons.arrow_back_ios_new_outlined
          //   ),
          //   color: AppTheme.primary,
          //   iconSize: 40,
          // ),

          // Container(
          //   alignment: Alignment.bottomLeft,
          //   padding: const EdgeInsets.only( left: 10 ),
          //   margin: const EdgeInsets.only( top: 10),
          //   child: BackButton(
          //     style: ButtonStyle(
          //       iconSize: MaterialStateProperty.all( 30 ),
          //       iconColor: MaterialStateProperty.all( Colors.black )
          //     ),
          //     onPressed: () => context.go('/'),
          //   ),
          // ),
          
          
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
                padding: const EdgeInsets.only( right: 15),
                itemBuilder: ( context ) => <PopupMenuEntry<PetDetailsOptions>>[
                  
                  PopupMenuItem<PetDetailsOptions>(
                    onTap: () => context.read<PetsCubit>().isEditingToggle(),
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
                ]
              ),

              // IconButton(
              //   onPressed: () => context.read<PetsCubit>().isEditingToggle(), 
              //   icon: const Icon( Icons.edit, size: 25 ),
              //   // color: Colors.amber,
              // ),

              // IconButton(
              //   color: Colors.red[400],
              //   icon: const Icon(
              //     Icons.delete,
              //     size: 25,
              //   ),
              //   onPressed: () async {
                  
                  
              //     final resp = await NotificationsService.showCustomDialog(
              //       context: context, 
              //       title: 'Are you sure?', 
              //       subTitle: 'The information will be permanently deleted.',
              //       okButtonText: 'Delete'
              //     );

              //     if ( resp == 'ok' ) {
              //       await context.read<PetsCubit>().deletePet( pet.id! );              
              //       // await petsCubit.deletePet( pet.id! );   

              //       context.go('/');

              //       NotificationsService.showCustomSnackbar(
              //         context: context, 
              //         mensaje: 'Pet information removed'
              //       );
              //     }

              //   }
              // ),        

            ],
          ),
    
          const SizedBox(
            height: 15,
          ),

          SizedBox(
            height: 350,
            // width: 600,
            child: ImageGallery( images: pet.images )
          ),

          Dots(
            cantImages: pet.images.length,
            bulletPrimario: 10,
            bulletSecundario: 8,
            colorPrimario: const Color.fromARGB(255, 146, 68, 255),
            colorSecundario: Colors.white,
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
    
          // const SizedBox(
          //   height: 10,
          // ),
    
          // Text(
            // 'Edad: ${ pet.age } meses', 
          //   'Age:', 
          //   style: textStyle
          // ),
    
          const SizedBox(
            height: 10,
          ),
    
          Text(
            'Vaccines: ${ ( pet.vaccines! ) ? 'Sí' : 'No' }', 
            style: textStyle
          ),
    
          const SizedBox(
            height: 90,
          ),
    
          // FilledButton.icon(
          //   onPressed: (){
          //     context.read<PetsCubit>().isEditingToggle();
          //   }, 
          //   icon: const Icon( Icons.edit ), 
          //   label: const Text( 'Edit' ),
          //   style: ButtonStyle(
          //     backgroundColor: MaterialStateProperty.all(Colors.amber[400])
          //   ),
          // ),

          // IconButton(
          //   color: Colors.red[300],
          //   icon: const Icon(
          //     Icons.delete,
          //     size: 35,
          //   ),
          //   onPressed: () async {
              
              
          //     final resp = await NotificationsService.showCustomDialog(
          //       context: context, 
          //       title: 'Are you sure?', 
          //       subTitle: 'The information will be permanently deleted.',
          //       okButtonText: 'Delete'
          //     );

          //     if ( resp == 'ok' ) {
          //       await context.read<PetsCubit>().deletePet( pet.id! );              
          //       // await petsCubit.deletePet( pet.id! );   

          //       context.go('/');

          //       NotificationsService.showCustomSnackbar(
          //         context: context, 
          //         mensaje: 'Pet information removed'
          //       );
          //     }

          //   }
          // ),
    
        ],
      ),
    );
  }

  
}

class _EditPetForm extends StatelessWidget {

  final Pet pet;

  const _EditPetForm({
    super.key,
    required this.pet  
  });

  @override
  Widget build(BuildContext context) {

    context.watch<PetsCubit>();

    final registerCubit = context.watch<RegisterCubit>();
    final name = registerCubit.state.name;
    final race = registerCubit.state.race;
    final specie = registerCubit.state.specie;
    final sex = registerCubit.state.sex;
    final petSize = registerCubit.state.size;
    final vaccines = registerCubit.state.vaccines;
    final petImages = registerCubit.state.images;

    final size = MediaQuery.of(context).size;

    return Column(


      children: [
            
        const Text(
          'Editar Mascota',
          style: TextStyle(fontSize: 30),
        ),
      
        const SizedBox( height: 30 ),
      
        
      
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            
            IconButton(
              onPressed: () async {
                
                // el usuario puede seleccionar múltiples fotos a la vez
                // List<String>? photosPath = await CameraGalleryServiceImpl().selectMultiplePhotos();
                // if ( photosPath == null ) return;

                // ( petImages.isEmpty )
                //   ? registerCubit.imagesChanged( [ ...pet.images, ...photosPath ] )
                //   : registerCubit.imagesChanged( [ ...photosPath ] );

                // el usuario puede seleccionar 1 foto a la vez
                final String? photoPath = await CameraGalleryServiceImpl().selectPhoto();
                if ( photoPath == null ) return;

                ( petImages.isEmpty )
                  ? registerCubit.imagesChanged( [ ...pet.images, photoPath ] )
                  : registerCubit.imagesChanged( [ photoPath ] );
        
              }, 
              icon: const Icon( Icons.photo_library_outlined ),
              iconSize: 30,
            ),

            const Text(
              'Agregar Fotos',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
        
            IconButton(
              onPressed: () async {
                final String? photoPath = await CameraGalleryServiceImpl().takePhoto();
                if ( photoPath == null ) return;

                ( petImages.isEmpty )
                  ? registerCubit.imagesChanged( [ ...pet.images, photoPath ] )
                  : registerCubit.imagesChanged( [ photoPath ] );
              }, 
              icon: const Icon( Icons.camera_alt_outlined ),
              iconSize: 30,
            ),
          ]
        ),

        const SizedBox(height: 10 ),
        
        SizedBox(
          height: 250,
          width: 600,
          child: ImageGallery(
            images: ( petImages.isEmpty ) ? [ ...pet.images ] : [ ...petImages ], 
            isEdit: true
          ),
        ),

        // TODO pendiente
        Dots(
          cantImages: ( petImages.isEmpty ) ? pet.images.length : petImages.length
        ),
      
        const SizedBox(height: 10 ),
      
        Padding(
          padding: const EdgeInsets.symmetric( horizontal: 16 ),
          child: Form(
            child: Column(
              children: [
                
                const SizedBox( height: 30 ),
          
                CustomTextFormField(
                  initialValue: pet.name,
                  label: 'Nombre mascota',
                  onChanged: ( value ) => registerCubit.nameChanged( value ),
                  errorMessage: name.errorMessage,
                ),
          
                const SizedBox( height: 15 ),
          
                CustomTextFormField(
                  initialValue: pet.race,
                  label: 'Raza mascota',
                  onChanged: ( value ) => registerCubit.raceChanged( value ),
                  errorMessage: race.errorMessage,
                ),
        
                const SizedBox( height: 15 ),
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
        
                    // CustomTextFormField(
                    //   label: 'Edad mascota',
                    //   onChanged: ( value ) => registerCubit.ageChanged( value ),
                    //   errorMessage: age.errorMessage,
                    //   keyboardType: TextInputType.number,
                    // ),
        
                    const SizedBox(width: 15),
        
                    DropdownMenu(
                      initialSelection: pet.size,
                      label: const Text('Talla'),
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(
                          value: 'Grande', 
                          label: 'Grande'
                        ),
                        DropdownMenuEntry(
                          value: 'Mediano', 
                          label: 'Mediano'
                        ),
                        DropdownMenuEntry(
                          value: 'Pequeño', 
                          label: 'Pequeño'
                        ),
                      ],
                      onSelected: ( value ) => registerCubit.sizeChanged( value! ),
                      errorText: petSize.errorMessage,
                      
                    ),
        
                  ],
                ),
          
                const SizedBox(height: 15),
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
          
                    DropdownMenu(
                      initialSelection: pet.specie,
                      label: const Text('Especie'),
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(
                          value: 'Perro', 
                          label: 'Perro'
                        ),
                        DropdownMenuEntry(
                          value: 'Gato', 
                          label: 'Gato'
                        )
                      ],
                      onSelected: ( value ) => registerCubit.specieChanged( value! ),
                      errorText: specie.errorMessage,
                      
                    ),
          
                    DropdownMenu(
                      initialSelection: pet.sex,
                      width: size.width * 0.425,
                      label: const Text('Sexo'),
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(
                          value: 'Macho', 
                          label: 'Macho'
                        ),
                        DropdownMenuEntry(
                          value: 'Hembra', 
                          label: 'Hembra'
                        )
                      ],
                      onSelected: ( value ) => registerCubit.sexChanged( value! ),
                      errorText: sex.errorMessage,
                      
                    ),
          
                  ],
                ),
      
                const SizedBox(height: 15),
      
                CheckboxListTile(
                  title: const Text(
                    '¿Vacunas al día?',
                    style: TextStyle(fontSize: 16),
                  ),
                  value: vaccines ?? pet.vaccines,
                  onChanged: ( value ) => registerCubit.vaccinesChanged( value! ),
                ),
          
                const SizedBox(height: 25),
          
                _ButtonsFormEdit(pet: pet),
          
              ],
            )
          ),
        ),
      ],
    );
  }
}

class _ButtonsFormEdit extends StatelessWidget {
  const _ButtonsFormEdit({
    super.key,
    required this.pet,
  });

  final Pet pet;

  @override
  Widget build(BuildContext context) {

    final petsCubit = context.read<PetsCubit>();
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            
          FilledButton.icon(
            onPressed: (){
              // context.read<PetsCubit>().isEditingToggle();
              petsCubit.isEditingToggle();
              context.push(
                '/pet-details/${ pet.id }'
              );
            }, 
            icon: const Icon( Icons.cancel_outlined ), 
            label: const Text( 'Cancel' ),
            style: const ButtonStyle(
              // backgroundColor: MaterialStateProperty.all(Colors.amber[400])
            ),
          ),
            
          const SizedBox( width: 15 ),
            
          FilledButton.icon(
            onPressed: () async {
        
              final Pet? petResp = await context.read<RegisterCubit>().onSubmit( pet: pet );
      
              if ( petResp != null ) {
      
                final result = await petsCubit.editPet( petResp );
      
                if ( result ) {
      
                  NotificationsService.showCustomSnackbar(
                    context: context, 
                    mensaje: 'Cambios realizados!'
                  );
      
                  petsCubit.isEditingToggle();
                  context.push(
                    '/pet-details/${ petResp.id }'
                  );
      
      
                } else {
      
                  NotificationsService.showCustomSnackbar(
                    context: context, 
                    mensaje: 'Error al editar la información',
                    error: true
                  );
                  
                }
                
              } else {
                print( 'Forumulario de edición no válido' );
                
              }
        
              // 
        
        
        
        
            }, 
            icon: const Icon( Icons.save_outlined ), 
            label: const Text( 'Save' ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all( AppTheme.primary )
            )
          ),

          const SizedBox( height: 100 ),

          
            
        ],
      ),
    );
  }
}


























// class _ImageGallery extends StatelessWidget {

//   final List<String> images;
//   final bool isEdit;

//   const _ImageGallery({required this.images, this.isEdit = false });

//   @override
//   Widget build(BuildContext context) {

//     if ( images.isEmpty ) {
//       return Padding(
//         padding: const EdgeInsets.symmetric( horizontal: 16 ),
//         child: ClipRRect(
//           borderRadius: const BorderRadius.all( Radius.circular(20) ),
//           child: Image.asset(
//             'assets/no-photo.png', 
//             fit: BoxFit.cover
//           )
//         ),
//       );
//     }

//     return SizedBox(
//       height: 300,
//       width: double.infinity,
//       child: PageView(
//         scrollDirection: Axis.horizontal,
//         controller: PageController(
//           viewportFraction: 0.85
//         ),
//         children: images.map((imagePath) {
          
//           late ImageProvider imageProvider;
    
//           if ( imagePath.startsWith('http') ) {
//             imageProvider = NetworkImage( imagePath );
//           } else if ( imagePath.startsWith('/data/') ) {
//             imageProvider = FileImage( File( imagePath ) );
//           } else {
//             imageProvider = AssetImage( imagePath );
//           }


//           // si es una edición
//           if ( isEdit ) {

//             return Stack(
//               fit: StackFit.expand,
//               children: [

//                 Padding(
//                   padding: const EdgeInsets.symmetric( horizontal: 10 ),
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                     child: FadeInImage(
//                       fit: BoxFit.cover,
//                       placeholder: const AssetImage('assets/footprint-loading.gif'), 
//                       image: imageProvider
//                     ),
//                   ),
//                 ),

//                 if ( imagePath != 'assets/no-photo.png' )

//                   Positioned(
//                     top: 5,
//                     // left: 15,
//                     right: 10,
//                     // bottom: 10,
//                     child: IconButton(
//                       color: Colors.white,
//                       // iconSize: 30,
//                       icon: const Icon(
//                         Icons.delete,
//                         size: 35,
//                       ),
//                       onPressed: (){
//                         context.read<RegisterCubit>().deletePetImage( images: images, imagePath: imagePath );
//                       }
                      
//                     )
//                   )

                
//               ],
//             );

//           }


//           // si no es edición
//           // if (imagePath == 'assets/no-photo.png') 
//           return Padding(
//             padding: const EdgeInsets.symmetric( horizontal: 10 ),
//             child: ClipRRect(
//               borderRadius: const BorderRadius.all(Radius.circular(10)),
//               child: FadeInImage(
//                 fit: BoxFit.cover,
//                 placeholder: const AssetImage('assets/footprint-loading.gif'), 
//                 image: imageProvider
//               ),
//             ),
//           );

    
//         }).toList(),
//       ),
//     );

//   }
// }