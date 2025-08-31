import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabourak/core/networking/api_result.dart';
import 'package:tabourak/features/home/data/model/book_as_guest_request_body.dart';
import 'package:tabourak/features/home/data/model/book_as_user_request_body.dart';
import 'package:tabourak/features/home/data/repos/booking_repo.dart';
import 'package:tabourak/features/home/logic/booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingRepo _bookingRepo;
  BookingCubit(this._bookingRepo) : super(const BookingState.initial());

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  final formKeyGuest = GlobalKey<FormState>();
  final formKeyUser = GlobalKey<FormState>();
  int? selectedBranchId;
  int? selectedServiceId;

  List<Map<String, dynamic>> branches = [
    {'id': 1, 'name': 'محكمة القاهرة'},
    {'id': 2, 'name': 'مستشفى السلام'},
  ];

  List<Map<String, dynamic>> getServicesByBranch(int? branchId) {
    if (branchId == 1) {
      return [
        {'id': 1, 'name': 'قيد دعوى'},
        {'id': 2, 'name': 'إستخراج شهادة'},
        {'id': 3, 'name': 'توثيق عقد'},
      ];
    } else if (branchId == 2) {
      return [
        {'id': 4, 'name': 'كشف باطنة'},
        {'id': 5, 'name': 'كشف عظام'},
        {'id': 6, 'name': 'تحاليل طبية'},
      ];
    }
    return [];
  }

  void selectBranch(int? id) {
    selectedBranchId = id;
    selectedServiceId = null;
    print('Selected Branch ID: $selectedBranchId');
    emit(const BookingState.initial());
  }

  void selectService(int? id) {
    selectedServiceId = id;
    print('Selected Service ID: $selectedServiceId');
    emit(const BookingState.initial());
  }

  Future<void> _saveBookingId(String? id) async {
    if (id != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('booking_id', id);
    }
  }

  Future<String?> getBookingId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('booking_id');
  }

  void emitBookAsGuest() async {
    emit(const BookingState.loading());
    try {
      print('Sending book as guest request...');
      final response = await _bookingRepo.bookAsGuest(
        BookAsGuestRequestBody(
          fullName: fullNameController.text,
          email: emailController.text,
          phoneNumber: phoneNumberController.text,
          branchId: selectedBranchId ?? 0,
          serviceId: selectedServiceId ?? 0,
        ),
      ).timeout(const Duration(seconds: 10));
      response.when(
        success: (bookingResponse) async {
          print('Book as guest success: $bookingResponse');
          await _saveBookingId(bookingResponse.id);
          emit(BookingState.success(bookingResponse));
        },
        failure: (error) {
          print('Book as guest failure: ${error.apiErrorModel.message}');
          emit(BookingState.error(error: error.apiErrorModel.message ?? 'Booking failed'));
        },
      );
    } catch (e) {
      print('Book as guest error: $e');
      emit(BookingState.error(error: e.toString()));
    }
  }

  void emitBookAsUser() async {
    emit(const BookingState.loading());
    try {
      print('Sending book as user request...');
      final response = await _bookingRepo.bookAsUser(
        BookAsUserRequestBody(
          branchId: selectedBranchId ?? 0,
          serviceId: selectedServiceId ?? 0,
        ),
      ).timeout(const Duration(seconds: 10));
      response.when(
        success: (bookingResponse) async {
          print('Book as user success: $bookingResponse');
          await _saveBookingId(bookingResponse.id);
          emit(BookingState.success(bookingResponse));
        },
        failure: (error) {
          print('Book as user failure: ${error.apiErrorModel.message}');
          emit(BookingState.error(error: error.apiErrorModel.message ?? 'Booking failed'));
        },
      );
    } catch (e) {
      print('Book as user error: $e');
      emit(BookingState.error(error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    fullNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    return super.close();
  }
}