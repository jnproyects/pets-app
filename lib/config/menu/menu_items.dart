import 'package:flutter/material.dart' show IconData, Icons;

class MenuItem {

  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItem({
    required this.title, 
    required this.subTitle, 
    required this.link, 
    required this.icon
  });

}

const List<MenuItem> appMenuItems = [

  MenuItem(
    title: 'My Pets', 
    subTitle: 'Lista de mis mascotas', 
    link: '/', 
    icon: Icons.not_started_sharp
  ),

  MenuItem(
    title: 'Add Pet', 
    subTitle: 'Agregar una mascota', 
    link: '/add-pet', 
    icon: Icons.add
  ),

  MenuItem(
    title: 'Option 3', 
    subTitle: 'Opción 3', 
    link: '/option-3', 
    icon: Icons.credit_card
  ),

  MenuItem(
    title: 'Change Theme',
    subTitle: 'Cambiar tema de la app', 
    link: '/theme-changer',
    icon: Icons.color_lens_outlined
  ),

];