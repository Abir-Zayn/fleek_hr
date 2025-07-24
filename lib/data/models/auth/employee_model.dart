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
  final String? password;
  final String? weekend_day;
  final DateTime? shiftStartAt;
  final int? workingHours;
  final DateTime? dateOfBirth;
  final bool? active;
  final String? accountNumber;
  final String? branchAddress;
  final String? nationalId;
  final String? workShift;
  final String? tinNumber;
  final String? address;
  final String? emergencyContact;
  final String? gender;
  final String? maritalStatus;
  final String? bloodGroup;
  final String? bankName;

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
    this.password,
    this.weekend_day,
    this.shiftStartAt,
    this.workingHours,
    this.dateOfBirth,
    this.active,
    this.accountNumber,
    this.branchAddress,
    this.nationalId,
    this.workShift,
    this.tinNumber,
    this.address,
    this.emergencyContact,
    this.gender,
    this.maritalStatus,
    this.bloodGroup,
    this.bankName,
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
      password: json['password'] as String?,
      weekend_day: json['weekend_day'] as String?,
      shiftStartAt: json['shift_start_at'] != null
          ? DateTime.parse('1970-01-01 ${json['shift_start_at']}')
          : null,
      workingHours: json['working_hours'] as int?,
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'])
          : null,
      active: json['active'] as bool?,
      accountNumber: json['account_number'] as String?,
      branchAddress: json['branch_address'] as String?,
      nationalId: json['national_id'] as String?,
      workShift: json['work_shift'] as String?,
      tinNumber: json['tin_number'] as String?,
      address: json['address'] as String?,
      emergencyContact: json['emergency_contact'] as String?,
      gender: json['gender'] as String?,
      maritalStatus: json['marital_status'] as String?,
      bloodGroup: json['blood_group'] as String?,
      bankName: json['bank_name'] as String?,
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
      'joining_date': joiningDate?.toIso8601String().split('T')[0],
      'current_salary': currentSalary,
      'designation': designation,
      'skills_1': skills1,
      'skills_2': skills2,
      'skills_3': skills3,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'role': role,
      'password': password,
      'weekend_day': weekend_day,
      'shift_start_at': shiftStartAt != null
          ? '${shiftStartAt!.hour.toString().padLeft(2, '0')}:${shiftStartAt!.minute.toString().padLeft(2, '0')}:${shiftStartAt!.second.toString().padLeft(2, '0')}'
          : null,
      'working_hours': workingHours,
      'date_of_birth': dateOfBirth?.toIso8601String().split('T')[0],
      'active': active,
      'account_number': accountNumber,
      'branch_address': branchAddress,
      'national_id': nationalId,
      'work_shift': workShift,
      'tin_number': tinNumber,
      'address': address,
      'emergency_contact': emergencyContact,
      'gender': gender,
      'marital_status': maritalStatus,
      'blood_group': bloodGroup,
      'bank_name': bankName,
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
      password: password ?? '',
      weekend_day: weekend_day ?? '',
      shiftStartAt: shiftStartAt,
      workingHours: workingHours ?? 0,
      dateOfBirth: dateOfBirth,
      active: active ?? true,
      accountNumber: accountNumber ?? '',
      branchAddress: branchAddress ?? '',
      nationalId: nationalId ?? '',
      workShift: workShift ?? '',
      tinNumber: tinNumber ?? '',
      address: address ?? '',
      emergencyContact: emergencyContact ?? '',
      gender: gender ?? '',
      maritalStatus: maritalStatus ?? '',
      bloodGroup: bloodGroup ?? '',
      bankName: bankName ?? '',
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
      password: entity.password,
      weekend_day: entity.weekend_day,
      shiftStartAt: entity.shiftStartAt,
      workingHours: entity.workingHours,
      dateOfBirth: entity.dateOfBirth,
      active: entity.active,
      accountNumber: entity.accountNumber,
      branchAddress: entity.branchAddress,
      nationalId: entity.nationalId,
      workShift: entity.workShift,
      tinNumber: entity.tinNumber,
      address: entity.address,
      emergencyContact: entity.emergencyContact,
      gender: entity.gender,
      maritalStatus: entity.maritalStatus,
      bloodGroup: entity.bloodGroup,
      bankName: entity.bankName,
    );
  }
}