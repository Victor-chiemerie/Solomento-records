// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/entities.dart';

class MyUser extends Equatable {
  // user paramenters
  final String id;
  final String email;
  final String name;

  const MyUser({
    required this.id,
    required this.email,
    required this.name,
  });

  /// Empty user which represents an unauthenticated user
  static const empty = MyUser(
    id: "",
    email: "",
    name: "",
  );

  /// Modify MyUser parameters
  MyUser copyWith({
    String? id,
    String? email,
    String? name,
  }) {
    return MyUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  /// Convenience getter to determine whether the current user is empty
  bool get isEmpty => this == MyUser.empty;

  /// Convenience getter to determine whether the current user is not empty
  bool get isNotEmpty => this != MyUser.empty;

  MyUserEntity toEntity() {
    return MyUserEntity(
      id: id,
      email: email,
      name: name,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      id: entity.id,
      email: entity.email,
      name: entity.name,
    );
  }

  @override
  List<Object?> get props => [id, email, name];
}
