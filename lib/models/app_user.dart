import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String id;
  final String name;
  final String email;
  const AppUser({
    this.id = '',
    this.name = '',
    this.email = '',
  });

  factory AppUser.fromDoc(DocumentSnapshot appUserDoc) {
    final appUserData = appUserDoc.data() as Map<String, dynamic>?;

    return AppUser(
      id: appUserDoc.id,
      name: appUserData!['name'],
      email: appUserData['email'],
    );
  }

  @override
  List<Object> get props => [id, name, email];

  @override
  String toString() => 'AppUser(id: $id, name: $name, email: $email)';

  AppUser copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
