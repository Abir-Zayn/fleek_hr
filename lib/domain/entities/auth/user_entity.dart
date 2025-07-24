class EmployeeEntity {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String department;
  final DateTime? joiningDate;
  final int currentSalary;
  final String designation;
  final String skills1;
  final String skills2;
  final String skills3;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String role;
  final String password;
  final String weekend_day;
  final DateTime? shiftStartAt;
  final int workingHours;
  final DateTime? dateOfBirth;
  final bool active;
  final String accountNumber;
  final String branchAddress;
  final String nationalId;
  final String workShift;
  final String tinNumber;
  final String address;
  final String emergencyContact;
  final String gender;
  final String maritalStatus;
  final String bloodGroup;
  final String bankName;

  EmployeeEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.department,
    this.joiningDate,
    required this.currentSalary,
    required this.designation,
    required this.skills1,
    required this.skills2,
    required this.skills3,
    this.createdAt,
    this.updatedAt,
    required this.role,
    required this.password,
    required this.weekend_day,
    this.shiftStartAt,
    required this.workingHours,
    this.dateOfBirth,
    required this.active,
    required this.accountNumber,
    required this.branchAddress,
    required this.nationalId,
    required this.workShift,
    required this.tinNumber,
    required this.address,
    required this.emergencyContact,
    required this.gender,
    required this.maritalStatus,
    required this.bloodGroup,
    required this.bankName,
  });

  // CopyWith method for creating modified copies
  EmployeeEntity copyWith({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? department,
    DateTime? joiningDate,
    int? currentSalary,
    String? designation,
    String? skills1,
    String? skills2,
    String? skills3,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? role,
    String? password,
    String? weekend_day,
    DateTime? shiftStartAt,
    int? workingHours,
    DateTime? dateOfBirth,
    bool? active,
    String? accountNumber,
    String? branchAddress,
    String? nationalId,
    String? workShift,
    String? tinNumber,
    String? address,
    String? emergencyContact,
    String? gender,
    String? maritalStatus,
    String? bloodGroup,
    String? bankName,
  }) {
    return EmployeeEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      department: department ?? this.department,
      joiningDate: joiningDate ?? this.joiningDate,
      currentSalary: currentSalary ?? this.currentSalary,
      designation: designation ?? this.designation,
      skills1: skills1 ?? this.skills1,
      skills2: skills2 ?? this.skills2,
      skills3: skills3 ?? this.skills3,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      role: role ?? this.role,
      password: password ?? this.password,
      weekend_day: weekend_day ?? this.weekend_day,
      shiftStartAt: shiftStartAt ?? this.shiftStartAt,
      workingHours: workingHours ?? this.workingHours,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      active: active ?? this.active,
      accountNumber: accountNumber ?? this.accountNumber,
      branchAddress: branchAddress ?? this.branchAddress,
      nationalId: nationalId ?? this.nationalId,
      workShift: workShift ?? this.workShift,
      tinNumber: tinNumber ?? this.tinNumber,
      address: address ?? this.address,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      gender: gender ?? this.gender,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      bankName: bankName ?? this.bankName,
    );
  }

  // Equality operator
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          name == other.name &&
          phone == other.phone &&
          department == other.department &&
          joiningDate == other.joiningDate &&
          currentSalary == other.currentSalary &&
          designation == other.designation &&
          skills1 == other.skills1 &&
          skills2 == other.skills2 &&
          skills3 == other.skills3 &&
          role == other.role &&
          password == other.password &&
          weekend_day == other.weekend_day &&
          shiftStartAt == other.shiftStartAt &&
          workingHours == other.workingHours &&
          dateOfBirth == other.dateOfBirth &&
          active == other.active &&
          accountNumber == other.accountNumber &&
          branchAddress == other.branchAddress &&
          nationalId == other.nationalId &&
          workShift == other.workShift &&
          tinNumber == other.tinNumber &&
          address == other.address &&
          emergencyContact == other.emergencyContact &&
          gender == other.gender &&
          maritalStatus == other.maritalStatus &&
          bloodGroup == other.bloodGroup &&
          bankName == other.bankName;

  @override
  int get hashCode =>
      id.hashCode ^
      email.hashCode ^
      name.hashCode ^
      phone.hashCode ^
      department.hashCode ^
      joiningDate.hashCode ^
      currentSalary.hashCode ^
      designation.hashCode ^
      skills1.hashCode ^
      skills2.hashCode ^
      skills3.hashCode ^
      role.hashCode ^
      password.hashCode ^
      weekend_day.hashCode ^
      shiftStartAt.hashCode ^
      workingHours.hashCode ^
      dateOfBirth.hashCode ^
      active.hashCode ^
      accountNumber.hashCode ^
      branchAddress.hashCode ^
      nationalId.hashCode ^
      workShift.hashCode ^
      tinNumber.hashCode ^
      address.hashCode ^
      emergencyContact.hashCode ^
      gender.hashCode ^
      maritalStatus.hashCode ^
      bloodGroup.hashCode ^
      bankName.hashCode;
}
