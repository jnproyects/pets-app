import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:pets_app/domain/domain.dart';
import 'package:pets_app/infrastructure/infrastructure.dart';

part 'pets_state.dart';

class PetsCubit extends Cubit<PetsState> {
  final LocalStorageRepository localStorageRepository =
      LocalStorageRepositoryImpl(dataSource: IsarLocalDbDataSource());

  PetsCubit() : super(const PetsState());

  Future<bool> savePet(Pet newPet) async {

    await Future<void>.delayed(const Duration(seconds: 2));

    newPet.id = state.pets.length + 1;

    final Pet pet = await localStorageRepository.savePet(newPet);

    emit(state.copyWith(pets: [...state.pets, pet]));

    return true;
  }

  Future<bool> editPet(Pet petUpdated) async {

    await Future<void>.delayed(const Duration(seconds: 2));

    await localStorageRepository.editPet(petUpdated);

    emit(state.copyWith(
        pets: state.pets
            .map((pet) => (pet.id == petUpdated.id) ? petUpdated : pet)
            .toList()));

    return true;
  }

  Future<List<Pet>> loadPets() async {

    await Future<void>.delayed(const Duration(seconds: 2));

    final List<Pet> pets = await localStorageRepository.loadPets();

    emit(state.copyWith(pets: [...pets]));

    return pets;
  }

  Pet loadPetDetails(int id) {
    final Pet pet = state.copyWith().pets.singleWhere((pet) => pet.id == id);

    return pet;
  }

  // void isEditingToggle() {

  //   emit(
  //     state.copyWith(
  //       isEdit: !state.isEdit
  //     )
  //   );
  // }

  Future<void> deletePet(int petId) async {

    await Future<void>.delayed(const Duration(seconds: 2));

    await localStorageRepository.deletePet(petId);

    emit(state.copyWith(
        pets: state.pets.where((Pet pet) => pet.id != petId).toList()));
  }
}
