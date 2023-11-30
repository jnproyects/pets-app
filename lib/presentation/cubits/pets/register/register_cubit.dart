import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import 'package:pets_app/domain/domain.dart';
import 'package:pets_app/infrastructure/infrastructure.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  
  RegisterCubit() : super( const RegisterFormState() );

  PageController _pageController = PageController( keepPage: false );


  // void _pageControllerStream() {

  //   _pageController.addListener(() {

  //     changeCurrentPage( _pageController.page! );

  //   });

  // }

  PageController get pageContoller => _pageController;

  void nameChanged( String value ) {
    
    final name = Name.dirty( value );

    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate([ name, state.race, state.age, state.sex, state.specie, state.size ])
      )
    );
  }

  void raceChanged( String value ) {
    
    final race = Race.dirty( value );

    emit(
      state.copyWith(
        race: race,
        isValid: Formz.validate([ state.name, race, state.age, state.sex, state.specie, state.size ])
      )
    );
  }

  void ageChanged( String value ) {

    final age = Age.dirty( value );

    emit(
      state.copyWith(
        age: age,
        isValid: Formz.validate([ state.name, state.race, age, state.sex, state.specie, state.size ])
      ),
    );
  }

  void sexChanged( String value ) {
    
    final sex = Sex.dirty( value );

    emit(
      state.copyWith(
        sex: sex,
        isValid: Formz.validate([ state.name, state.race, state.age, sex, state.specie, state.size ])
      )
    );
  }

  void specieChanged( String value ) {

    final specie = Specie.dirty( value );

    emit(
      state.copyWith(
        specie: specie,
        isValid: Formz.validate([ state.name, state.race, state.age, state.sex, specie, state.size ])
      )
    );
  }

  void sizeChanged( String value ) {
    
    final size = Size.dirty( value );

    emit(
      state.copyWith(
        size: size,
        isValid: Formz.validate([ state.name, state.race, state.age, state.sex, state.specie, size ])
      )
    );
  }

  void vaccinesChanged( bool? value ) {
    emit(
      state.copyWith(
        vaccines: value,
      )
    );
  }

  void imagesChanged( List<String> newImages ) {

    // if ( state.initialPage > 0 ){
    //   _pageController.jumpToPage( state.initialPage );
    // }

    
    if ( state.images.isNotEmpty ){
      _pageController.jumpToPage( state.images.length );
    }

    emit(
      state.copyWith(
        images: [ ...state.images.where( ( image ) => ( image != 'assets/no-photo.png' ) ).toList(), ...newImages ],
        currentPage: state.images.length.toDouble(),
        // initialPage: state.images.length + 1
      )
    );

  }

  void deletePetImage( { required List<String> images, required String imagePath } ) {

    String noPhoto = 'assets/no-photo.png';

    if ( images.length == 1 ) {
      images.add(noPhoto);
    }

    emit(
      state.copyWith(
        images: images.where( ( image ) => ( image != imagePath ) ).toList(),
        currentPage: !images.contains(noPhoto) && images.indexOf(imagePath) > 0
          ? images.length - 2
          : 0
      )
    );

    // se esta borrando desde el último elemento
    if ( images.indexOf(imagePath) == images.length - 1 ){
      _pageController.jumpToPage( state.images.length );
    } else if ( images.indexOf(imagePath) > 0 && images.indexOf(imagePath) != images.length - 1 ) {
      
      _pageController.jumpToPage( 0 );

    }





  }

  void changeCurrentPage( double newCurrentPage ) {

    emit(
      state.copyWith(
        currentPage: newCurrentPage,
        // initialPage: newCurrentPage.round()
      )
    );
  }


  Future<Pet?> onSubmit({ Pet? pet }) async {


    // si existe id es una edición
    if ( pet?.id != null ) {

      if ( state.name.value == '' && state.name.errorMessage == null ) {
        nameChanged( pet!.name );
      }

      if ( state.race.value == '' && state.race.errorMessage == null ) {
        raceChanged( pet!.race );
      }

      if ( state.sex.value == '' && state.sex.errorMessage == null ) {
        sexChanged( pet!.sex );
      }

      // if ( state.age.value == '' && state.name.errorMessage == null ) {
      //   ageChanged( pet!.age );
      // }

      if ( state.specie.value == '' && state.specie.errorMessage == null ) {
        specieChanged( pet!.specie );
      }

      if ( state.size.value == '' && state.size.errorMessage == null ) {
        sizeChanged( pet!.size );
      }

      if ( state.vaccines == null ) {
        vaccinesChanged( pet!.vaccines );
      }
      
      //  state.images.where((image) => image != 'assets/no-photo.png' ).toList();
      
      if ( state.images.isEmpty ) imagesChanged( pet!.images );

    }

    if ( state.vaccines == null ) vaccinesChanged( false );
    

    
    emit(
      state.copyWith(
        formStatus: FormzSubmissionStatus.validating,
        name: Name.dirty( state.name.value ),
        race: Race.dirty( state.race.value ),
        // age: Age.dirty( state.age.value ),
        sex: Sex.dirty( state.sex.value ),
        specie: Specie.dirty( state.specie.value ),
        size: Size.dirty( state.size.value ),
        // isValid: Formz.validate([ state.name, state.race, state.age, state.sex, state.specie, state.size ])
        isValid: Formz.validate([ state.name, state.race, state.sex, state.specie, state.size ])
      )
    );


    if ( !state.isValid ) return null;

    // si llega acá significa que el form es válido
    emit(
      state.copyWith(
        formStatus: FormzSubmissionStatus.valid
      )
    );

    await Future<void>.delayed(const Duration(seconds: 1));

    emit(
      state.copyWith(
        formStatus: FormzSubmissionStatus.posting
      )
    );

    return Pet(
      id: pet?.id,
      name: state.name.value, 
      race: state.race.value,
      age: state.age.value,
      sex: state.sex.value,
      specie: state.specie.value,
      size: state.size.value,
      vaccines: state.vaccines,
      // images: state.images,
      images: state.images.where((image) => image != 'assets/no-photo.png' ).toList()
    );

  }

}
