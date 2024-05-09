import 'package:flutter/material.dart';
import 'package:grocery_store_app/screen/header_parts.dart';
import 'package:grocery_store_app/screen/items_diplay.dart';
import 'package:grocery_store_app/screen/my_profile_page.dart'; // Import your MyProfilePage
import 'package:grocery_store_app/utils/colors.dart';
import 'package:grocery_store_app/screen/products_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // For handling the current index of BottomNavigationBar

  // List of pages to navigate to
  final List<Widget> _pages = [
    ListView(
      children: [
        SizedBox(height: 15),
        HeaderParts(),
        ItemsDisplay(),
      ],
    ),
     ProductsPage(), // Placeholder for Chat Page
    const Text("Shopping Cart"), // Placeholder for Shopping Cart
    const Text("Notifications"), // Placeholder for Notifications
    const Text("Favorites"), // Placeholder for Favorites
    const MyProfilePage(), // My Profile Page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        selectedItemColor: primaryColors,
        unselectedItemColor: Colors.green[200],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notification'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'), // Profile icon
        ],
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex), // Display the selected page
      ),
    );
  }
}
