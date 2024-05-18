import 'failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    Failure(statusCode: error?.response?.data['status_code']??0, statusMessage: error?.response?.data['status_message']??'');
  }
}
