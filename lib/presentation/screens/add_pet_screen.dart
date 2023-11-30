
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:pets_app/presentation/cubits/cubits.dart';
import 'package:pets_app/presentation/widgets/custom_drodown_menu.dart';
import 'package:pets_app/presentation/widgets/widgets.dart';
import 'package:pets_app/shared/services/services.dart';

class AddPetScreen extends StatelessWidget {

  static const String routeName = 'add_pet_screen';

  const AddPetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: const Stack(
          children: [

            HeaderWave(),
            // HeaderWaveBottom(color: AppTheme.primary),

            _AddPetForm(),
          ],
        ),
      ),
    );
  }
}

class _AddPetForm extends StatelessWidget {
  const _AddPetForm({super.key});

  @override
  Widget build(BuildContext context) {

    final registerCubit = context.watch<RegisterCubit>();
    final name = registerCubit.state.name;
    final race = registerCubit.state.race;
    final specie = registerCubit.state.specie;
    final sex = registerCubit.state.sex;
    final petSize = registerCubit.state.size;
    final vaccines = registerCubit.state.vaccines;
    final petImages = registerCubit.state.images;

    final size = MediaQuery.of(context).size;

    // final firstDate = DateTime(DateTime.now().year - 120);
    // final lastDate = DateTime.now();

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          
          children: [

            Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.only( left: 10 ),
              margin: const EdgeInsets.only( top: 10),
              child: BackButton(
                style: ButtonStyle(
                  iconSize: MaterialStateProperty.all( 30 ),
                  iconColor: MaterialStateProperty.all( Colors.white )
                ),
                onPressed: () => context.go('/'),
              ),
            ),
        
            const SizedBox(
              height: 25,
            ),

            Text(
              ( name.value.isEmpty ) ? 'New Pet' : name.value,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),

            const SizedBox( height: 30 ),

            SizedBox(
              height: 350,
              width: 600,
              // height: 175,
              // width: 300,
              child: ImageGallery(
                images: petImages
                // images: ( petImages.isEmpty ) ? [ ...pet.images ] : [ ...petImages ],
              ),
            ),

            if ( petImages.isNotEmpty && !petImages.contains("assets/no-photo.png") ) 
              Dots(
                cantImages: petImages.length,
                bulletPrimario: 10,
                bulletSecundario: 8,
              ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
            
                    const SizedBox(height: 15),
            
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                      
                          IconButton(
                            
                            onPressed: () async {
                              
                               // el usuario puede seleccionar múltiples foto a la vez
                              // List<String>? photosPath = await CameraGalleryServiceImpl().selectMultiplePhotos();
                              // if ( photosPath == null ) return;
                              // registerCubit.imagesChanged( [ ...photosPath ] );
                                  
                              // el usuario puede seleccionar 1 foto a la vez
                              final String? photoPath = await CameraGalleryServiceImpl().selectPhoto();
                              if ( photoPath == null ) return;
                              registerCubit.imagesChanged( [ photoPath ] );
                      
                            }, 
                            icon: const Icon( Icons.photo_library_outlined ),
                            iconSize: 30,
                            color: Colors.black,
                          ),

                          const Text(
                            'Add Photos',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 17
                            ),
                          ),
                      
                          IconButton(
                            onPressed: () async {
                              final String? photoPath = await CameraGalleryServiceImpl().takePhoto();
                              if ( photoPath == null ) return;
                              registerCubit.imagesChanged( [ photoPath ] );
                            }, 
                            icon: const Icon( Icons.camera_alt_outlined ),
                            iconSize: 30,
                            color: Colors.black,
                          ),
                        ]
                      ),
                    ),

                    const SizedBox( height: 30 ),

                    CustomDropdownMenu(
                      width: size.width * 0.9,
                      label: const Text('Specie'),
                      dropdownMenuEntries: const [
                          DropdownMenuEntry(
                            value: 'Dog', 
                            label: 'Dog'
                          ),
                          DropdownMenuEntry(
                            value: 'Cat', 
                            label: 'Cat'
                          )
                        ],
                      onSelected: ( value ) => registerCubit.specieChanged( value! ),
                      errorText: specie.errorMessage,
                    ),
            
                    const SizedBox(height: 15),
            
                    CustomTextFormField(
                      label: 'Name',
                      onChanged: ( value ) => registerCubit.nameChanged( value ),
                      errorMessage: name.errorMessage,
                    ),
            
                    const SizedBox(height: 15),
            
                    CustomTextFormField(
                      label: 'Race',
                      onChanged: ( value ) => registerCubit.raceChanged( value ),
                      errorMessage: race.errorMessage,
                    ),
            
                    const SizedBox(height: 15),
            
                    // Container(
                    //   decoration: const BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.only( topRight: Radius.circular(10), bottomLeft: Radius.circular(10), ),
                        
                    //   ),
                    //   child: InputDatePickerFormField(
                    //     // initialDate: DateTime.now(),
                    //     firstDate: firstDate, 
                    //     lastDate: lastDate,
                    //     acceptEmptyDate: true,
                    //     fieldLabelText: 'Birthdate',
                    //     onDateSubmitted: ( date ) {
                    //       print(date);
                    //     },
                    //     onDateSaved: ( date ) {
                    //       print(date);
                    //     },
                        
                        
                    //   ),
                    // ),
            
                    // const SizedBox(height: 15),
            
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
            
                        CustomDropdownMenu(
                          label: const Text('Size'),
                          dropdownMenuEntries: const [
                            DropdownMenuEntry(
                              value: 'Large', 
                              label: 'Large'
                            ),
                            DropdownMenuEntry(
                              value: 'Medium', 
                              label: 'Medium'
                            ),
                            DropdownMenuEntry(
                              value: 'Small', 
                              label: 'Small'
                            ),
                          ],
                          onSelected: ( value ) => registerCubit.sizeChanged( value! ),
                          errorText: petSize.errorMessage,
                          
                        ),
            
                        CustomDropdownMenu(
                          label: const Text('Sex'),
                          dropdownMenuEntries: const [
                            DropdownMenuEntry(
                              value: 'Male', 
                              label: 'Male'
                            ),
                            DropdownMenuEntry(
                              value: 'Female', 
                              label: 'Female'
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
                        'Vaccines up to date?',
                        style: TextStyle(fontSize: 16),
                      ),
                      value: vaccines ?? false,
                      onChanged: ( value ) => registerCubit.vaccinesChanged( value ),
                      
                    ),
            
                    const SizedBox(height: 15),
                    
                    const _ButtonsForm(),

                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );

  }
}

