part of 'manage_employee_imports.dart';

class ManageEmployee extends StatelessWidget {
  const ManageEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FleekAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: 'Manage Employees',
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      /**
       *  requisite:
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
              //Add employee button
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Icon(Icons.edit, color: Colors.white),
                  ),
                  title: Text(
                    'Onboard Employee',
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    context.push('/add-employee');
                  },
                ),
              ),
              SizedBox(height: 12.h),
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
                  DashboardManageEmployeeCard(
                    title: 'Total Employees',
                    count: '156',
                    icon: Icons.people,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 12),
                  DashboardManageEmployeeCard(
                    title: 'Active Employees',
                    count: '142',
                    icon: Icons.check_circle,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 12),
                  DashboardManageEmployeeCard(
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

              //Employee Card list
              Expanded(
                child: ListView(
                  children: [
                    EmployeeCard(
                      name: 'John Doe',
                      email: 'john.doe@fleekhr.com',
                      role: 'Senior Developer',
                      shift: 'Morning',
                      lastLogin: '2 hours ago',
                      status: 'Active',
                      dutyHours: '8h/day',
                      avatarUrl:
                          'https://randomuser.me/api/portraits/men/32.jpg',
                    ),
                    const SizedBox(height: 12),
                    EmployeeCard(
                      name: 'Kashem Shikdar',
                      email: 'kashem.213e@fleekhr.com',
                      role: 'Intern',
                      shift: 'Morning',
                      lastLogin: '2 hours ago',
                      status: 'Pending',
                      dutyHours: '6h/day',
                      avatarUrl: 'https://randomuser.me/api/portraits',
                    ),
                    const SizedBox(height: 12),
                    EmployeeCard(
                      name: 'Kashem Shikdar',
                      email: 'kashem.213e@fleekhr.com',
                      role: 'Intern',
                      shift: 'Morning',
                      lastLogin: '2 hours ago',
                      status: 'Exterminated',
                      dutyHours: '6h/day',
                      avatarUrl:
                          'https://images.unsplash.com/photo-1747599309107-20504ba6b8dd?q=80&w=2076&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
