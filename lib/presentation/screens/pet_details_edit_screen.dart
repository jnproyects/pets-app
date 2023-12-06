import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pets_app/config/config.dart';

import 'package:pets_app/domain/entities/pet.dart';
import 'package:pets_app/presentation/cubits/cubits.dart';
import 'package:pets_app/presentation/views/views.dart';
import 'package:pets_app/presentation/widgets/widgets.dart';


class PetDetailsEditScreen extends StatefulWidget {

  static const String routeName = 'pet_details_screen';

  final int petId;

  const PetDetailsEditScreen({ super.key, required this.petId });

  @override
  State<PetDetailsEditScreen> createState() => _PetDetailsEditScreenState();
}

class _PetDetailsEditScreenState extends State<PetDetailsEditScreen> {


  late Pet pet;

  @override
  void initState() {
    super.initState();
    pet = context.read<PetsCubit>().loadPetDetails( widget.petId );
  }

  @override
  Widget build(BuildContext context) {

    final petsCubit = context.watch<PetsCubit>();

    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create:  ( _ ) => RegisterCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              
              if( !petsCubit.state.isEdit )
                Positioned(
                  height: size.height,
                  width: size.width,
                  child: const BackgroundWavesLeft()
                ),

              if ( petsCubit.state.isEdit )             
                Positioned( 
                  height: 445,
                  width: size.width,
                  child: const HeaderWaveBottom(
                    color: AppTheme.primary
                  )
                ),

              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ( !petsCubit.state.isEdit )
                  ? DetailsPetView( pet: pet )
                  : EditPetView( pet: pet ),
              
              ),
            ],
          ),
        ),
    
        floatingActionButton: ( !petsCubit.state.isEdit ) ? FloatingActionButton(
          backgroundColor: const Color(0xFF615AAB),
          onPressed: () => context.go('/'),
          elevation: 0,
          child: const Icon(
            Icons.close,
            color: Colors.white,
            size: 25,
          )
        ) : null,
    
       ),
    );
  }
}