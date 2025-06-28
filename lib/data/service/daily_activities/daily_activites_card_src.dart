import 'package:fleekhr/data/models/daily_activities/daily_activities_card_model.dart';

class DailyActivitesCardSrc {
  static List<DailyActivitiesCardModel> get dailyActivitiesDemoData => [
        DailyActivitiesCardModel(
            taskTitle: 'Daily Standup Meeting',
            id: '1',
            date: DateTime(2023, 10, 1),
            department: 'Engineering',
            company: 'TechCorp',
            startTime: DateTime.parse('2023-10-01 09:00:00'),
            endTime: DateTime.parse('2023-10-01 17:00:00'),
            status: 'Completed',
            employeeId: '12345',
            employeeName: 'John Doe',
            workType: 'NEW',
            statisfaction: 'YES',
            feedback: 'Great progress on the project',
            quantity: 5),
        DailyActivitiesCardModel(
          taskTitle: 'Follow-up Calls to New Leads',
          id: '3',
          date: DateTime(2025, 6, 25),
          department: 'Sales',
          company: 'Solutions Inc.',
          startTime: DateTime.parse('2025-06-25 09:15:00'),
          endTime: DateTime.parse(
              '2025-06-25 17:00:00'), // End time represents end of work day
          status: 'In Progress',
          employeeId: 'S-5432',
          employeeName: 'Bob Williams',
          workType: 'NEW',
          statisfaction: 'N/A', // Not applicable yet
          feedback: 'Contacted 8 out of 15 leads so far.',
          quantity: 8,
        ),
        // Example 3: Pending HR task
        DailyActivitiesCardModel(
          taskTitle: 'Prepare Onboarding Documents',
          id: '4',
          date: DateTime(2025, 6, 26), // Scheduled for tomorrow
          department: 'Human Resources',
          company: 'InnovateX',
          startTime: DateTime.parse('2025-06-26 09:00:00'),
          endTime: DateTime.parse('2025-06-26 11:00:00'),
          status: 'Pending',
          employeeId: 'H-1122',
          employeeName: 'Carol White',
          workType: 'NEW',
          statisfaction: 'N/A',
          feedback: '',
          quantity: 1,
        ),
        DailyActivitiesCardModel(
          taskTitle: 'Fix Bugs on Main Dashboard',
          id: '5',
          date: DateTime(2025, 6, 24), // From yesterday
          department: 'Engineering',
          company: 'DataWeavers',
          startTime: DateTime.parse('2025-06-24 14:00:00'),
          endTime: DateTime.parse('2025-06-24 18:00:00'),
          status: 'Completed',
          employeeId: 'E-4567',
          employeeName: 'Frank Miller',
          workType: 'REWORK',
          statisfaction: 'NO',
          feedback:
              'The main bug is fixed, but two new minor styling issues appeared.',
          quantity: 3, // 3 bugs addressed
        ),
        // Example 5: Marketing task
        DailyActivitiesCardModel(
          taskTitle: 'Draft Social Media Posts ',
          id: '6',
          date: DateTime(2025, 6, 25),
          department: 'Marketing',
          company: 'Solutions Inc.',
          startTime: DateTime.parse('2025-06-25 13:00:00'),
          endTime: DateTime.parse('2025-06-25 16:45:00'),
          status: 'Completed',
          employeeId: 'M-3344',
          employeeName: 'Grace Lee',
          workType: 'NEW',
          statisfaction: 'YES',
          feedback: 'Creative and engaging content. Approved for posting.',
          quantity: 5, // 5 posts drafted
        ),
        // Example 6: Support task
        DailyActivitiesCardModel(
          taskTitle: 'Resolve High-Priority Task',
          id: '7',
          date: DateTime(2025, 6, 25),
          department: 'Customer Support',
          company: 'DataWeavers',
          startTime: DateTime.parse('2025-06-25 11:30:00'),
          endTime: DateTime.parse('2025-06-25 12:15:00'),
          status: 'Completed',
          employeeId: 'C-8899',
          employeeName: 'Henry Brown',
          workType: 'NEW',
          statisfaction: 'YES',
          feedback: 'Customer was very happy with the quick resolution.',
          quantity: 1,
        ),
      ];
}
