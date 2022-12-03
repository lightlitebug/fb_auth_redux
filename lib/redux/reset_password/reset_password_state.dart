import 'package:equatable/equatable.dart';

import '../../models/custom_error.dart';

enum ResetPasswordStatus {
  initial,
  submitting,
  success,
  failure,
}

class ResetPasswordState extends Equatable {
  final ResetPasswordStatus resetPasswordStatus;
  final CustomError error;
  const ResetPasswordState({
    required this.resetPasswordStatus,
    required this.error,
  });

  factory ResetPasswordState.initial() {
    return const ResetPasswordState(
      resetPasswordStatus: ResetPasswordStatus.initial,
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [resetPasswordStatus, error];

  @override
  String toString() =>
      'ResetPasswordState(ResetPasswordStatus: $resetPasswordStatus, error: $error)';

  ResetPasswordState copyWith({
    ResetPasswordStatus? resetPasswordStatus,
    CustomError? error,
  }) {
    return ResetPasswordState(
      resetPasswordStatus: resetPasswordStatus ?? this.resetPasswordStatus,
      error: error ?? this.error,
    );
  }
}
