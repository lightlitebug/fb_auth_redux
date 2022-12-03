import 'package:equatable/equatable.dart';

import '../../models/app_user.dart';
import '../../models/custom_error.dart';

enum ProfileStatus {
  initial,
  submitting,
  success,
  failure,
}

class ProfileState extends Equatable {
  final ProfileStatus profileStatus;
  final AppUser appUser;
  final CustomError error;
  const ProfileState({
    required this.profileStatus,
    required this.appUser,
    required this.error,
  });

  factory ProfileState.initial() {
    return const ProfileState(
      profileStatus: ProfileStatus.initial,
      appUser: AppUser(),
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [profileStatus, appUser, error];

  @override
  String toString() =>
      'ProfileState(profileStatus: $profileStatus, appUser: $appUser, error: $error)';

  ProfileState copyWith({
    ProfileStatus? profileStatus,
    AppUser? appUser,
    CustomError? error,
  }) {
    return ProfileState(
      profileStatus: profileStatus ?? this.profileStatus,
      appUser: appUser ?? this.appUser,
      error: error ?? this.error,
    );
  }
}
