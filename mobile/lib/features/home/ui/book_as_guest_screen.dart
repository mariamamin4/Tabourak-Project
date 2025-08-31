import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabourak/core/di/dependency_injection.dart';
import 'package:tabourak/core/routing/routes.dart';
import 'package:tabourak/features/home/data/model/booking_response.dart';
import 'package:tabourak/features/home/logic/booking_cubit.dart';
import 'package:tabourak/features/home/logic/booking_state.dart';
import 'package:tabourak/features/home/ui/booking_details.dart';

class BookAsGuestScreen extends StatelessWidget {
  const BookAsGuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BookingCubit>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios, size: 20),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Text(
                            'Queue Booking',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Book your turn now or schedule it for\n a later time',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xFF414040),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Divider(
                        color: const Color(0xFF2876C4),
                        thickness: 2.h,
                        height: 2.h,
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECF2F8),
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.bookAsGuest);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2366A9),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 12.h,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.person_add, color: Colors.white),
                                  SizedBox(width: 8.w),
                                  const Text(
                                    'Guest',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.bookAsUser);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 12.h,
                                ),
                                side: const BorderSide(color: Color(0xFF2366A9)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 10.w,
                                    height: 10.h,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.fromBorderSide(
                                        BorderSide(color: Color(0xFF2366A9)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  const Text(
                                    'User',
                                    style: TextStyle(color: Color(0xFF2366A9)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Form(
                        key: context.read<BookingCubit>().formKeyGuest,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: BlocBuilder<BookingCubit, BookingState>(
                          builder: (context, state) {
                            final cubit = context.read<BookingCubit>();
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Full Name',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                TextFormField(
                                  controller: cubit.fullNameController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter full name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    filled: true,
                                    fillColor: const Color(0xFFECF2F8),
                                    errorStyle: const TextStyle(color: Colors.red),
                                  ),
                                  validator: (value) {
                                    debugPrint("Validating Full Name: $value");
                                    return value?.isEmpty ?? true ? 'Required' : null;
                                  },
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  'Email',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                TextFormField(
                                  controller: cubit.emailController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter email',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    filled: true,
                                    fillColor: const Color(0xFFECF2F8),
                                    errorStyle: const TextStyle(color: Colors.red),
                                  ),
                                  validator: (value) {
                                    debugPrint("Validating Email: $value");
                                    return value?.isEmpty ?? true ? 'Required' : null;
                                  },
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  'Phone Number',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                TextFormField(
                                  controller: cubit.phoneNumberController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter phone number',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    filled: true,
                                    fillColor: const Color(0xFFECF2F8),
                                    errorStyle: const TextStyle(color: Colors.red),
                                  ),
                                  validator: (value) {
                                    debugPrint("Validating Phone: $value");
                                    return value?.isEmpty ?? true ? 'Required' : null;
                                  },
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  'Branch',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                DropdownButtonFormField<int>(
                                  value: cubit.selectedBranchId,
                                  hint: const Text('Select Branch'),
                                  items: cubit.branches.map((branch) {
                                    return DropdownMenuItem<int>(
                                      value: branch['id'],
                                      child: Text(branch['name']),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      cubit.selectBranch(value);
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    filled: true,
                                    fillColor: const Color(0xFFECF2F8),
                                    errorStyle: const TextStyle(color: Colors.red),
                                  ),
                                  validator: (value) {
                                    debugPrint("Validating Branch: $value");
                                    return value == null ? 'Required' : null;
                                  },
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  'Service',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                DropdownButtonFormField<int>(
                                  value: cubit.selectedServiceId,
                                  hint: const Text('Select Service'),
                                  items: cubit.getServicesByBranch(cubit.selectedBranchId).map((service) {
                                    return DropdownMenuItem<int>(
                                      value: service['id'],
                                      child: Text(service['name']),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      cubit.selectService(value);
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    filled: true,
                                    fillColor: const Color(0xFFECF2F8),
                                    errorStyle: const TextStyle(color: Colors.red),
                                  ),
                                  validator: (value) {
                                    debugPrint("Validating Service: $value");
                                    return value == null ? 'Required' : null;
                                  },
                                ),
                                SizedBox(height: 48.h),
                                BlocConsumer<BookingCubit, BookingState>(
                                  listener: (context, state) {
                                    if (state is Success) {
                                      print("Navigation to booking details triggered");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BookingDetailsScreen(
                                            cubit: context.read<BookingCubit>(),
                                            bookingResponse: state.data as BookingResponse,
                                          ),
                                        ),
                                      );
                                    } else if (state is Error) {
                                      print("Error occurred: ${state.error}");
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(state.error)),
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        final cubit = context.read<BookingCubit>();
                                        print("Full Name: ${cubit.fullNameController.text}");
                                        print("Email: ${cubit.emailController.text}");
                                        print("Phone: ${cubit.phoneNumberController.text}");
                                        print("Selected Branch ID: ${cubit.selectedBranchId}");
                                        print("Selected Service ID: ${cubit.selectedServiceId}");
                                        if (cubit.formKeyGuest.currentState?.validate() ?? false) {
                                          print("Form validated, calling emitBookAsGuest");
                                          cubit.emitBookAsGuest();
                                        } else {
                                          print("Form validation failed");
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF2366A9),
                                        padding: EdgeInsets.symmetric(vertical: 15.h),
                                        minimumSize: Size(double.infinity, 50.h),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.r),
                                        ),
                                      ),
                                      child: const Text(
                                        'Book Now',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}