class _ButtonsForm extends StatelessWidget {
  const _ButtonsForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only( bottom: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
    
          ElevatedButton.icon(
            label: const Text(
              'Save',
              style: TextStyle(
                fontSize: 16
              ),
            ),
            icon: const Icon( Icons.save ),
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all( Size( size.width * 0.8, 50) ),
              // backgroundColor: MaterialStateProperty.all( Colors.deepPurple[400] ),
              backgroundColor: MaterialStateProperty.all( Colors.deepPurple[400] ),
              iconSize: MaterialStateProperty.all( 30 ),
            ),
            onPressed: () async {
              
              final pet = await context.read<RegisterCubit>().onSubmit();
    
              if ( pet != null  ) {
    
                final bool result = await context.read<PetsCubit>().savePet( pet );
                
                if ( result ) {
    
                  NotificationsService.showCustomSnackbar(
                    context: context, 
                    mensaje: 'Tu mascota fue registrada!'
                  );
                  
                  context.go('/');
                } 
                else {
                  NotificationsService.showCustomSnackbar(
                    context: context, 
                    mensaje: 'Error al registrar tu mascota',
                    error: true
                  );
                }
    
              }
    
            },
          ),
    
          const SizedBox( height: 30 ),
    
        ],
      ),
    );
  }
}