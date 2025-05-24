part of 'navigation_imports.dart';

class AdminNavigation extends StatefulWidget {
  const AdminNavigation({super.key});

  @override
  State<AdminNavigation> createState() => _AdminNavigationState();
}

class _AdminNavigationState extends State<AdminNavigation> {
  int _currentIndex = 0;

  //Screen list for navigation
  final List<Widget> _screens = [
    const AdminHomeScreen(),
    const AttendenceScreen(),
    const LeaveScreen(),
    const ExpenseScreen(),
    // Placeholder for the fourth screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Index stack
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
      ),

      bottomNavigationBar: CrystalNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        // indicatorColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.3),
        // outlineBorderColor: Colors.black.withOpacity(0.1),
        borderWidth: 2,
        outlineBorderColor: Colors.black.withOpacity(0.1),

        items: [
          CrystalNavigationBarItem(
              icon: Icons.home,
              unselectedIcon: Icons.home_outlined,
              selectedColor: Colors.white),
          CrystalNavigationBarItem(
              icon: Icons.date_range,
              unselectedIcon: Icons.date_range_outlined,
              selectedColor: Colors.white),
          CrystalNavigationBarItem(
            icon: Icons.event_available,
            unselectedIcon: Icons.event_available_outlined,
            selectedColor: Colors.white,
          ),
          CrystalNavigationBarItem(
            icon: Icons.luggage,
            unselectedIcon: Icons.luggage_outlined,
            selectedColor: Colors.white,
          )
        ],
      ),
    );
  }
}
