
import 'package:pets_app/domain/datasources/local_storage_datasource.dart';
import 'package:pets_app/domain/entities/pet.dart';
import 'package:pets_app/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {

  final LocalStorageDataSource dataSource;

  LocalStorageRepositoryImpl({ required this.dataSource });

  @override
  Future<List<Pet>> loadPets() {
    return dataSource.loadPets();
  }

  @override
  Future<Pet> savePet(Pet pet) {
    return dataSource.savePet( pet );
  }
  
  @override
  Future<void> editPet(Pet pet) {
    return dataSource.editPet( pet );
  }
  
  @override
  Future<void> deletePet(int petId) {
    return dataSource.deletePet( petId );
  }


}