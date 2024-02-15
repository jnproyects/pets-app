import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pets_app/presentation/cubits/cubits.dart';
import 'package:pets_app/config/config.dart';
import 'package:intl/date_symbol_data_local.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ( _ ) => PetsCubit(),
        ),
      ],
      child: const MyApp()
    )
  );

} 

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    
    initializeDateFormatting();
  
    return MaterialApp.router(
      
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      routerConfig: appRouter,
      theme: AppTheme.ligthTheme,
    );
  }
}