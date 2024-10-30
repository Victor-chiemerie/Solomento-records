import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  // entity paramenters
  final String id;
  final String email;
  final String name;

  const MyUserEntity({
    required this.id,
    required this.email,
    required this.name,
  });

  /// Converts the user entity to a document to be stored to firebase
  Map<String, Object> toDocument() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }

  /// Converts a document from firebase to a user entity
  static MyUserEntity fromDocument(Map<String, Object> doc) {
    return MyUserEntity(
      id: doc['id'] as String,
      email: doc['email'] as String,
      name: doc['name'] as String,
    );
  }

  @override
  String toString() {
    return '''UserEntity: {
      id: $id
      email: $email
      name: $name
    }''';
  }

  @override
  List<Object?> get props => [id, email, name];
}
