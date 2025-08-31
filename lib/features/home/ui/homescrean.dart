import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabourak/core/helpers/constants.dart';
import 'package:tabourak/features/home/data/repos/userinforepo.dart';
import 'package:tabourak/features/home/logic/user_info_state.dart';
import 'package:tabourak/features/home/logic/userinfoqubit.dart';
import 'package:tabourak/features/home/ui/filterpage.dart';
import 'package:tabourak/core/routing/routes.dart';
import 'package:tabourak/features/home/ui/booknow.dart';
import 'package:tabourak/features/map/map_screen.dart';
import 'package:tabourak/core/helpers/shared_pref_helper.dart';
import 'package:tabourak/core/di/dependency_injection.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future<UserInfoCubit> _initializeCubit() async {
    final token = await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken) ?? '';
    final cubit = UserInfoCubit(getIt<UserInfoRepo>()); 
    if (token.isNotEmpty) {
      cubit.fetchUserInfo(token);
    } else {
      cubit.emit(const UserInfoState.error(error: 'No token available'));
    }
    return cubit;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<UserInfoCubit>(
        future: _initializeCubit(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: Text('Error loading user info')),
            );
          }
          return BlocProvider.value(
            value: snapshot.data!,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: BlocBuilder<UserInfoCubit, UserInfoState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Color(0xFF113355),
                            child: Icon(Icons.person, color: Colors.white, size: 30),
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hello Asmaa', style: TextStyle(color: Color(0xFF113355))),
                              SizedBox(height: 4),
                              Text('Have you booked your turn?', style: TextStyle(color: Color(0xFF113355), fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                      loading: () => Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Color(0xFF113355),
                            child: Icon(Icons.person, color: Colors.white, size: 30),
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hello ...', style: TextStyle(color: Color(0xFF113355))),
                              SizedBox(height: 4),
                              Text('Have you booked your turn?', style: TextStyle(color: Color(0xFF113355), fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                      success: (data) => Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Color(0xFF113355),
                            child: Icon(Icons.person, color: Colors.white, size: 30),
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hello ${data.userName ?? 'Asmaa'}', style: TextStyle(color: Color(0xFF113355))),
                              SizedBox(height: 4),
                              Text('Have you booked your turn?', style: TextStyle(color: Color(0xFF113355), fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                      error: (error) => Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Color(0xFF113355),
                            child: Icon(Icons.person, color: Colors.white, size: 30),
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hello User', style: TextStyle(color: Color(0xFF113355))),
                              SizedBox(height: 4),
                              Text('Have you booked your turn?', style: TextStyle(color: Color(0xFF113355), fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.notifications_none_outlined, color: Color(0xFF113355), size: 32),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.notifications);
                    },
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Select the required service',
                                  hintStyle: TextStyle(color: Color(0xFF6C6C6C)),
                                  suffixIcon: Icon(Icons.search, color: Color(0xFF1A4C7F)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Color(0xFF1A4C7F)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Color(0xFF1A4C7F)),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFECF2F8),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => FilterScreen()),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Container(
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: Color(0xFFECF2F8),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Color(0xFF1A4C7F)),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.location_on, color: Color(0xFF1A4C7F)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MapScreen()),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => BookNow()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Color(0xFF1A4C7F),
                                backgroundColor: Color(0xFFECF2F8),
                                side: BorderSide(color: Color(0xFF356697), width: 1),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.business, color: Color(0xFF1A4C7F)),
                                  SizedBox(width: 5),
                                  Text('Government consultation', style: TextStyle(color: Color(0xFF6C6C6C))),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => BookNow()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Color(0xFF1A4C7F),
                                backgroundColor: Color(0xFFECF2F8),
                                side: BorderSide(color: Color(0xFF356697), width: 1),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.local_hospital, color: Color(0xFF1A4C7F)),
                                  SizedBox(width: 5),
                                  Text('Medical consultation', style: TextStyle(color: Color(0xFF6C6C6C))),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ServiceCard(
                              bordercolor: Color(0xFF113355),
                              imageUrl: 'assets/images/hospital.png',
                              waitingTime: '9 minutes',
                              rating: '4.8',
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: ServiceCard(
                              bordercolor: Color(0xFF113355),
                              imageUrl: 'assets/images/government.png',
                              waitingTime: '12 minutes',
                              rating: '4.6',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Service', style: TextStyle(color: Color(0xFF113355), fontWeight: FontWeight.bold)),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.filterScreen);
                            },
                            child: Text('See all', style: TextStyle(color: Color(0xFF6C6C6C))),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ServiceListItem(
                        title: 'Current Booking:',
                        items: [
                          'Turn Number: B-027 Branch',
                          'Waiting Time: 14 minutes',
                          'Branch: Central Branch',
                        ],
                      ),
                      SizedBox(height: 20),
                      ServiceListItem(
                        title: 'Current Booking:',
                        items: [
                          'Turn Number: A-112 Branch',
                          'Waiting Time: 20 minutes',
                          'Branch: East Branch',
                        ],
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.white,
                elevation: 2,
                selectedItemColor: Color(0xFF113355),
                unselectedItemColor: Color(0xFF113355),
                items: [
                  BottomNavigationBarItem(
                    icon: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFF2876C4),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.home, color: Colors.white, size: 24),
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.handshake_outlined, color: Color.fromRGBO(17, 51, 85, 1)),
                    label: 'Service',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.notifications_none_outlined, color: Color(0xFF113355)),
                    label: 'Notification',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_2_outlined, color: Color(0xFF113355)),
                    label: 'Profile',
                  ),
                ],
                currentIndex: 0,
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
        },
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String imageUrl;
  final String waitingTime;
  final String rating;
  final Color bordercolor;

  const ServiceCard({
    Key? key,
    required this.imageUrl,
    required this.waitingTime,
    required this.rating,
    required this.bordercolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              imageUrl,
              height: 120.h,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.access_time, color: Color(0xFF113355)),
                SizedBox(width: 5),
                Text('Waiting time, $waitingTime', style: TextStyle(color: Color(0xFF113355))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.yellow),
                SizedBox(width: 5),
                Text(rating, style: TextStyle(color: Color(0xFF113355))),
              ],
            ),
          ),
          SizedBox(height: 12),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF5692D3), Color(0xFF356697)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookNow()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('Book your turn', style: TextStyle(color: Colors.white)),
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}

class ServiceListItem extends StatelessWidget {
  final String title;
  final List<String> items;

  const ServiceListItem({
    Key? key,
    required this.title,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color(0xFF113355)),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: Color(0xFF113355), fontWeight: FontWeight.bold)),
                  ...items.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    IconData icon;
                    switch (index) {
                      case 0:
                        icon = Icons.confirmation_number;
                        break;
                      case 1:
                        icon = Icons.access_time;
                        break;
                      case 2:
                        icon = Icons.location_on;
                        break;
                      default:
                        icon = Icons.circle;
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        children: [
                          Icon(icon, size: 16, color: Color(0xFF113355)),
                          SizedBox(width: 5),
                          Text(item, style: TextStyle(color: Color(0xFF113355))),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(width: 10),
            Container(
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF5692D3), Color(0xFF356697)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BookNow()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text('Track Queue', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}