import 'package:go_router/go_router.dart';

import 'package:pets_app/presentation/screens/screens.dart';
import 'package:pets_app/domain/entities/pet.dart';

// GoRouter configuration
final appRouter = GoRouter(
  
  initialLocation: '/',
  
  routes: [
    
    GoRoute(
      path: '/',
      name: HomeScreen.routeName,
      builder: (context, state) => HomeScreen(),
    ),

    GoRoute(
      path: '/add-pet',
      name: AddPetScreen.routeName,
      builder: (context, state) => AddPetScreen(),
    ),

    GoRoute(
      path: '/pet-details/:id',
      name: PetDetailsScreen.routeName,
      builder: (context, state) {
        
        // final Pet pet = state.extra as Pet;
        // return PetDetailsScreen( pet: pet );
        final petId = state.pathParameters['id'] ?? 'no-id';
        return PetDetailsScreen( petId: int.parse(petId) );

      } 
    ),
    

  ],

);