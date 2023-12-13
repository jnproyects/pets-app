import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:pets_app/config/theme/app_theme.dart';
import 'package:pets_app/domain/entities/pet.dart';
import 'package:pets_app/presentation/cubits/cubits.dart';
import 'package:pets_app/presentation/widgets/widgets.dart';


class HomeScreen extends StatefulWidget {

  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPets();
  }

  loadPets() async {
    isLoading = true;

    await context.read<PetsCubit>().loadPets();
    isLoading = false;
  }


  @override
  Widget build(BuildContext context) {

    final pets = context.watch<PetsCubit>().state.pets;

    // puede ser otra forma de realizar la validación
    // Visibility(child: child)

    if ( isLoading ) {
      return const Scaffold(
        body:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              CircularProgressIndicator( strokeWidth: 3 ),

              SizedBox( height: 15 ),

              Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 15
                ),
              ),

            ],
          ),
        ),
      );
    }

    return Scaffold(

      body: ( pets.isEmpty ) 
      ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const Icon(
                Icons.web_asset_off_outlined,
                size: 60,
                color: Colors.black26,
              ),

              const Text(
                'You do not have any pets added yet!!',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w300
                ),
              ),

              Container(
                width: 200,
                margin: const EdgeInsets.only( top: 30 ),
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all( AppTheme.primary )
                  ),
                  onPressed: () => context.push('/add-pet'),
                  child: const Text(
                    'Add Now',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )
                ),
              )

            ],
          ),
        )
      : Stack(
          children: [

            const BackgroundWaves(),

            _MainPetsList( pets: pets ),

            Positioned(
              bottom: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only( topLeft: Radius.circular(50) ),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  color: AppTheme.primary,
                  child: IconButton(
                    onPressed: () => context.push('/add-pet'),
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    )
                  )
                ),
              )
            ),

          ],
        ),
    );
      

  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _MainPetsList extends StatelessWidget {

  final List<Pet> pets;

  const _MainPetsList({
    required this.pets
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // physics: const BouncingScrollPhysics(),
      slivers: [

        SliverPersistentHeader(
          floating: true,
          delegate: _SliverCustomHeaderDelegate(
            minHeight: 100,
            maxHeight: 200,
            child: Container(
              margin: const EdgeInsets.only( left: 16, top: 25 ),
              alignment: Alignment.centerLeft,
              child: SlideInLeft(
                from: 100,
                child: const Text(
                  'My Pets',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 45
                  )
                ),
              )
            )
          )
        ),

        SliverList.builder(
          itemCount: pets.length,
          itemBuilder: ( _, index) {
        
            final pet = pets[index];
        
            return FadeInDown(

              child: GestureDetector(
                onTap: () {
                  context.push(
                    '/pet-details/${ pet.id }',
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomCard(
                    imageUrl: ( pet.images.isNotEmpty ) ? pet.images.first : 'assets/no-photo.png',
                    name: pet.name,
                  ),
                ),
              ),
            );
        
          },
        ),


      ],
  
    );
  }
}

class _SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {

  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverCustomHeaderDelegate({
    required this.minHeight, 
    required this.maxHeight, 
    required this.child
  });


  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild( covariant _SliverCustomHeaderDelegate oldDelegate ) {
    return maxHeight != oldDelegate.maxHeight || 
           minHeight != oldDelegate.minHeight ||
           child != oldDelegate.child;
  }

}
























