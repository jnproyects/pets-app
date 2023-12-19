import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pets_app/config/helpers/helpers.dart';

import 'package:pets_app/domain/domain.dart';
import 'package:pets_app/presentation/cubits/cubits.dart';
import 'package:pets_app/presentation/widgets/widgets.dart';
import 'package:pets_app/shared/services/services.dart';

class EditPetView extends StatelessWidget {

  final Pet pet;

  const EditPetView({
    super.key,
    required this.pet, 
  });

  @override
  Widget build(BuildContext context) {

    final petsCubit = context.watch<PetsCubit>();

    final registerCubit = context.watch<RegisterCubit>();
    final name = registerCubit.state.name;
    final race = registerCubit.state.race;
    final specie = registerCubit.state.specie;
    final sex = registerCubit.state.sex;
    final petSize = registerCubit.state.size;
    final vaccines = registerCubit.state.vaccines;
    final petImages = registerCubit.state.images;
    final age = registerCubit.state.age;

    final size = MediaQuery.of(context).size;

    DateTime? selectedDate; 

    if ( age == null && pet.age != "null" ) {
      selectedDate = DateTime.parse( pet.age );
    } else {
      selectedDate = age;
    }

    Future<void> selectDate(BuildContext context) async {

      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime( 2010 ),
        lastDate: DateTime.now().toLocal(),
      );

      if (picked != null && picked != selectedDate) {
        registerCubit.ageChanged( picked.toLocal() );
      }

    }

    return Center(
      child: Column(
      
        children: [
    
          Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.only( left: 10 ),
            margin: const EdgeInsets.only( top: 5 ),
            child: BackButton(
              style: ButtonStyle(
                iconSize: MaterialStateProperty.all( 30 ),
                iconColor: MaterialStateProperty.all( Colors.black )
              ),
              onPressed: () async {


                final resp = await NotificationsService.showCustomDialog(
                  context: context, 
                  title: 'Are you sure?', 
                  subTitle: 'New changes will be discarded!',
                  okButtonText: 'Discard Changes'
                );

                if ( resp == 'ok' ) {

                  context.push(
                    '/pet-details/${ pet.id }'
                  );

                  petsCubit.isEditingToggle();
                }

              }
            ),
          ),
    
          const SizedBox(
            height: 5,
          ),
              
          const Text(
            'Edit Pet',
            style: TextStyle(fontSize: 30),
          ),
        
          const SizedBox( height: 60 ),
      
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              
              IconButton(
                onPressed: () async {
                  
                  // el usuario puede seleccionar múltiples fotos simultaneamente
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
                iconSize: 40,
                color: Colors.white,
              ),
      
              const Text(
                'Add Photos',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 17
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
                iconSize: 40,
                color: Colors.white,
    
              ),
            ]
          ),
      
          const SizedBox( height: 10 ),
          
          SizedBox(
            height: 250,
            width: 600,
            child: ImageGallery(
              images: ( petImages.isEmpty ) ? [ ...pet.images ] : [ ...petImages ], 
              isEdit: true,
            ),
          ),
      
          if ( (petImages.isNotEmpty || pet.images.isNotEmpty) && !petImages.contains("assets/no-photo.png") ) 
            Dots(
              cantImages: ( petImages.isEmpty ) ? pet.images.length : petImages.length,
              bulletPrimario: 10,
              bulletSecundario: 8,
            ),
        
          const SizedBox( height: 30 ),
        
          Padding(
            padding: const EdgeInsets.symmetric( horizontal: 16 ),
            child: Form(
              child: Column(
                children: [
                  
                  CustomDropdownMenu(
                    width: size.width * 0.9,
                    initialSelection: pet.specie,
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
    
                  const SizedBox( height: 15 ),
            
                  CustomTextFormField(
                    initialValue: pet.name,
                    label: 'Name',
                    onChanged: ( value ) => registerCubit.nameChanged( value ),
                    errorMessage: name.errorMessage,
                  ),
            
                  const SizedBox( height: 15 ),
            
                  CustomTextFormField(
                    initialValue: pet.race,
                    label: 'Race',
                    onChanged: ( value ) => registerCubit.raceChanged( value ),
                    errorMessage: race.errorMessage,
                  ),
          
                  const SizedBox( height: 15 ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only( top: 20, bottom: 20, left: 10, right: 20 ),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15) ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 10,
                                offset: const Offset(0,5)
                              )
                            ]
                          ),
                          child: Text(
                            // ( age == null && pet.age == "null" ) ? "yyyy/mm/dd" : "${ selectedDate!.toLocal() }".split(' ')[0],
                              ( selectedDate == null ) ? "Select Birthdate" : HumanFormats.shortDate( selectedDate ),
                            style: const TextStyle( color: Colors.black45, fontSize: 16, fontWeight: FontWeight.bold ),
                          ),
                        ),
                      ),

                      // const SizedBox( width: 25 ),

                      // ElevatedButton(
                      //   onPressed: () => selectDate(context),
                      //   child: const Text('Change Birthdate'),
                      // ),

                      Container(
                          padding: const EdgeInsets.symmetric( horizontal: 20 ),
                          child: IconButton(
                            onPressed: () => selectDate(context),
                            icon: const Icon(
                              Icons.calendar_month_outlined,
                              size: 40,
                            )
                          ),
                        )

                    ],
                  ),

                  const SizedBox( height: 15 ),
                  
          
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
    
                      CustomDropdownMenu(
                        initialSelection: pet.size,
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
                        initialSelection: pet.sex,
                        width: size.width * 0.425,
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
                    activeColor: Colors.blue,
                    title: const Text(
                      'Vaccines up to date?',
                      style: TextStyle(fontSize: 16),
                    ),
                    value: vaccines ?? pet.vaccines,
                    onChanged: ( value ) => registerCubit.vaccinesChanged( value! ),
                  ),
            
                  const SizedBox(height: 15),

                  CustomTextFormField(
                      label: 'Observations...',
                      initialValue: pet.observations,
                      onChanged: ( value ) => registerCubit.observationsChanged( value.trim() ),
                      maxLines: 5,
                      maxLength: 200,
                    ),
                    
                  const SizedBox(height: 15),
            
                  _ButtonsFormEdit(pet: pet),
            
                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}

