import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class MenuItem {
  final String menu;
  final List<PageItem> pages;

  MenuItem({required this.menu, required this.pages});

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    List<dynamic> pagesJson = json['page'] ?? [];
    List<PageItem> pages = pagesJson.map((pageJson) => PageItem.fromJson(pageJson)).toList();
    return MenuItem(menu: json['menu'], pages: pages);
  }
}

class PageItem {
  final String page;

  PageItem({required this.page});

  factory PageItem.fromJson(Map<String, dynamic> json) {
    return PageItem(page: json['page']);
  }
}

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late Future<List<MenuItem>> _menuItems;

  @override
  void initState() {
    super.initState();
    _menuItems = fetchMenuItems();
  }

  Future<List<MenuItem>> fetchMenuItems() async {
    final response = await http.get(Uri.parse('http://192.168.1.7/tvsmotors/api2/submenu.php'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => MenuItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load menu items');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder<List<MenuItem>>(
        future: _menuItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<MenuItem> menuItems = snapshot.data!;
            return ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(menuItems[index].menu),
                  onTap: () {
                    navigateToPage(menuItems[index]);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  void navigateToPage(MenuItem menuItem) {
    if (menuItem.pages.isNotEmpty) {
      String page = menuItem.pages.first.page.trim();
      switch (page) {
        case 'homepage1':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
          break;
        case 'dashboradpage1':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashboardPage()),
          );
          break;
      // Add cases for other pages as needed
        default:
        // Handle unknown page
          break;
      }
    }
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Home Page Content'),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard Page'),
      ),
      body: Center(
        child: Text('Dashboard Page Content'),
      ),
    );
  }
}
