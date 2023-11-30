
import 'package:flutter/material.dart';
import 'package:pets_app/config/config.dart';

class CustomDropdownMenu extends StatelessWidget {

  final double? width;
  final List<DropdownMenuEntry<String>> dropdownMenuEntries;
  final void Function(String?)? onSelected;
  final String? errorText;
  final Widget? label;

  const CustomDropdownMenu({
    super.key, this.width, 
    required this.dropdownMenuEntries, 
    this.onSelected, 
    this.errorText,
    this.label
  });

  @override
  Widget build(BuildContext context) {

    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40)
    );

    const borderRadius = Radius.circular(15);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(topLeft: borderRadius, bottomLeft: borderRadius, bottomRight: borderRadius ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0,5)
          )
        ]
      ),
      child: DropdownMenuTheme(
        data: DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
            filled: true, 
            fillColor: Colors.white,
            enabledBorder: border,
            focusedBorder: border,
            errorBorder: border.copyWith( borderSide: const BorderSide( color: Colors.transparent )),
            focusedErrorBorder: border.copyWith( borderSide: const BorderSide( color: Colors.transparent )),
            isDense: true,
            focusColor: AppTheme.primary,
            floatingLabelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),

          ),
          textStyle: const TextStyle(
            // color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18
          )
        ), 
        child: DropdownMenu(
          width: width,
          label: label,
          dropdownMenuEntries: dropdownMenuEntries,
          onSelected: onSelected,
          errorText: errorText,
          textStyle: const TextStyle( fontSize: 20, color: Colors.black54 ),
          
          
          
        ),
      ),
    );
  }
}