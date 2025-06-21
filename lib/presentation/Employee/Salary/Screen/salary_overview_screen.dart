part of 'salary_overview_imports.dart';

class SalaryOverviewScreen extends StatefulWidget {
  const SalaryOverviewScreen({super.key});

  @override
  State<SalaryOverviewScreen> createState() => _SalaryOverviewScreenState();
}

class _SalaryOverviewScreenState extends State<SalaryOverviewScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FleekAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: "Salary Overview",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            // Placeholder for salary overview content
            AppTextstyle(
              text: "Hello Employee!",
              style: appStyle(
                size: 25.sp,
                color: Theme.of(context).textTheme.bodyMedium?.color ??
                    Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            AppTextstyle(
              text: "Email Account :   employermail@gmail.com",
              style: appStyle(
                size: 16.sp,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            AppTextstyle(
              text: "Phone Number:  +880 1293321234",
              style: appStyle(
                size: 16.sp,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: 40.h),
            AppTextstyle(
              text: "Salary Overview",
              style: appStyle(
                size: 20.sp,
                color: Theme.of(context).textTheme.bodyMedium?.color ??
                    Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),

            // Salary Card example from April to June
            SalaryCard(
              month: "04/2025",
              basic: 2000.00,
              grossPay: 2500.00,
              totalLeave: 2,
              netPay: 2300.00,
              onTap: () {
                context.push('/salary-details');
              },
            ),
            SizedBox(height: 16.h),
            SalaryCard(
              month: "05/2025",
              basic: 2000.00,
              grossPay: 2500.00,
              totalLeave: 2,
              netPay: 2300.00,
              onTap: () {
                context.push('/salary-details');
              },
            ),
            SizedBox(height: 16.h),
            SalaryCard(
              month: "06/2025",
              basic: 2000.00,
              grossPay: 2500.00,
              totalLeave: 2,
              netPay: 2300.00,
              onTap: () {
                context.push('/salary-details');
              },
            )

            // Add Monthly Slider {From january to December}
            // based on month selected , show the salary card
            // salary card will hold 3 details {Gross Salary, Absent Deduction, Overtime}
            // salary card will navigate user to the salary details screen
          ],
        ),
      ),
    );
  }
}
