import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabourak/core/routing/routes.dart';
import 'package:tabourak/features/notification/data/notifications_repository.dart';
import 'package:tabourak/features/notification/data/notifications_response.dart';
import 'package:tabourak/features/notification/logic/notifications_cubit.dart';
import 'package:tabourak/features/notification/logic/notifications_state.dart';
import 'package:tabourak/core/networking/api_service.dart';
import 'package:dio/dio.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final apiService = ApiService(dio);
    final notificationsRepo = NotificationsRepo(apiService);

    return BlocProvider(
      create: (context) => NotificationsCubit(notificationsRepo)..fetchNotifications(), 
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Notifications'),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
          ],
        ),
        body: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is Error) {
              return Center(child: Text(state.error));
            }
            if (state is Success) {
              final notifications = (state.data as NotificationsResponse).notifications ?? [];
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('You have 2 unread notifications', style: TextStyle(fontSize: 16)),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        return ListTile(
                          leading: Text(notification.icon ?? '📢'),
                          title: Text(notification.title ?? ''),
                          subtitle: Text(notification.time ?? ''),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2876C4),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.queuestate);
                      },
                      child: const Text('Rejoin Queue', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
         bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.handshake_outlined), label: 'Service'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none_outlined), label: 'Notify'),
          BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined), label: 'Profile'),
        ],
        currentIndex: 2, 
        selectedItemColor: const Color(0xFF1A4C7F),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
         switch (index) {
              case 0:
                Navigator.pushNamed(context, Routes.homeScreen); 
                break;
              case 1:
                Navigator.pushNamed(context, Routes.filterScreen);
                break;
              case 2:
                Navigator.pushNamed(context, Routes.notifications); 
                break;
              case 3:
                Navigator.pushNamed(context, Routes.profile); 
                break;
            } 
        },
      ),
      ),
    );
  }
}