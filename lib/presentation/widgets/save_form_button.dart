import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pets_app/config/config.dart';
import 'package:pets_app/domain/domain.dart';
import 'package:pets_app/presentation/cubits/cubits.dart';
import 'package:pets_app/shared/services/services.dart';

class SaveFormButton extends StatelessWidget {
  final bool isEditForm;
  final Pet? pet;

  const SaveFormButton({
    super.key,
    this.isEditForm = false,
    this.pet,
  });

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<RegisterCubit>();

    final bool isPosting =
        (registerCubit.state.formStatus == FormzSubmissionStatus.posting);
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
              label: Text(
                (isPosting) ? 'Saving...' : 'Save',
                style: const TextStyle(fontSize: 16),
              ),
              icon: (isPosting)
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    )
                  : const Icon(Icons.save),
              style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all(Size(size.width * 0.8, 50)),
                iconSize: MaterialStateProperty.all(30),
              ),
              onPressed: (isPosting)
                  ? null
                  : () async {
                      (isEditForm)
                          ? editPet(context: context, pet: pet!)
                          : registerPet(context: context);
                    }),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

Future<void> registerPet({required BuildContext context}) async {
  final registerCubit = context.read<RegisterCubit>();
  final petsCubit = context.read<PetsCubit>();

  final pet = await registerCubit.onSubmit();

  if ( registerCubit.state.formStatus == FormzSubmissionStatus.posting ) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const FullScreenLoader(),
    ));
  }

  if (pet != null) {
    final bool result = await petsCubit.savePet(pet);

    if (result) {
      NotificationsService.showCustomSnackbar(
          context: context, mensaje: '${pet.name} successfully registered!');

      // context.pushReplacement('/');
      context.pop();
      
    } else {
      NotificationsService.showCustomSnackbar(
          context: context, mensaje: 'Error registering your pet', error: true);
    }

    Navigator.pop(context);
  }
}

Future<void> editPet({required BuildContext context, required Pet pet}) async {
  final registerCubit = context.read<RegisterCubit>();
  final petsCubit = context.read<PetsCubit>();

  final Pet? petResp = await registerCubit.onSubmit(pet: pet);

  if ( registerCubit.state.formStatus == FormzSubmissionStatus.posting ) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const FullScreenLoader(),
    ));
  }

  if (petResp != null) {
    final result = await petsCubit.editPet(petResp);

    if (result) {
      NotificationsService.showCustomSnackbar(
          context: context, mensaje: 'Changes saved successfully!');

      registerCubit.isEditingToggle();

      context.pushReplacement('/pet-details/${petResp.id}');
    } else {
      NotificationsService.showCustomSnackbar(
          context: context, mensaje: 'Error editing information', error: true);
    }

    Navigator.pop(context);

  }
}

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 4,
              color: AppTheme.primary,
            ),
            SizedBox(height: 15),
            Text(
              'Wait...',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
