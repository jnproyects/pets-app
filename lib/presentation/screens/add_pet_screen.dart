import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:pets_app/presentation/cubits/cubits.dart';
import 'package:pets_app/presentation/widgets/widgets.dart';
import 'package:pets_app/shared/services/services.dart';

class AddPetScreen extends StatelessWidget {

  static const String routeName = 'add_pet_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: const _AddPetForm(),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => context.go('/'),
      //   child: const Icon(
      //     FontAwesomeIcons.xmark
      //   )
      // ),
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
    // final age = registerCubit.state.age;
    final vaccines = registerCubit.state.vaccines;
    final petImages = registerCubit.state.images;

    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [

            Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Text(
                'Agregar Mascota',
                style: TextStyle(fontSize: 30),
              ),
            ),

            const SizedBox( height: 30 ),

            SizedBox(
              height: 250,
              width: 600,
              child: _ImageGallery( images: petImages ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () async {
                            
                             // el usuario puede seleccionar múltiples foto a la vez
                            List<String>? photosPath = await CameraGalleryServiceImpl().selectMultiplePhotos();
                            if ( photosPath == null ) return;
                            registerCubit.imagesChanged( [ ...photosPath ] );

                            // el usuario puede seleccionar 1 foto a la vez
                            // final String? photoPath = await CameraGalleryServiceImpl().selectPhoto();
                            // if ( photoPath == null ) return;
                            // registerCubit.imagesChanged( [ photoPath ] );
                    
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
                            registerCubit.imagesChanged( [ photoPath ] );
                          }, 
                          icon: const Icon( Icons.camera_alt_outlined ),
                          iconSize: 30,
                        ),
                      ]
                    ),

                    const SizedBox( height: 30 ),

                    CustomTextFormField(
                      label: 'Nombre',
                      onChanged: ( value ) => registerCubit.nameChanged( value ),
                      errorMessage: name.errorMessage,
                    ),

                    const SizedBox(height: 15),

                    CustomTextFormField(
                      label: 'Raza',
                      onChanged: ( value ) => registerCubit.raceChanged( value ),
                      errorMessage: race.errorMessage,
                    ),

                    const SizedBox(height: 15),

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
                          // initialSelection: 'grande',
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
                          // initialSelection: 'perro',
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
                          // initialSelection: 'macho',
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
    return Padding(
      padding: const EdgeInsets.only( bottom: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
    
          ElevatedButton.icon(
            label: const Text('Cancelar'),
            onPressed: () => context.go('/'), 
            icon: const Icon( Icons.cancel )
          ),
    
          const SizedBox( width: 10 ),
    
          ElevatedButton.icon(
            style: ButtonStyle(
              // padding: MaterialStateProperty.all(
              //   EdgeInsets.symmetric(
              //     horizontal: size.width * 0.15, 
              //     vertical: 15
              //   )
              // ),
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              foregroundColor:
                  MaterialStateProperty.all(Colors.white),
            ),
            label: const Text('Guardar'),
            icon: const Icon( Icons.save ),
            onPressed: () async {
              
              //TODO: mostrar alerta segun resultado de registro
              // final pet = await registerCubit.onSubmit();
              final pet = await context.read<RegisterCubit>().onSubmit();
    
              // el form es válido y retorna una mascota
              if ( pet != null  ) {
    
                //registramos la mascota en Isar DB
                final bool result = await context.read<PetsCubit>().savePet( pet );
                
                // si el registro fue correcto
                if ( result ) {
    
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Tu mascota fue registrada!'),
                      backgroundColor: Colors.green,
                    ),
    
                  );
                  
                  context.go('/');
                } 
                // error en el registro
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error al registrar mascota'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
    
    
              } 
              //si no, el formulario no es valido
              else{
                
                print(' formulario incorrecto ');
    
    
              }
              
    
            },
          ),
    
          const SizedBox( height: 30 ),
    
        ],
      ),
    );
  }
}

















class _ImageGallery extends StatelessWidget {

  final List<String> images;

  const _ImageGallery({required this.images});

  @override
  Widget build(BuildContext context) {

    if ( images.isEmpty ) {
      return Padding(
        padding: const EdgeInsets.symmetric( horizontal: 16 ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all( Radius.circular(20) ),
          child: Image.asset(
            'assets/no-image.png', 
            fit: BoxFit.cover
          )
        ),
      );
    }

    return PageView(
      scrollDirection: Axis.horizontal,
      controller: PageController(
        viewportFraction: 0.9
      ),
      children: images.map((imagePath) {
        
        late ImageProvider imageProvider;

        if ( imagePath.startsWith('http') ) {
          imageProvider = NetworkImage( imagePath );
        } else {
          imageProvider = FileImage( File( imagePath ) );
        }

        return Padding(
          padding: const EdgeInsets.symmetric( horizontal: 10 ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: FadeInImage(
              fit: BoxFit.cover,
              placeholder: const AssetImage('assets/footprint-loading.gif'), 
              image: imageProvider
            ),
          ),
        );

      }).toList(),
    );
  }
}












