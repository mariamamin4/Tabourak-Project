import 'package:flutter/material.dart';
import 'package:tabourak/features/bookconfirm/widgets/picture7.dart';
import 'package:tabourak/features/bookconfirm/widgets/textandbuttom7.dart';

class Bookconfirm extends StatelessWidget {
  const Bookconfirm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Pictureconfirm(),
              const TextAndButton7(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.handshake), label: 'Service'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notify'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 1,
        selectedItemColor: const Color(0xFF2366A9),
        unselectedItemColor: Colors.grey,
        onTap: (index) {},
      ),
    );
  }
}