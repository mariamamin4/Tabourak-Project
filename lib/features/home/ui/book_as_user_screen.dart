import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabourak/core/di/dependency_injection.dart';
import 'package:tabourak/features/home/data/model/booking_response.dart';
import 'package:tabourak/features/home/logic/booking_cubit.dart';
import 'package:tabourak/features/home/logic/booking_state.dart';
import 'package:tabourak/features/home/ui/booking_details.dart';

class BookAsUserScreen extends StatelessWidget {
  const BookAsUserScreen({super.key});

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
                            'Book as User',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 48.h),
                      Form(
                        key: context.read<BookingCubit>().formKeyUser,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: BlocBuilder<BookingCubit, BookingState>(
                          builder: (context, state) {
                            final cubit = context.read<BookingCubit>();
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Branch',
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.black)),
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
                                      cubit.formKeyUser.currentState?.validate();
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
                                  validator: (value) =>
                                      value == null ? 'Required' : null,
                                ),
                                SizedBox(height: 20.h),
                                Text('Service',
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.black)),
                                SizedBox(height: 8.h),
                                DropdownButtonFormField<int>(
                                  value: cubit.selectedServiceId,
                                  hint: const Text('Select Service'),
                                  items: cubit
                                      .getServicesByBranch(cubit.selectedBranchId)
                                      .map((service) {
                                    return DropdownMenuItem<int>(
                                      value: service['id'],
                                      child: Text(service['name']),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      cubit.selectService(value);
                                      cubit.formKeyUser.currentState?.validate();
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
                                  validator: (value) =>
                                      value == null ? 'Required' : null,
                                ),
                                SizedBox(height: 48.h),
                                BlocConsumer<BookingCubit, BookingState>(
                                  listener: (context, state) {
                                    if (state is Success) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => BlocProvider.value(
                                            value: context.read<BookingCubit>(),
                                            child: BookingDetailsScreen(
                                              cubit: context.read<BookingCubit>(),
                                              bookingResponse: state.data as BookingResponse, 
                                            ),
                                          ),
                                        ),
                                      );
                                    } else if (state is Error) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(state.error)),
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        final cubit = context.read<BookingCubit>();
                                        if (cubit.formKeyUser.currentState
                                                ?.validate() ??
                                            false) {
                                          cubit.emitBookAsUser();
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF2366A9),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 15.h),
                                        minimumSize:
                                            Size(double.infinity, 50.h),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
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