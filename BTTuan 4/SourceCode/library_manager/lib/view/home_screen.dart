import 'package:flutter/cupertino.dart';
import 'package:library_manager/view/book_manager_screen.dart';
import 'package:library_manager/view/manager_screen.dart';
import 'package:library_manager/view/student_manager_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    ManagerScreen(),
    BookManagerScreen(),
    StudentManagerScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          Expanded(child: _pages[_selectedIndex]),
          CupertinoTabBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                label: 'Quản lý',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.doc),
                label: 'DS Sách',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person),
                label: 'Sinh viên',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
