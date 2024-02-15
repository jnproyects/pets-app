import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_app/config/config.dart';

import 'package:pets_app/domain/entities/pet.dart';
import 'package:pets_app/presentation/cubits/cubits.dart';
import 'package:pets_app/presentation/views/views.dart';
import 'package:pets_app/presentation/widgets/widgets.dart';

class PetDetailsEditScreen extends StatefulWidget {
  static const String routeName = 'pet_details_screen';

  final int petId;

  const PetDetailsEditScreen({super.key, required this.petId});

  @override
  State<PetDetailsEditScreen> createState() => _PetDetailsEditScreenState();
}

class _PetDetailsEditScreenState extends State<PetDetailsEditScreen> {
  late Pet pet;

  @override
  void initState() {
    super.initState();
    pet = context.read<PetsCubit>().loadPetDetails(widget.petId);
  }

  @override
  Widget build(BuildContext context) {

    pet = context.read<PetsCubit>().loadPetDetails(widget.petId);

    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: ( _ ) => RegisterCubit(),
      child: Scaffold(
      
        body: PetDetailsEdit(
          size: size, 
          pet: pet
        ),
      ),
    );
  }
}

class PetDetailsEdit extends StatelessWidget {

  const PetDetailsEdit({
    super.key,
    required this.size,
    required this.pet,
  });

  final Size size;
  final Pet pet;

  @override
  Widget build(BuildContext context) {

    final registerCubit = context.watch<RegisterCubit>();

    return SafeArea(
      child: Stack(
        children: [
          if (!registerCubit.state.isEdit)
            Positioned(
                height: size.height,
                width: size.width,
                child: const BackgroundWavesLeft()),
          if (registerCubit.state.isEdit)
            Positioned(
                height: 445,
                width: size.width,
                child: const HeaderWaveBottom(color: AppTheme.primary)),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: (!registerCubit.state.isEdit)
                ? DetailsPetView(pet: pet)
                : EditPetView(pet: pet),
          ),
        ],
      ),
    );
  }
}
