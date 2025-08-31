import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabourak/core/networking/api_result.dart';
import 'package:tabourak/features/home/data/repos/userinforepo.dart';
import 'package:tabourak/features/home/logic/user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  final UserInfoRepo _userInfoRepo;

  UserInfoCubit(this._userInfoRepo) : super(const UserInfoState.initial());

  void fetchUserInfo(String token) async {
    emit(const UserInfoState.loading());
    final response = await _userInfoRepo.fetchUserInfo(token);
    response.when(
      success: (userInfo) {
        emit(UserInfoState.success(userInfo));
      },
      failure: (error) {
        emit(UserInfoState.error(error: error.apiErrorModel.message ?? 'Failed to fetch user info'));
      },
    );
  }
}