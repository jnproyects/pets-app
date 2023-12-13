part of 'register_cubit.dart';

// enum FormzSubmissionStatus { initial, validating, valid, posting, success, failure }
enum FormzSubmissionStatus { initial, validating, valid, posting }

class RegisterFormState extends Equatable {

  final FormzSubmissionStatus formStatus;
  final bool isValid;
  final Name name;
  final Race race;
  // final Age age;
  final DateTime? age;
  final Sex sex;
  final Specie specie;
  final Size size;
  final bool? vaccines;
  final List<String> images;

  final double currentPage;
  final int initialPage;

  const RegisterFormState({
    this.formStatus = FormzSubmissionStatus.initial, 
    this.isValid = false,
    this.name = const Name.pure(),
    this.race = const Race.pure(),
    // this.age = const Age.pure(),
    this.age,
    this.sex = const Sex.pure(),
    this.specie = const Specie.pure(),
    this.size = const Size.pure(),
    this.vaccines,
    this.images = const[],
    this.currentPage = 0,
    this.initialPage = 0,
  });

  RegisterFormState copyWith({
    FormzSubmissionStatus? formStatus,
    bool? isValid,
    Name? name,
    Race? race,
    // Age? age,
    DateTime? age,
    Sex? sex,
    Specie? specie,
    Size? size,
    bool? vaccines,
    List<String>? images,
    double? currentPage,
    int? initialPage,
  }) {
    return RegisterFormState(
      formStatus: formStatus ?? this.formStatus,
      isValid: isValid ?? this.isValid,
      name: name ?? this.name,
      race: race ?? this.race,
      age: age ?? this.age,
      sex: sex ?? this.sex,
      specie: specie ?? this.specie,
      size: size ?? this.size,
      vaccines: vaccines ?? this.vaccines,
      images: images ?? this.images,
      currentPage: currentPage ?? this.currentPage,
      initialPage: initialPage ?? this.initialPage
    );
  }

  @override
  List<Object?> get props => [ formStatus, isValid, name, race, age, sex, specie, size, vaccines, images, currentPage, initialPage ];
}

