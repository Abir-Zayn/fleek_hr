import 'package:fleekhr/domain/entities/auth/user_entity.dart';

class EmployeeModel {
  final String? id;
  final String? email;
  final String? name;
  final String? phone;
  final String? department;
  final DateTime? joiningDate;
  final int? currentSalary;
  final String? designation;
  final String? skills1;
  final String? skills2;
  final String? skills3;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? role;

  EmployeeModel({
    this.id,
    this.email,
    this.name,
    this.phone,
    this.department,
    this.joiningDate,
    this.currentSalary,
    this.designation,
    this.skills1,
    this.skills2,
    this.skills3,
    this.createdAt,
    this.updatedAt,
    this.role,
  });

  // Create model from JSON map
  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      department: json['department'] as String?,
      joiningDate: json['joining_date'] != null
          ? DateTime.parse(json['joining_date'])
          : null,
      currentSalary: json['current_salary'] as int?,
      designation: json['designation'] as String?,
      skills1: json['skills_1'] as String?,
      skills2: json['skills_2'] as String?,
      skills3: json['skills_3'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      role: json['role'] as String?,
    );
  }

  // Convert model to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'department': department,
      'joining_date': joiningDate?.toIso8601String(),
      'current_salary': currentSalary,
      'designation': designation,
      'skills_1': skills1,
      'skills_2': skills2,
      'skills_3': skills3,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'role': role,
    };
  }

  // Convert model to entity
  EmployeeEntity toEntity() {
    return EmployeeEntity(
      id: id ?? '',
      email: email ?? '',
      name: name ?? '',
      phone: phone ?? '',
      department: department ?? '',
      joiningDate: joiningDate,
      currentSalary: currentSalary ?? 0,
      designation: designation ?? '',
      skills1: skills1 ?? '',
      skills2: skills2 ?? '',
      skills3: skills3 ?? '',
      createdAt: createdAt,
      updatedAt: updatedAt,
      role: role ?? '',
    );
  }

  // Create model from entity
  factory EmployeeModel.fromEntity(EmployeeEntity entity) {
    return EmployeeModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      phone: entity.phone,
      department: entity.department,
      joiningDate: entity.joiningDate,
      currentSalary: entity.currentSalary,
      designation: entity.designation,
      skills1: entity.skills1,
      skills2: entity.skills2,
      skills3: entity.skills3,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      role: entity.role,
    );
  }
}