class _ButtonsFormEdit extends StatelessWidget {
  const _ButtonsFormEdit({
    required this.pet,
  });

  final Pet pet;

  @override
  Widget build(BuildContext context) {

    final registerCubit = context.watch<RegisterCubit>();
    final petsCubit = context.read<PetsCubit>();

    final bool isPosting = ( registerCubit.state.formStatus == FormzSubmissionStatus.posting );
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only( bottom: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            
          ElevatedButton.icon(
              
            label: Text(
              ( isPosting ) ? 'Saving...' : 'Save',
              style: const TextStyle(
                fontSize: 16
              ),
            ),
            icon: ( isPosting )
              ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ) 
              : const Icon( Icons.save ),
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all( Size( size.width * 0.8, 50) ),
              iconSize: MaterialStateProperty.all( 30 ),
            ),
            onPressed: ( isPosting ) ? null : () async {
        
              final Pet? petResp = await registerCubit.onSubmit( pet: pet );
      
              if ( petResp != null ) {
      
                final result = await petsCubit.editPet( petResp );
      
                if ( result ) {
      
                  NotificationsService.showCustomSnackbar(
                    context: context, 
                    mensaje: 'Changes saved successfully!'
                  );
      
                  petsCubit.isEditingToggle();
                  context.push(
                    '/pet-details/${ petResp.id }'
                  );
      
      
                } else {
      
                  NotificationsService.showCustomSnackbar(
                    context: context, 
                    mensaje: 'Error editing information',
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