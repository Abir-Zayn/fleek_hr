part of 'manage_employee_imports.dart';

class ManageEmployee extends StatefulWidget {
  const ManageEmployee({super.key});

  @override
  State<ManageEmployee> createState() => _ManageEmployeeState();
}

class _ManageEmployeeState extends State<ManageEmployee> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  final List<String> _filterOptions = ['All', 'Active', 'Inactive', 'On Leave'];

  // Sample data - replace with actual data from your backend
  final List<Map<String, dynamic>> _employees = [
    {
      'id': '001',
      'name': 'John Doe',
      'email': 'john.doe@company.com',
      'role': 'Software Engineer',
      'shift': 'Day Shift',
      'lastLogin': '2025-01-18 09:30 AM',
      'status': 'Active',
      'dutyHours': '8 hrs',
      'phone': '+1234567890',
      'salary': '\$75,000',
      'designation': 'Senior Developer',
    },
    {
      'id': '002',
      'name': 'Jane Smith',
      'email': 'jane.smith@company.com',
      'role': 'HR Manager',
      'shift': 'Day Shift',
      'lastLogin': '2025-01-18 08:45 AM',
      'status': 'Active',
      'dutyHours': '8 hrs',
      'phone': '+1234567891',
      'salary': '\$65,000',
      'designation': 'HR Specialist',
    },
    {
      'id': '003',
      'name': 'Mike Johnson',
      'email': 'mike.johnson@company.com',
      'role': 'Designer',
      'shift': 'Night Shift',
      'lastLogin': '2025-01-17 11:30 PM',
      'status': 'Inactive',
      'dutyHours': '8 hrs',
      'phone': '+1234567892',
      'salary': '\$60,000',
      'designation': 'UI/UX Designer',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: FleekAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: 'Admin Dashboard',
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: PageBackground(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dashboard Stats Cards
                _buildDashboardStats(),
                const SizedBox(height: 24),

                // Quick Actions
                _buildQuickActions(),
                const SizedBox(height: 24),

                // Employee Management Section
                _buildEmployeeManagementSection(),
                const SizedBox(height: 16),

                // Search and Filter
                _buildSearchAndFilter(),
                const SizedBox(height: 16),

                // Employee List
                _buildEmployeeList(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push('/add-employee');
        },
        backgroundColor: Theme.of(context).primaryColor,
        icon: const Icon(Icons.person_add, color: Colors.white),
        label: AppTextstyle(
          text: 'Add Employee',
          style: appStyle(
            size: 14,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextstyle(
          text: 'Overview',
          style: appStyle(
            size: 20,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Total Employees',
                '156',
                Icons.people,
                Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                'Active Today',
                '142',
                Icons.check_circle,
                Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'On Leave',
                '8',
                Icons.event_busy,
                Colors.orange,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                'New This Month',
                '12',
                Icons.trending_up,
                Colors.purple,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AppTextstyle(
            text: value,
            style: appStyle(
              size: 24,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          AppTextstyle(
            text: title,
            style: appStyle(
              size: 14,
              color: Colors.grey[600]!,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextstyle(
          text: 'Quick Actions',
          style: appStyle(
            size: 20,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildActionCard(
                'Attendance',
                Icons.access_time,
                Colors.blue,
                () {
                  // Navigate to attendance screen
                },
              ),
              _buildActionCard(
                'Salary Overview',
                Icons.account_balance_wallet,
                Colors.green,
                () {
                  // Navigate to salary screen
                },
              ),
              _buildActionCard(
                'Notice',
                Icons.campaign,
                Colors.orange,
                () {
                  _showAnnouncementDialog();
                },
              ),
              _buildActionCard(
                'Reports',
                Icons.analytics,
                Colors.purple,
                () {
                  // Navigate to reports screen
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard(
      String title, IconData icon, Color color, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 120,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 12),
              AppTextstyle(
                text: title,
                style: appStyle(
                  size: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmployeeManagementSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTextstyle(
          text: 'Employee Management',
          style: appStyle(
            size: 20,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () {
            // Show more options
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextstyle(
                  text: 'View All',
                  style: appStyle(
                    size: 14,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilter() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search employees...',
                hintStyle: appStyle(
                  size: 14,
                  color: Colors.grey[500]!,
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedFilter,
              icon: Icon(Icons.filter_list, color: Colors.grey[600]),
              items: _filterOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: AppTextstyle(
                    text: value,
                    style: appStyle(
                      size: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedFilter = newValue!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmployeeList() {
    List<Map<String, dynamic>> filteredEmployees = _employees.where((employee) {
      bool matchesSearch = _searchController.text.isEmpty ||
          employee['name']
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()) ||
          employee['email']
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()) ||
          employee['role']
              .toLowerCase()
              .contains(_searchController.text.toLowerCase());

      bool matchesFilter =
          _selectedFilter == 'All' || employee['status'] == _selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredEmployees.length,
      itemBuilder: (context, index) {
        final employee = filteredEmployees[index];
        return _buildEmployeeCard(employee);
      },
    );
  }

  Widget _buildEmployeeCard(Map<String, dynamic> employee) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          child: AppTextstyle(
            text: employee['name'].substring(0, 2).toUpperCase(),
            style: appStyle(
              size: 16,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: AppTextstyle(
          text: employee['name'],
          style: appStyle(
            size: 16,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            AppTextstyle(
              text: employee['email'],
              style: appStyle(
                size: 14,
                color: Colors.grey[600]!,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                AppTextstyle(
                  text: employee['role'],
                  style: appStyle(
                    size: 12,
                    color: Colors.grey[600]!,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: employee['status'] == 'Active'
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: AppTextstyle(
                    text: employee['status'],
                    style: appStyle(
                      size: 10,
                      color: employee['status'] == 'Active'
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: Colors.grey[600]),
          onSelected: (String value) {
            switch (value) {
              case 'view':
                _showEmployeeDetails(employee);
                break;
              case 'edit':
                context.push('/edit-employee/${employee['id']}');
                break;
              case 'attendance':
                _showAttendanceDetails(employee);
                break;
              case 'salary':
                _showSalaryDetails(employee);
                break;
              case 'toggle_status':
                _toggleEmployeeStatus(employee);
                break;
            }
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem<String>(
              value: 'view',
              child: Row(
                children: [
                  Icon(Icons.visibility, size: 18),
                  SizedBox(width: 8),
                  Text('View Details'),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, size: 18),
                  SizedBox(width: 8),
                  Text('Edit'),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'attendance',
              child: Row(
                children: [
                  Icon(Icons.access_time, size: 18),
                  SizedBox(width: 8),
                  Text('Attendance'),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'salary',
              child: Row(
                children: [
                  Icon(Icons.attach_money, size: 18),
                  SizedBox(width: 8),
                  Text('Salary'),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'toggle_status',
              child: Row(
                children: [
                  Icon(Icons.toggle_on, size: 18),
                  SizedBox(width: 8),
                  Text('Toggle Status'),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          _showEmployeeDetails(employee);
        },
      ),
    );
  }

  void _showEmployeeDetails(Map<String, dynamic> employee) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Employee Header
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor:
                                Theme.of(context).primaryColor.withOpacity(0.1),
                            child: AppTextstyle(
                              text: employee['name']
                                  .substring(0, 2)
                                  .toUpperCase(),
                              style: appStyle(
                                size: 20,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTextstyle(
                                  text: employee['name'],
                                  style: appStyle(
                                    size: 20,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                AppTextstyle(
                                  text: employee['designation'],
                                  style: appStyle(
                                    size: 16,
                                    color: Colors.grey[600]!,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: employee['status'] == 'Active'
                                  ? Colors.green.withOpacity(0.1)
                                  : Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: AppTextstyle(
                              text: employee['status'],
                              style: appStyle(
                                size: 12,
                                color: employee['status'] == 'Active'
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Employee Details
                      _buildDetailItem('Email', employee['email'], Icons.email),
                      _buildDetailItem(
                          'Phone Number', employee['phone'], Icons.phone),
                      _buildDetailItem('Role', employee['role'], Icons.work),
                      _buildDetailItem(
                          'Shift', employee['shift'], Icons.schedule),
                      _buildDetailItem('Current Salary', employee['salary'],
                          Icons.attach_money),
                      _buildDetailItem('Duty Hours', employee['dutyHours'],
                          Icons.access_time),
                      _buildDetailItem(
                          'Last Login', employee['lastLogin'], Icons.login),

                      const SizedBox(height: 24),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                                context
                                    .push('/edit-employee/${employee['id']}');
                              },
                              icon: const Icon(Icons.edit, size: 18),
                              label: AppTextstyle(
                                text: 'Edit Details',
                                style: appStyle(
                                  size: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                                _showAttendanceDetails(employee);
                              },
                              icon: const Icon(Icons.access_time, size: 18),
                              label: AppTextstyle(
                                text: 'Attendance',
                                style: appStyle(
                                  size: 14,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Theme.of(context).primaryColor,
                                side: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextstyle(
                  text: label,
                  style: appStyle(
                    size: 12,
                    color: Colors.grey[600]!,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                AppTextstyle(
                  text: value,
                  style: appStyle(
                    size: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAttendanceDetails(Map<String, dynamic> employee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: AppTextstyle(
          text: 'Attendance Summary',
          style: appStyle(
            size: 18,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextstyle(
              text: 'Employee: ${employee['name']}',
              style: appStyle(
                size: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            _buildAttendanceItem('Check-in Time', '09:00 AM'),
            _buildAttendanceItem('Check-out Time', '06:00 PM'),
            _buildAttendanceItem('Total Hours', '9 hours'),
            _buildAttendanceItem('Days Present', '22/25'),
            _buildAttendanceItem('Attendance Rate', '88%'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: AppTextstyle(
              text: 'Close',
              style: appStyle(
                size: 14,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTextstyle(
            text: label,
            style: appStyle(
              size: 14,
              color: Colors.grey[600]!,
              fontWeight: FontWeight.w500,
            ),
          ),
          AppTextstyle(
            text: value,
            style: appStyle(
              size: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showSalaryDetails(Map<String, dynamic> employee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: AppTextstyle(
          text: 'Salary Overview',
          style: appStyle(
            size: 18,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextstyle(
              text: 'Employee: ${employee['name']}',
              style: appStyle(
                size: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            _buildAttendanceItem('Base Salary', employee['salary']),
            _buildAttendanceItem('Bonus', '\$5,000'),
            _buildAttendanceItem('Deductions', '\$2,000'),
            _buildAttendanceItem('Net Salary', '\$78,000'),
            _buildAttendanceItem('Last Generated', 'Jan 2025'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: AppTextstyle(
              text: 'Close',
              style: appStyle(
                size: 14,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Generate salary logic
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: AppTextstyle(
                    text: 'Salary generated for ${employee['name']}',
                    style: appStyle(
                      size: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            child: AppTextstyle(
              text: 'Generate',
              style: appStyle(
                size: 14,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleEmployeeStatus(Map<String, dynamic> employee) {
    setState(() {
      employee['status'] =
          employee['status'] == 'Active' ? 'Inactive' : 'Active';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AppTextstyle(
          text: '${employee['name']} status updated to ${employee['status']}',
          style: appStyle(
            size: 14,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor:
            employee['status'] == 'Active' ? Colors.green : Colors.orange,
      ),
    );
  }

  void _showAnnouncementDialog() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController messageController = TextEditingController();
    String selectedType = 'General';
    final List<String> announcementTypes = [
      'General',
      'Meeting',
      'Notice',
      'Event',
      'Urgent'
    ];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title: AppTextstyle(
            text: 'Create Announcement',
            style: appStyle(
              size: 18,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Announcement Type
                AppTextstyle(
                  text: 'Type',
                  style: appStyle(
                    size: 14,
                    color: Colors.grey[700]!,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedType,
                      isExpanded: true,
                      items: announcementTypes.map((String type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: AppTextstyle(
                            text: type,
                            style: appStyle(
                              size: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setStateDialog(() {
                          selectedType = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Title
                AppTextstyle(
                  text: 'Title',
                  style: appStyle(
                    size: 14,
                    color: Colors.grey[700]!,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Enter announcement title',
                    hintStyle: appStyle(
                      size: 14,
                      color: Colors.grey[500]!,
                      fontWeight: FontWeight.w400,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Message
                AppTextstyle(
                  text: 'Message',
                  style: appStyle(
                    size: 14,
                    color: Colors.grey[700]!,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: messageController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Enter announcement message',
                    hintStyle: appStyle(
                      size: 14,
                      color: Colors.grey[500]!,
                      fontWeight: FontWeight.w400,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                titleController.dispose();
                messageController.dispose();
                Navigator.pop(context);
              },
              child: AppTextstyle(
                text: 'Cancel',
                style: appStyle(
                  size: 14,
                  color: Colors.grey[600]!,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    messageController.text.isNotEmpty) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: AppTextstyle(
                        text:
                            '$selectedType announcement "${titleController.text}" has been sent to all employees',
                        style: appStyle(
                          size: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      backgroundColor: Colors.blue,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: AppTextstyle(
                        text: 'Please fill in all fields',
                        style: appStyle(
                          size: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                titleController.dispose();
                messageController.dispose();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              child: AppTextstyle(
                text: 'Send',
                style: appStyle(
                  size: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
