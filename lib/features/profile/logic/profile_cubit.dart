import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabourak/core/helpers/extention.dart';
import 'package:tabourak/core/helpers/shared_pref_helper.dart';
import 'package:tabourak/features/profile/logic/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState.initial());

  Future<void> loadUserData() async {
    try {
      emit(const ProfileState.loading());
      String? userName = await SharedPrefHelper.getSecuredString('userName');
      if (userName == null || userName.isNullOrEmpty()) {
        userName = 'User Name'; 
      }
      emit(ProfileState.loaded(userName));
    } catch (e) {
      emit(ProfileState.error(error: e.toString()));
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      emit(const ProfileState.loading());
      await SharedPrefHelper.removeSecuredData('userToken'); 
      await SharedPrefHelper.removeSecuredData('userName'); 
      await context.pushReplacementNamed('/login'); 
    } catch (e) {
      emit(ProfileState.error(error: e.toString()));
    }
  }
}