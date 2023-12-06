import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pets_app/presentation/cubits/cubits.dart';
import 'package:pets_app/config/config.dart';

void main() async {

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ( _ ) => PetsCubit(),
        ),
        // BlocProvider(
        //   create: ( _ ) => RegisterCubit()
        // )
      ],
      child: const MyApp()
    )
  );

} 

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      routerConfig: appRouter,
      theme: AppTheme.ligthTheme,
      // theme: AppTheme.darkTheme,
    );
  }
}