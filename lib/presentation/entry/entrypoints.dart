part of 'entrypoint_imports.dart';

/* 
 * Screen Overview:
 * ---------------
 * The BottomNavigationPage serves as the main navigation container for the FleekHR app.
 * It implements a modern bottom navigation bar with animated transitions between three
 * primary sections: Home, Request, and Profile.
 * 
 * Key Features:
 * 1. Preserves screen state when switching between tabs using IndexedStack
 * 2. Provides visual feedback through animations and styling changes
 * 3. Implements theme-awareness with dynamic colors based on light/dark mode
 * 4. Uses constants from NavBarStyles for consistent styling
 * 5. Supports easy navigation between main app sections
 * 
 * User Flow:
 * The user starts at the Home tab and can navigate between sections by tapping
 * the corresponding tab in the bottom navigation bar. Each tab maintains its state
 * independently, allowing users to resume where they left off when returning to a tab.
 * The app bar provides quick access to notifications and theme toggling.
 * 
 * Architecture:
 * This screen follows a part-of pattern where it's included in the entrypoint_imports.dart
 * file. It uses BLoC pattern for theme management via ThemeCubit and follows
 * responsive design principles with ScreenUtil for proper sizing across devices.
 */
class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        actions: [
          // Notifications & Theme Toggle
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Handle notification tap
            },
          ),
          IconButton(
            icon: Icon(
              context.watch<ThemeCubit>().state.brightness == Brightness.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
              color: Colors.white,
            ),
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        height: NavBarStyles.navBarHeight,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            // Trigger haptic feedback if available
            setState(() => _currentIndex = index);
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey.shade600,
          selectedLabelStyle: appStyle(
            size: NavBarStyles.labelFontSize,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: appStyle(
            color: Colors.grey.shade600,
            size: NavBarStyles.labelFontSize,
            fontWeight: FontWeight.w400,
          ),
          //Navigation Items/pages [Home, Request, Profile]
          items: [
            _buildNavItem(
              index: 0,
              icon: Icons.home, //Icon Shown when not selected
              selectedIcon: Icons.home_outlined,
              label: "Home", //Text label
            ),
            _buildNavItem(
              index: 1,
              icon: Icons.add_outlined,
              selectedIcon: Icons.add,
              label: "Request",
            ),
            _buildNavItem(
              index: 2,
              icon: Icons.person,
              selectedIcon: Icons.person_rounded,
              label: "Profile",
            ),
          ],
        ),
      ),
      // Main content area - uses IndexedStack to preserve state when switching tabs
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          // Each child corresponds to a tab in the BottomNavigationBar
          children: const [Homepage(), Requestpage(), Profilepage()],
        ),
      ),
    );
  }

  /// A method to build consistent navigation items with animations
  /// Creates a BottomNavigationBarItem with:
  /// - Scale animation when selected
  /// - Different icons for selected/unselected states
  /// - Gradient background for active icon
  BottomNavigationBarItem _buildNavItem({
    required int index,
    required IconData icon,
    required IconData selectedIcon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: AnimatedScale(
        scale: _currentIndex == index ? 1.1 : 1.0,
        duration: NavBarStyles.animationDuration,
        curve: NavBarStyles.animationCurve,
        child: Icon(
          _currentIndex == index ? selectedIcon : icon,
          size: NavBarStyles.iconSize,
        ),
      ),
      label: label, // Tab label text
      // Custom styled active icon with gradient background
      activeIcon: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.1),
              Theme.of(context).primaryColor.withOpacity(0.2),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Icon(selectedIcon, size: NavBarStyles.iconSize),
      ),
    );
  }
}
