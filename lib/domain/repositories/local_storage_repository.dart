import 'package:pets_app/domain/entities/pet.dart';

abstract class LocalStorageRepository  {

  Future<Pet> savePet( Pet pet );
  
  Future<List<Pet>> loadPets();

  // Future<Pet> loadPetDetails( String id );

  Future<void> editPet( Pet pet );

  Future<void> deletePet( int petId );

}