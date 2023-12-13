import 'package:isar/isar.dart';

part 'pet.g.dart';

@collection
class Pet {

  Id? id;

  final String name;
  final String race;
  final String age;
  final String sex;
  final String specie;
  final String size;
  final bool? vaccines;
  final List<String> images;

  Pet({
    this.id,
    required this.name, 
    required this.race, 
    required this.age, 
    required this.sex, 
    required this.specie, 
    required this.size, 
    required this.vaccines, 
    required this.images
  });

  


}