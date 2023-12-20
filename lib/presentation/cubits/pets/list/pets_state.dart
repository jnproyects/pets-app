part of 'pets_cubit.dart';

class PetsState extends Equatable {

  final List<Pet> pets;
  final bool isEdit;
  
  const PetsState({
    this.pets = const[],
    this.isEdit = false,
  });
 
  PetsState copyWith({
    List<Pet>? pets,
    bool? isEdit,
  }) => PetsState(
    pets: pets ?? this.pets,
    isEdit: isEdit ?? this.isEdit,
  );

  @override
  List<Object> get props => [ pets, isEdit ];

}
