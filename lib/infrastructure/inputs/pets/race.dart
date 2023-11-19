import 'package:formz/formz.dart';

// Define input validation errors
enum RaceError { empty, length }

// Extend FormzInput and provide the input type and error type.
class Race extends FormzInput<String, RaceError> {
  // Call super.pure to represent an unmodified form input.
  const Race.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Race.dirty( String value ) : super.dirty(value);

  // Error messages
  String? get errorMessage {
    
    if ( isValid || isPure ) return null;
    if ( displayError == RaceError.empty ) return 'El campo es requerido';
    // if ( displayError == RaceError.length ) return 'Mínimo 3 caracteres';
    if ( displayError == RaceError.length ) return 'Máximo 20 caracteres';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  RaceError? validator( String value ) {

    if ( value.isEmpty || value.trim().isEmpty ) return RaceError.empty;
    if ( value.length > 20 ) return RaceError.length;

    return null;
    
  }
}