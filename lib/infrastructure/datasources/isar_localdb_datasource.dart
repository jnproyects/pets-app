
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pets_app/domain/datasources/local_storage_datasource.dart';
import 'package:pets_app/domain/entities/pet.dart';

class IsarLocalDbDataSource extends LocalStorageDataSource {

  late Future<Isar> db;

  IsarLocalDbDataSource() {
    db = openDb();
  }
  
  Future<Isar> openDb() async {

    final dir = await getApplicationDocumentsDirectory();

    if ( Isar.instanceNames.isEmpty ){
      return await Isar.open(
        [ PetSchema ], 
        directory: dir.path,
        inspector: true
      );
    }
    return Future.value( Isar.getInstance() );


  }


  @override
  Future<List<Pet>> loadPets() async {
    
    final isar = await db;
    final allPets = await isar.pets.where().findAll();
    return allPets;

  }

  @override
  Future<Pet> savePet( Pet pet ) async {

    final isar = await db;
    
    await isar.writeTxnSync( () async { 
      await isar.pets.putSync(pet); 
    });

    return pet;

  }
  
  @override
  Future<void> editPet( Pet pet ) async {
    
    final isar = await db;

    await isar.writeTxn(() async {

      final petToUpdate = await isar.pets.get( pet.id! );
      
      if ( petToUpdate != null ) {
        await isar.pets.put( pet );
      } else {
        throw 'Pet with ID ${pet.id!} not found.';
      }

    });

  }
  
  @override
  Future<void> deletePet(int petId) async {
    
    final isar = await db;

    await isar.writeTxn(() async {

      await isar.pets.delete( petId );

    });


  }

}