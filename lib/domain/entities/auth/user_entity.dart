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
  });

  // Convenience method to create a copy with modified fields
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
    );
  }

  // Equality methods
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
          role == other.role;

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
      role.hashCode;
}
