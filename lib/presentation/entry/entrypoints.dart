part of 'entrypoint_imports.dart';

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
          //Notifications & Dark Button
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              context.watch<ThemeCubit>().state.brightness == Brightness.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        height: 80.h,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.home, Icons.home_filled, "Home"),
            _buildNavItem(
                1, Icons.request_page, Icons.request_page_outlined, "Request"),
            _buildNavItem(2, Icons.person, Icons.person_rounded, "Profile"),
          ],
        ),
      ),
      body: SafeArea(
          child: IndexedStack(
        index: _currentIndex,
        children: [Homepage(), Requestpage(), Profilepage()],
      )),
    );
  }

  Widget _buildNavItem(
      int index, IconData icon, IconData iconSelected, String label) {
    final isSelected = _currentIndex == index;
    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: isSelected ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isSelected ? iconSelected : icon,
                color: isSelected
                    ? Theme.of(context).canvasColor
                    : Colors.grey.shade600,
                size: 28.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: isSelected
                    ? Theme.of(context).canvasColor
                    : Colors.grey.shade600,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
