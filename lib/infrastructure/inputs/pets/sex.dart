import 'package:formz/formz.dart';

// Define input validation errors
enum SexError { empty }

// Extend FormzInput and provide the input type and error type.
class Sex extends FormzInput<String, SexError> {

  // Call super.pure to represent an unmodified form input.
  const Sex.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Sex.dirty( String value ) : super.dirty(value);

  // Error messages
  String? get errorMessage {
    
    if ( isValid || isPure ) return null;
    if ( displayError == SexError.empty ) return 'Sex is Required';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  SexError? validator( String value ) {

    if ( value.isEmpty || value.trim().isEmpty ) return SexError.empty;
    return null;
    
  }
}