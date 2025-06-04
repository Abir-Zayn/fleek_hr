import 'package:fleekhr/data/models/wfh_request/wfh_model.dart';

// Mock data generator for WFH (Work From Home) requests
class WorkFromHomeMockData {
  static final List<WfhModel> mockWfhRequests = [
    WfhModel(
      id: "wfh001",
      startDate: DateTime(2024, 1, 10),
      endDate: DateTime(2024, 1, 12),
      employeeName: "Alice Johnson",
      employeeId: "emp101",
      status: "Approved",
      reason: "Family emergency",
    ),
    WfhModel(
      id: "wfh002",
      startDate: DateTime(2024, 2, 5),
      endDate: DateTime(2024, 2, 6),
      employeeName: "Bob Smith",
      employeeId: "emp102",
      status: "Pending",
      reason: "Internet outage at home",
    ),
    WfhModel(
      id: "wfh003",
      startDate: DateTime(2024, 3, 15),
      endDate: DateTime(2024, 3, 17),
      employeeName: "Charlie Brown",
      employeeId: "emp103",
      status: "Rejected",
      reason: "Project deadline requires onsite work",
    ),
    WfhModel(
      id: "wfh004",
      startDate: DateTime(2024, 4, 20),
      endDate: DateTime(2024, 4, 20),
      employeeName: "Diana Prince",
      employeeId: "emp104",
      status: "Approved",
      reason: "Medical appointment",
    ),
    WfhModel(
      id: "wfh005",
      startDate: DateTime(2024, 5, 1),
      endDate: DateTime(2024, 5, 3),
      employeeName: "Ethan Hunt",
      employeeId: "emp105",
      status: "Pending",
      reason: "Relocating to a new apartment",
    ),
  ];

  // Helper: Fetch mock data (simulate API call)
  static Future<List<WfhModel>> fetchMockWfhData() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate delay
    return mockWfhRequests;
  }

  // Helper: Convert mock data to JSON (for testing APIs)
  static List<Map<String, dynamic>> toJsonList() {
    return mockWfhRequests.map((request) => request.toJson()).toList();
  }
}
