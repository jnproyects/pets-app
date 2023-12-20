import 'package:formz/formz.dart';

// Define input validation errors
enum SpecieError { empty }

// Extend FormzInput and provide the input type and error type.
class Specie extends FormzInput<String, SpecieError> {

  // Call super.pure to represent an unmodified form input.
  const Specie.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Specie.dirty( String value ) : super.dirty(value);

  // Error messages
  String? get errorMessage {
    
    if ( isValid || isPure ) return null;
    if ( displayError == SpecieError.empty ) return 'Specie is Required';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  SpecieError? validator( String value ) {

    if ( value.isEmpty || value.trim().isEmpty ) return SpecieError.empty;

    return null;
    
  }
}