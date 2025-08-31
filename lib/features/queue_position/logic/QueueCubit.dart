import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabourak/core/networking/api_result.dart';
import 'package:tabourak/features/queue_position/data/repo/QueueRepo.dart';
import 'package:tabourak/features/queue_position/logic/queue_state.dart';

class QueueCubit extends Cubit<QueueState> {
  final QueueRepo _queueRepo;

  QueueCubit(this._queueRepo) : super(const QueueState.initial());

  void fetchQueuePosition(String ticketId) async {
    if (ticketId.isEmpty) {
      emit(const QueueState.error(error: 'No ticket ID available'));
      return;
    }

    emit(const QueueState.loading());

    final response = await _queueRepo.getQueuePosition(ticketId);

    response.when(
      success: (queueResponse) {
        emit(QueueState.success(queueResponse));
      },
      failure: (error) {
        emit(QueueState.error(error: error.apiErrorModel.message ?? ''));
      },
    );
  }
}