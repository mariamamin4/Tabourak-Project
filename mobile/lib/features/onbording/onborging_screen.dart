import 'package:flutter/material.dart';
import 'package:tabourak/features/onbording/widgets/picture.dart';
import 'package:tabourak/features/onbording/widgets/textandbuttom.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: SafeArea(
        child: SingleChildScrollView(
          child: 
             Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const picture1(),
                const textandbuttom(),
              ],
            ),
          ),
        ),
    
    );
  }
}