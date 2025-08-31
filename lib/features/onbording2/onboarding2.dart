import 'package:flutter/material.dart';
import 'package:tabourak/features/onbording2/widgets/picture2.dart';
import 'package:tabourak/features/onbording2/widgets/textandbuttom2.dart';

class onboarding2 extends StatelessWidget {
  const onboarding2({super.key});

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
                const picture2(),
                const textandbuttom2(),
              ],
            ),
          ),
        ),
    
    );
  }
}