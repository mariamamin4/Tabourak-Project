import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabourak/core/di/dependency_injection.dart';
import 'package:tabourak/core/helpers/extention.dart';
import 'package:tabourak/core/routing/routes.dart';
import 'package:tabourak/features/profile/logic/profile_cubit.dart';
import 'package:tabourak/features/profile/logic/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..loadUserData(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundImage: const AssetImage('assets/images/profile.png'),
                  ),
                  SizedBox(height: 20.h),
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        loaded: (userName) => Text(
                          userName ?? 'Asmaa',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        orElse: () => const Text(
                          'Loading...',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 40.h),
                   _buildMenuItem(
                    context,
                    icon: Icons.mobile_friendly,
                    title: 'I Want To Book Now',
                    onTap: () {
                      context.pushNamed(Routes.booknow);
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.edit,
                    title: 'Edit Profile',
                    onTap: () {
                      context.pushNamed(Routes.editProfile);
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.lock,
                    title: 'Change Password',
                    onTap: () {
                      context.pushNamed(Routes.forgetPassword);
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.notifications,
                    title: 'Notifications',
                    onTap: () {
                      context.pushNamed(Routes.notifications);
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.exit_to_app,
                    title: 'Logout',
                    onTap: () {
                      context.read<ProfileCubit>().logout(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF2366A9), size: 24.sp),
        title: Text(
          title,
          style: TextStyle(fontSize: 16.sp, color: Colors.black),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF2366A9), size: 16),
        onTap: onTap,
      ),
    );
  }
}