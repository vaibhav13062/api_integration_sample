class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message]) : super(message, "Communication Error");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "UnAuthorised");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message])
      : super(message, "Invalid Input Error");
}

class ForbiddenException extends CustomException {
  ForbiddenException([message]) : super(message, "Forbidden Request");
}
