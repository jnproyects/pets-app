import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:pets_app/config/theme/app_theme.dart';
import 'package:pets_app/presentation/cubits/cubits.dart';
import 'package:pets_app/presentation/widgets/widgets.dart';


class HomeScreen extends StatefulWidget {

  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    loadPets();
  }

  void loadPets() async {
    await context.read<PetsCubit>().loadPets();
  }


  @override
  Widget build(BuildContext context) {

    final pets = context.watch<PetsCubit>().state.pets;
    // final pets = context.watch<RegisterCubit>().state.pets;

    // final homeScaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      // key: homeScaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: const Text('My Pets'),
      ),

      // drawer: SideMenu( homeScaffoldKey: homeScaffoldKey ),

      body: ( pets.isEmpty )
        ? const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Icon(
                Icons.folder_outlined,
                size: 60,
                color: AppTheme.primary,
              ),

              Text(
                'Aún no tienes mascotas agregadas',
                style: TextStyle(
                  fontSize: 15,
                  color: AppTheme.primary
                ),
              ),

            ],
          ),
        )
      
        : ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: pets.length,
          itemBuilder: ( _, index) {

            final pet = pets[index];

            return GestureDetector(
              onTap: () {
                context.push(
                  '/pet-details/${ pet.id }'
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomCard(
                  imageUrl: ( pet.images.isNotEmpty ) ? pet.images.first : 'assets/no-image.png',
                  name: pet.name,
                ),
              ),
            );

          },
        ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push('/add-pet');
        },
        label: const Text('Add Pet'),
        icon: const Icon( Icons.add ),
        backgroundColor: AppTheme.primary,
      ),
      
    );

  }

  // @override
  // bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
  }
}