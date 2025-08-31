import 'package:flutter/material.dart';
import 'package:tabourak/core/routing/routes.dart';
import 'package:tabourak/features/home/ui/widgets/picture2.dart';
import 'package:tabourak/features/home/ui/widgets/textandbuttom2.dart';

class BookNow extends StatelessWidget {
  const BookNow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const PictureBook(),
              const TextAndButton4(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.handshake_outlined), label: 'Service'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none_outlined), label: 'Notify'),
          BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined), label: 'Profile'),
        ],
        currentIndex: 1, 
        selectedItemColor: const Color(0xFF1A4C7F),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
         switch (index) {
              case 0:
                Navigator.pushNamed(context, Routes.homeScreen); 
                break;
              case 1:
                Navigator.pushNamed(context, Routes.filterScreen);
                break;
              case 2:
                Navigator.pushNamed(context, Routes.notifications); 
                break;
              case 3:
                Navigator.pushNamed(context, Routes.profile); 
                break;
            } 
        },
      ),
    );
  }
}