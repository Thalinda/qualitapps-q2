import 'package:flutter/material.dart';
import 'package:q2/main.dart';
import 'package:q2/view_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Widget>> _pages;
  int _selectedpage = 0;

  @override
  void initState() {
    _pages = [
      {
        'title': Text(
          "Vote",
          style: TextStyle(color: Colors.white),
        ),
        'page': MyApp(),
      },
      {
        'title': Text("View Votes"),
        'page': ViewVotes(),
      }
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedpage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _pages[_selectedpage]['title'],
      ),
      body: _pages[_selectedpage]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedpage,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              label: 'Category'),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.star),
              label: 'Favorite'),
        ],
      ),
    );
  }
}
