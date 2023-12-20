import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:pets_app/presentation/screens/screens.dart';

// GoRouter configuration
final appRouter = GoRouter(
  
  initialLocation: '/',
  
  routes: [
    
    GoRoute(
      path: '/',
      name: HomeScreen.routeName,
      builder: (context, state) => HomeScreen(),
      // pageBuilder: (context, state) => customTransitionPage( state, HomeScreen() ),
    ),

    GoRoute(
      path: '/add-pet',
      name: AddPetScreen.routeName,
      builder: (context, state) => const AddPetScreen(),
      // pageBuilder: (context, state) => customTransitionPage( state, const AddPetScreen() ),
    ),

    GoRoute(
      path: '/pet-details/:id',
      name: PetDetailsEditScreen.routeName,
      pageBuilder: (context, state) => customTransitionPage(
        state,
        PetDetailsEditScreen( petId: int.parse( state.pathParameters['id'] ?? 'no-id' ) )
      ),

    ),

  ],

);

CustomTransitionPage<void> customTransitionPage(GoRouterState state, Widget child) {

  return CustomTransitionPage<void>(
      child: child,
      transitionDuration: const Duration( milliseconds: 300 ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        
        final curvedAnimation = CurvedAnimation(
          parent: animation, 
          curve: Curves.easeInOut
        );

        return FadeTransition(
          opacity: Tween<double>(
            begin: 0.0,
            end: 1.0
          ).animate( curvedAnimation ),
          child: child,
        );

      }
    );
}