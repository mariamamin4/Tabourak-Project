import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabourak/core/di/dependency_injection.dart';
import 'package:tabourak/core/helpers/extention.dart';
import 'package:tabourak/core/routing/routes.dart';
import 'package:tabourak/features/queue_position/data/repo/QueueRepo.dart';
import 'package:tabourak/features/queue_position/logic/QueueCubit.dart';
import 'package:tabourak/features/queue_position/logic/queue_state.dart';
import 'package:tabourak/features/queue_position/data/queue_position_response.dart';

class QueueStatusPage extends StatelessWidget {
  const QueueStatusPage({super.key});

  Future<QueueCubit> _initializeCubit() async {
    final prefs = await SharedPreferences.getInstance();
    final ticketId = prefs.getString('booking_id');
    final cubit = QueueCubit(getIt<QueueRepo>());
    if (ticketId != null) {
      cubit.fetchQueuePosition(ticketId);
    } else {
      cubit.fetchQueuePosition('');
    }
    return cubit;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QueueCubit>(
      future: _initializeCubit(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return const Scaffold(body: Center(child: Text('Error loading queue status')));
        }
        return BlocProvider.value(
          value: snapshot.data!,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                'Queue Status',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: BlocBuilder<QueueCubit, QueueState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const Center(child: CircularProgressIndicator()),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error) => Center(child: Text(error)),
                  success: (data) => _buildContent(context, data),
                );
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.handshake), label: 'Service'),
                BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notification'),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
              ],
              currentIndex: 1,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, QueuePositionResponse data) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Know your number and estimated time with real-time updates',
            style: TextStyle(color: Color(0xFF414040)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBox(Icons.queue, 'Queue Number', data.ticketNumber ?? ''),
              _buildBox(Icons.people, 'People Ahead', data.peopleInFront.toString()),
              _buildBox(Icons.access_time, 'Wait Time', _formatTime(data.estimatedWaitingTime ?? '')),
            ],
          ),
          const SizedBox(height: 30), 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Progress', style: TextStyle(color: Color(0xFF356697))),
              const Text('75%', style: TextStyle(color: Color(0xFF356697))),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: LinearProgressIndicator(
              value: 0.75,
              backgroundColor: Colors.grey[300],
              color: const Color(0xFF356697),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFF356697)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.warning, color: Color(0xFF1A4C7F)),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Alert: Your turn is getting closer!',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      Text(
                        'Get ready, only ${data.peopleInFront ?? 0} people ahead of you.',
                        style: TextStyle(color: Color(0xFF6C6C6C)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2876C4),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
                              context.pushNamed(Routes.homeScreen);

            },
            child: const Text(
              'Go Home',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Column(
              children: [
                Text('The queue status will be updated automatically'),
                Text('Last Update: Now'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBox(IconData icon, String title, String value) {
    return Container(
      height: 86,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF356697)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF356697)),
          Text(title, style: TextStyle(color: const Color(0xFF356697))),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: const Color(0xFF356697))),
        ],
      ),
    );
  }

  String _formatTime(String time) {
    if (time.isEmpty) return '';
    final parts = time.split(':');
    final hours = int.parse(parts[0]);
    final mins = int.parse(parts[1]);
    if (hours > 0) {
      return '${hours}h ${mins}min';
    }
    return '${mins}min';
  }
}