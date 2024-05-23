import 'package:e_tablo/views/devices/devices.dart';
import 'package:e_tablo/views/market/marketplace.dart';
import 'package:e_tablo/views/profile/profile.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<BottomNavigationBarItem> _items = [
    const BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: "Market"),
    const BottomNavigationBarItem(icon: Icon(Icons.tablet), label: "Cihazlarım"),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil")
  ];

  static final List<Widget> _pages = [const MarketplaceView(), const DevicesView(), const ProfileView()];

  int _index = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (selectedIndex) {
            setState(() {
              _index = selectedIndex;
            });
          },
          showUnselectedLabels: false,
          currentIndex: _index,
          items: _items),
    );
  }
}
