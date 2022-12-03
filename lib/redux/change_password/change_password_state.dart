import 'package:equatable/equatable.dart';

import '../../models/custom_error.dart';

enum ChangePasswordStatus {
  initial,
  submitting,
  success,
  failure,
}

class ChangePasswordState extends Equatable {
  final ChangePasswordStatus changePasswordStatus;
  final CustomError error;
  const ChangePasswordState({
    required this.changePasswordStatus,
    required this.error,
  });

  factory ChangePasswordState.initial() {
    return const ChangePasswordState(
      changePasswordStatus: ChangePasswordStatus.initial,
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [changePasswordStatus, error];

  @override
  String toString() =>
      'ChangePasswordState(changePasswordStatus: $changePasswordStatus, error: $error)';

  ChangePasswordState copyWith({
    ChangePasswordStatus? changePasswordStatus,
    CustomError? error,
  }) {
    return ChangePasswordState(
      changePasswordStatus: changePasswordStatus ?? this.changePasswordStatus,
      error: error ?? this.error,
    );
  }
}
