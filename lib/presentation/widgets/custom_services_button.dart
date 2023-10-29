import 'package:flutter/material.dart';

class CustomServicesButton extends StatelessWidget {
  const CustomServicesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xff71A8B6),
        borderRadius: BorderRadius.circular(8)
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.castle_rounded,
            color: Colors.black,
            size: 50,
          ),
          Text(
            'Daycare',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600
            ),
          )
        ],
      ),
    );
  }
}