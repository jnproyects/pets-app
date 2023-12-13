import 'package:age_calculator/age_calculator.dart';
import 'package:bloc/bloc.dart';
import 'package:dart_date/dart_date.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import 'package:pets_app/domain/domain.dart';
import 'package:pets_app/infrastructure/infrastructure.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  
  RegisterCubit() : super( const RegisterFormState() );

  late PageController _pageController;
  
  PageController get pageContoller => _pageController;

  PageController createInstancePageController() {

    emit(
      state.copyWith(
        currentPage: 0
      )
    );

    _pageController = PageController( keepPage: false );
    return _pageController;
  }

  // disposePageController() {
  //   _pageController.dispose();
  // }

  String calculatePetAge( DateTime? ageValue ) {

    final birthdatePet = ageValue;

    String valor = "";

    if ( birthdatePet != null ) {
      
      DateDuration duration = AgeCalculator.age(birthdatePet);
      final List<String> formatedDuration = duration.toString().split(','); //[Years: 1,  Months: 1,  Days: 0]

      final String years = ( formatedDuration[0].contains('0') )
        ? ''
        : "${formatedDuration[0].replaceFirst('Years: ', '')} year(s) ";
      
      final String months = ( formatedDuration[1].contains('0') ) 
        ? '' 
        : "${formatedDuration[1].replaceFirst('Months: ', '')} month(s)";

      final String days = ( formatedDuration[2].contains('0') ) 
        ? '' 
        : "${formatedDuration[2].replaceFirst('Days: ', '')} day(s)";

      
      valor = "Age: $years $months  $days".replaceAll('  ', '');
    
    }

    return valor;
  }

  void nameChanged( String value ) {
    
    final name = Name.dirty( value );

    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate([ name, state.race, state.sex, state.specie, state.size ])
      )
    );
  }

  void raceChanged( String value ) {
    
    final race = Race.dirty( value );

    emit(
      state.copyWith(
        race: race,
        isValid: Formz.validate([ state.name, race, state.sex, state.specie, state.size ])
      )
    );
  }

  void ageChanged( DateTime value ) {

    emit(
      state.copyWith(
        age: value
      ),
    );

  }

  void sexChanged( String value ) {
    
    final sex = Sex.dirty( value );

    emit(
      state.copyWith(
        sex: sex,
        isValid: Formz.validate([ state.name, state.race, sex, state.specie, state.size ])
      )
    );
  }

  void specieChanged( String value ) {

    final specie = Specie.dirty( value );

    emit(
      state.copyWith(
        specie: specie,
        isValid: Formz.validate([ state.name, state.race, state.sex, specie, state.size ])
      )
    );
  }

  void sizeChanged( String value ) {
    
    final size = Size.dirty( value );

    emit(
      state.copyWith(
        size: size,
        isValid: Formz.validate([ state.name, state.race, state.sex, state.specie, size ])
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

      if ( state.age == null ) {
        ageChanged( DateTime.parse( pet!.age ));
      }

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
        // age: state.age,
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
      age: state.age.toString(),
      sex: state.sex.value,
      specie: state.specie.value,
      size: state.size.value,
      vaccines: state.vaccines,
      images: state.images.where( (image) => image != 'assets/no-photo.png' ).toList()
    );

  }

}
