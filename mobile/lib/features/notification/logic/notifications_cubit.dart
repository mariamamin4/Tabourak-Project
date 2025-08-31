import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabourak/core/networking/api_result.dart';
import 'package:tabourak/features/notification/data/notifications_repository.dart';
import 'package:tabourak/features/notification/logic/notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepo _notificationsRepo;
  NotificationsCubit(this._notificationsRepo) : super(const NotificationsState.initial());

  void fetchNotifications() async {
    emit(const NotificationsState.loading());
    try {
      final response = await _notificationsRepo.fetchNotifications()
          .timeout(const Duration(seconds: 10));
      response.when(
        success: (notificationsResponse) {
          emit(NotificationsState.success(notificationsResponse));
        },
        failure: (error) {
          emit(NotificationsState.error(error: error.apiErrorModel.message ?? 'Failed to load notifications'));
        },
      );
    } catch (e) {
      emit(NotificationsState.error(error: e.toString()));
    }
  }
}