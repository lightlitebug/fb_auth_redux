import 'package:equatable/equatable.dart';

class CustomError extends Equatable {
  final String code;
  final String message;
  final String plugin;
  const CustomError({
    this.code = '',
    this.message = '',
    this.plugin = '',
  });

  @override
  List<Object> get props => [code, message, plugin];

  @override
  String toString() =>
      'CustomError(code: $code, message: $message, plugin: $plugin)';

  CustomError copyWith({
    String? code,
    String? message,
    String? plugin,
  }) {
    return CustomError(
      code: code ?? this.code,
      message: message ?? this.message,
      plugin: plugin ?? this.plugin,
    );
  }
}
