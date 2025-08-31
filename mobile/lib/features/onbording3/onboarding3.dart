import 'package:flutter/material.dart';
import 'package:tabourak/features/onbording3/widgets/picture3.dart';
import 'package:tabourak/features/onbording3/widgets/textandbuttom3.dart';

class onboarding3 extends StatelessWidget {
  const onboarding3({super.key});

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
                const picture3(),
                const textandbuttom3(),
              ],
            ),
          ),
        ),
    
    );
  }
}