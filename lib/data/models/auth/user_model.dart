import 'package:fleekhr/domain/entities/auth/user_entity.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? role;

  UserModel({
    this.id,
    this.name,
    this.role,
  });

  // Create model from JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      role: json['role'] as String?,
    );
  }

  // Convert model to JSON map
  Map<String, dynamic> toJson() {
    return {
      'userId': id,
      'name': name,
      'role': role,
    };
  }

  // Convert model to entity
  UserEntity toEntity() {
    return UserEntity(
      id: id ?? '',
      name: name ?? '',
      role: role ?? '',
    );
  }

  // Create model from entity
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      role: entity.role,
    );
  }
}
