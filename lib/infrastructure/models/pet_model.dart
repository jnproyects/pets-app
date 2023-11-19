class PetModel {

  final String id;
  final String name;
  final String raza;
  final double edad;
  final List<String> petImages;

  const PetModel({
    required this.id, 
    required this.name, 
    required this.raza, 
    required this.edad,
    required this.petImages
  });

}

const List<PetModel> pets = [
    
    PetModel(
      id: '1', 
      name: 'Liana', 
      raza: 'Fusky', 
      edad: 2, 
      petImages: ['https://cdn.onemars.net/sites/nutro_es_NkyIN_B9cV/image/10_1615903151158.jpeg']
    ),

    PetModel(
      id: '2', 
      name: 'Max', 
      raza: 'Labrador', 
      edad: 1, 
      petImages: ['https://www.nunpet.es/blog/wp-content/uploads/2023/08/5-razas-populares-perros-teckel.webp']
    ),

    PetModel(
      id: '3', 
      name: 'Firulais', 
      raza: 'Criollo', 
      edad: 1.2, 
      petImages: ['https://assets.elanco.com/8e0bf1c2-1ae4-001f-9257-f2be3c683fb1/5b14f1bd-3c0f-4723-93a6-7b2d679c34cb/cachorro-tenia-grama.jpg?w=3840&q=75&auto=format']
    ),

    PetModel(
      id: '4', 
      name: 'Perla', 
      raza: 'Criollo', 
      edad: 0.5, 
      petImages: ['https://img.huffingtonpost.es/files/image_720_480/uploads/2023/06/22/un-perro-de-raza-labrador.jpeg']
    ),
      
    PetModel(
      id: '5', 
      name: 'Lucas', 
      raza: 'Sanbernardo', 
      edad: 0.8, 
      petImages: ['https://www.elespectador.com/resizer/tU27BQVZbSAWqGc7662I9FF1MZo=/910x606/filters:quality(70):format(jpeg)/cloudfront-us-east-1.images.arcpublishing.com/elespectador/UFJTPRN7C5EALL2F4DJFLHDXHU.jpg']
    ),

  ];