import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final Map<String, List<Map<String, String>>> groupedNotifications = {
    'Today': [
      {
        'title': 'Request Accepted!',
        'message': 'You can now come to the library to pick up your book',
        'time': '2 hours ago',
        'status': 'accepted',
        'isUnread': 'true'
      },
      {
        'title': 'Request Declined!',
        'message': 'You have reached your borrow limit',
        'time': '10 hours ago',
        'status': 'declined',
        'isUnread': 'true'
      },
    ],
    'Yesterday': [
      {
        'title': 'Request Declined!',
        'message': 'Due to a lot of damaged books',
        'time': '1 day ago',
        'status': 'declined',
        'isUnread': 'false'
      },
      {
        'title': 'Request Accepted!',
        'message': 'You can now come to the library to pick up your book',
        'time': '1 day ago',
        'status': 'accepted',
        'isUnread': 'false'
      },
    ],
    'Tuesday': [
      {
        'title': 'Request Accepted!',
        'message': 'You can now come to the library to pick up your book',
        'time': '12/07/2024',
        'status': 'accepted',
        'isUnread': 'false'
      },
      {
        'title': 'Request Declined!',
        'message': 'Due to a technical issue or system error',
        'time': '12/07/2024',
        'status': 'declined',
        'isUnread': 'true'
      },
    ],
  };

  Widget _buildSection(String sectionTitle, List<Map<String, String>> notifications) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(
            sectionTitle,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            final isUnread = notification['isUnread'] == 'true';
            return ListTile(
              leading: Icon(
                notification['status'] == 'accepted' ? Icons.check_circle : Icons.cancel,
                color: notification['status'] == 'accepted' ? Colors.green : Colors.red,
              ),
              title: Text(
                notification['title']!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(notification['message']!),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(notification['time']!, style: TextStyle(fontSize: 12)),
                  if (isUnread)
                    Icon(Icons.circle, size: 8, color: Colors.red),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffffffff),
          title: const Center(
            child: Text(
              "Notification",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
            ),
          ),
          bottom: const TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Read'),
              Tab(text: 'Unread'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              children: groupedNotifications.entries.map((entry) {
                return _buildSection(entry.key, entry.value);
              }).toList(),
            ),
            ListView(
              children: groupedNotifications.entries.map((entry) {
                return _buildSection(
                  entry.key,
                  entry.value.where((n) => n['isUnread'] == 'false').toList(),
                );
              }).toList(),
            ),
            ListView(
              children: groupedNotifications.entries.map((entry) {
                return _buildSection(
                  entry.key,
                  entry.value.where((n) => n['isUnread'] == 'true').toList(),
                );
              }).toList(),
            ),
          ],
        ),
        bottomNavigationBar: SizedBox(
  height: 101,
  child: BottomNavigationBar(
          //currentIndex: _selectedIndex,
          //onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined),
              label: 'My Books',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          backgroundColor: Colors.white,

        ),

      ),
      ),
    );
  }
}
