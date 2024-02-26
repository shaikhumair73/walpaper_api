class AppException implements Exception {
  String? body;
  String? title;
  AppException({required this.title, required this.body});
  String toErrorMsg() {
    return "$title : $body";
  }
}

class FetchDataException extends AppException {
  FetchDataException({required String body})
      : super(title: "Error during communication", body: body);
}

class BadRequestException extends AppException {
  BadRequestException({required String body})
      : super(title: "Invalid request", body: body);
}

class UnauthorisedException extends AppException {
  UnauthorisedException({required String body})
      : super(title: "unauthorised", body: body);
}

class InvalidInputException extends AppException {
  InvalidInputException({required String body})
      : super(title: "Invalid input", body: body);
}
