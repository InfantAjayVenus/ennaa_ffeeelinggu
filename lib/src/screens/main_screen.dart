import 'package:ennaa_ffeeelinggu/src/screens/history_screen.dart';
import 'package:ennaa_ffeeelinggu/src/screens/home_screen.dart';
import 'package:ennaa_ffeeelinggu/src/screens/entry_screen.dart'; // Add this import
import 'package:ennaa_ffeeelinggu/src/providers/journal_provider.dart'; // Add this import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Add this import

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    HistoryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0 ? 'Ennaa Fffeeelinggu' : 'Journal History',
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            builder: (context) => const EntryScreen(),
          );
          // Refresh entries after the EntryScreen is dismissed
          if (!context.mounted) return;
          Provider.of<JournalProvider>(context, listen: false).fetchEntries();
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
