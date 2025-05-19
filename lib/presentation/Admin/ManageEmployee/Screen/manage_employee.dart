part of 'manage_employee_imports.dart';

class ManageEmployee extends StatelessWidget {
  const ManageEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /**
       *  Pre-requisite:
       * 1. Search button to search for employees.
       * 2. Dashboard to show the some of things such as 
       *     Total number of employees.
       *     Active employees.
       *     Pending employees.
       *  
       *  3. Row(Widget => List of employee) + Filter button
       *  4. List of employees with details such as
       *  Represent the following data in card { Name, Email, Role, Shift, Last Login, Status, Duty Hours }
       *    Clicking on card will navigate to the employee details screen.
       *    In employee details screen we can see the following data 
       *         {Name, Designation, Email, Phone Number, Overview, Shift, Current Salary}
       */
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 12, right: 12, top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar and filter section
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search employees...',
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: AppTextstyle(
                      text: "Filter",
                      style: appStyle(
                          size: 15.sp,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              //Dashboard Card Section
              AppTextstyle(
                text: "Dashboard",
                style: appStyle(
                    size: 22.sp,
                    color: Theme.of(context).textTheme.bodyMedium?.color ??
                        Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20.h),

              //Dashboard Card to show employee stats
              Row(
                children: [
                  _buildDashboardCard(
                    context,
                    title: 'Total Employees',
                    count: '156',
                    icon: Icons.people,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 12),
                  _buildDashboardCard(
                    context,
                    title: 'Active Employees',
                    count: '142',
                    icon: Icons.check_circle,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 12),
                  _buildDashboardCard(
                    context,
                    title: 'Pending Employees',
                    count: '14',
                    icon: Icons.pending_actions,
                    color: Colors.orange,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Employees list section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Employee List',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: AppTextstyle(
                      text: "View All",
                      style: appStyle(
                          size: 15.sp,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildDashboardCard(
  BuildContext context, {
  required String title,
  required String count,
  required IconData icon,
  required Color color,
}) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            color.withOpacity(0.05),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background decoration
          Positioned(
            right: 0,
            top: 0,
            child: Opacity(
              opacity: 0.1,
              child: Icon(
                icon,
                size: 80.sp,
                color: color,
              ),
            ),
          ),
          // Main content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon and badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 32.sp,
                      color: color,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              // Title and count
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextstyle(
                    text: title,
                    style: appStyle(
                      size: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  AppTextstyle(
                    text: count,
                    style: appStyle(
                      size: 28.sp,
                      fontWeight: FontWeight.w800,
                      color: color,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
