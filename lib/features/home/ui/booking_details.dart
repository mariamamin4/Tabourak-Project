import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabourak/core/routing/routes.dart';
import 'package:tabourak/features/home/data/model/booking_response.dart';
import 'package:tabourak/features/home/logic/booking_cubit.dart';
import 'package:tabourak/features/home/logic/booking_state.dart';

class BookingDetailsScreen extends StatefulWidget {
  final BookingCubit cubit;
  final BookingResponse? bookingResponse;

  const BookingDetailsScreen({super.key, required this.cubit, this.bookingResponse});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  bool reminderToggle = false;
  bool alertToggle = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.cubit,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
            child: SingleChildScrollView(
              child: BlocConsumer<BookingCubit, BookingState>(
                listener: (context, state) {
                  print("State changed in BookingDetailsScreen: $state");
                  if (state is Success) {
                    print("Booking details loaded: ${state.data.toString()}");
                  } else if (state is Error) {
                    print("Booking error: ${state.error}");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                builder: (context, state) {
                  print("Building with state: $state");
                  final bookingResponse = widget.bookingResponse ?? (state is Success ? state.data as BookingResponse : null);
                  if (bookingResponse != null) {
                    final serviceName = bookingResponse.serviceName ?? 'N/A';
                    print("Selected Service Name: $serviceName");
                    final imagePath = (serviceName.contains('محكمة'))
                        ? 'assets/images/government.png'
                        : 'assets/images/hospital.png';

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios, size: 20),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Text(
                              'Booking Details',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          height: 350.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFF356697)),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                width: 150.w,
                                height: 250.h,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(imagePath),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.r),
                                    bottomLeft: Radius.circular(10.r),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildDetailRow('Queue Number', bookingResponse.queueNumber ?? 'N/A'),
                                      SizedBox(height: 5.h),
                                      _buildDetailRow('Estimated Start Time', bookingResponse.estimatedStartTime ?? 'N/A'),
                                      SizedBox(height: 5.h),
                                      _buildDetailRow('Service', bookingResponse.serviceName ?? 'N/A'),
                                      SizedBox(height: 5.h),
                                      _buildDetailRow('Branch', bookingResponse.branchName ?? 'N/A'),
                                      SizedBox(height: 5.h),
                                      _buildDetailRow('Created At', bookingResponse.createdAt ?? 'N/A'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Reminders & Notifications',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFF356697)),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          padding: EdgeInsets.all(8.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Reminder 10 minutes before',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: const Color(0xFF6C6C6C),
                                ),
                              ),
                              Switch(
                                value: reminderToggle,
                                onChanged: (value) {
                                  setState(() {
                                    reminderToggle = value;
                                  });
                                },
                                activeColor: const Color(0xFF4CAF50),
                                activeTrackColor: const Color(0xFF4CAF50).withOpacity(0.5),
                                inactiveThumbColor: const Color(0xFFF44336),
                                inactiveTrackColor: const Color(0xFFF44336).withOpacity(0.5),
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                splashRadius: 30.0,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFF356697)),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          padding: EdgeInsets.all(8.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Alert when your turn is near',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: const Color(0xFF6C6C6C),
                                ),
                              ),
                              Switch(
                                value: alertToggle,
                                onChanged: (value) {
                                  setState(() {
                                    alertToggle = value;
                                  });
                                },
                                activeColor: const Color(0xFF4CAF50),
                                activeTrackColor: const Color(0xFF4CAF50).withOpacity(0.5),
                                inactiveThumbColor: const Color(0xFFF44336),
                                inactiveTrackColor: const Color(0xFFF44336).withOpacity(0.5),
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                splashRadius: 30.0,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Notes',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            TextFormField(
                              maxLines: 4,
                              decoration: InputDecoration(
                                hintText: 'Enter notes...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 48.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, Routes.bookconfirm);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF356697),
                                  padding: EdgeInsets.symmetric(vertical: 15.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                child: const Text(
                                  'Confirm Booking',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, Routes.bookAsGuest);
                                },
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Color(0xFF356697)),
                                  padding: EdgeInsets.symmetric(vertical: 15.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                child: const Text(
                                  'Back',
                                  style: TextStyle(color: Color(0xFF356697)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else if (state is Loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is Error) {
                    return Center(
                      child: Text(
                        'Error: ${state.error}',
                        style: TextStyle(fontSize: 16.sp, color: Colors.red),
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
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
          selectedItemColor: const Color(0xFF007BFF),
          unselectedItemColor: Colors.grey,
          onTap: (index) {},
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF356697),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.sp,
            color: const Color(0xFF6C6C6C),
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ],
    );
  }
}