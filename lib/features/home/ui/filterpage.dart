import 'package:flutter/material.dart';
import 'package:tabourak/core/routing/routes.dart';
import 'package:tabourak/features/home/ui/booknow.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> services = [
    {'title': ' قيد دعوي', 'time': '0-14 minutes', 'rating': 4.8, 'distance': '0.7 km'},
    {'title': 'كشف باطنة', 'time': '0-18 minutes', 'rating': 4.9, 'distance': '0.9 km'},
    {'title': 'تحاليل طبية ', 'time': '0-16 minutes', 'rating': 4.7, 'distance': '0.8 km'},
    {'title': 'استخراج شهادة', 'time': '0-14 minutes', 'rating': 4.5, 'distance': '0.9 km'},
    {'title': ' كشف عظام', 'time': '0-12 minutes', 'rating': 4.6, 'distance': '0.8 km'},
    {'title': 'توثيق عقد', 'time': '0-15 minutes', 'rating': 4.0, 'distance': '0.7 km'},

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Filter'),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Select Service',
                  hintStyle: const TextStyle(color: Color(0xFF6C6C6C)),
                  suffixIcon: const Icon(Icons.search, color: Color(0xFF1A4C7F)),
                  border:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xFF1A4C7F)),
                  ),
                  enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xFF1A4C7F)),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFECF2F8),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final service = services[index];
                    if (_searchController.text.isEmpty ||
                        service['title']
                            .toLowerCase()
                            .contains(_searchController.text.toLowerCase())) {
                      return _buildServiceCard(
                        context,
                        title: service['title'],
                        time: service['time'],
                        rating: service['rating'],
                        distance: service['distance'],
                        color: Colors.white,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.handshake_outlined), label: 'Service'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none_outlined), label: 'Notify'),
          BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined), label: 'Profile'),
        ],
        currentIndex: 1,
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
    );
  }

  Widget _buildServiceCard(BuildContext context, {
    required String title,
    required String time,
    required double rating,
    required String distance,
    required Color color,
  }) {
    return Card(
      color: color,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xFF356697)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$time | '),
                    const SizedBox(width: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.star, size: 16, color: Colors.amber),
                            Text(rating.toString()),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 16),
                            Text(distance),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BookNow()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF5692D3),
                          const Color(0xFF356697),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: const Text(
                      'Book Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xFF1A4C7F),
                    backgroundColor: const Color(0xFFECF2F8),
                    side: const BorderSide(color: Color(0xFF1A4C7F)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('View'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

