import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:pets_app/config/menu/menu_items.dart';
import 'package:pets_app/config/theme/app_theme.dart';


class SideMenu extends StatefulWidget {

  final GlobalKey<ScaffoldState> homeScaffoldKey;

  const SideMenu({
    super.key, 
    required this.homeScaffoldKey
  });

  @override
  State<SideMenu> createState() => _SideMenuState();

}

class _SideMenuState extends State<SideMenu> {

  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {

    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;

    return NavigationDrawer(
      indicatorColor: AppTheme.primary,
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        
        setState(() {
          navDrawerIndex = value;
        });

        final menuItem = appMenuItems[value];
        context.push( menuItem.link );
        widget.homeScaffoldKey.currentState?.openDrawer();

      },
      children: [

        Padding(
          padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 20, 16, 10),
          child: const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: CircleAvatar(
              backgroundColor: AppTheme.primary,
              child: Icon(
                Icons.ac_unit_sharp,
                size: 60,
              ),
            )
          ),
        ),

        ...appMenuItems
        .sublist(0,3)
        .map( 
          (item) => NavigationDrawerDestination(
            icon: Icon( item.icon ), 
            label: Text( item.title )
          ), 
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text('More options'),
        ),

        ...appMenuItems
        .sublist(3)
        .map( 
          (item) => NavigationDrawerDestination(
            icon: Icon( item.icon ), 
            label: Text( item.title )
          ), 
        ),

      ],
    );
  }

}