import 'package:formz/formz.dart';

// Define input validation errors
enum SizeError { empty }

// Extend FormzInput and provide the input type and error type.
class Size extends FormzInput<String, SizeError> {

  // Call super.pure to represent an unmodified form input.
  const Size.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Size.dirty( String value ) : super.dirty(value);

  // Error messages
  String? get errorMessage {
    
    if ( isValid || isPure ) return null;
    if ( displayError == SizeError.empty ) return 'El campo es requerido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  SizeError? validator( String value ) {

    if ( value.isEmpty || value.trim().isEmpty ) return SizeError.empty;
    return null;
    
  }
}