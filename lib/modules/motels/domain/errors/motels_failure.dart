import '../../../../core/errors/errors.dart';

class GetFailureMotels extends Failure {
  final dynamic exception;
  final StackTrace? stackTrace;
  final String? label;

  GetFailureMotels({
    this.label,
    this.exception,
    this.stackTrace,
    super.errorMessage = 'GetFailureMotels',
  }) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
        );
}
