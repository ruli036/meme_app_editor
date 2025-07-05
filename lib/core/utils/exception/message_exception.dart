

sealed class MessageException implements Exception {
  final String type;
  final String message;
  final String? code;

  MessageException(this.type, this.message, [this.code]);

  bool get isNetworkError => type == 'NETWORK_ERROR';
  bool get isIpNotFound => type == 'IP_NOT_FOUND';
  bool get isAccLocked => type == 'ACCOUNT_LOCKED';
  bool get isSocketErr => type == 'SOCKET_ERROR';
  bool get invalidUser => type == 'INVALID_USER';

  static MessageException handleError(dynamic err) {
    if (err is MessageException) {
      return err;
    }
    if (err is NetworkError) {
      return NetworkError();
    }

    if (err is IpNotFoundError) {
      return IpNotFoundError();
    }
    if (err.toString().contains("SocketException")) {
      return SocketError();
    }

    if (err.toString().toLowerCase().contains('locked')) {
      return AccountLocked();
    }
    if (err.toString().toLowerCase().contains('invalid') ||
        err.toString().toLowerCase().contains('unable')) {
      return InvalidUser();
    }
    if (err is String) {
      return GenericError(err);
    }

    return GenericError(err?.toString() ?? 'An unexpected error occurred.');
  }

  static String messageError(MessageErrorType type) {
    switch (type) {
      case MessageErrorType.networkError:
        return "No internet connection. Please check your network.";
      case MessageErrorType.ipNotFound:
        return "IP address not found. Please try again later.";
      case MessageErrorType.accountLocked:
        return "Your account has been locked. Contact support for help.";
      case MessageErrorType.socketError:
        return "Something went wrong. Please try again shortly.";
      case MessageErrorType.invalidUser:
        return "We couldn't verify your account credentials.";
    }
  }

}

class NetworkError extends MessageException {
  NetworkError()
      : super('NETWORK_ERROR',
            MessageException.messageError(MessageErrorType.networkError));
}

class IpNotFoundError extends MessageException {
  IpNotFoundError()
      : super('IP_NOT_FOUND',
            MessageException.messageError(MessageErrorType.ipNotFound));
}

class AccountLocked extends MessageException {
  AccountLocked()
      : super('ACCOUNT_LOCKED',
            MessageException.messageError(MessageErrorType.accountLocked));
}

class SocketError extends MessageException {
  SocketError()
      : super('SOCKET_ERROR',
            MessageException.messageError(MessageErrorType.socketError));
}

class InvalidUser extends MessageException {
  InvalidUser()
      : super('INVALID_USER',
            MessageException.messageError(MessageErrorType.invalidUser));
}

class GenericError extends MessageException {
  GenericError(String message, [MessageErrorType? code])
      : super('GENERIC_ERROR',
            code != null ? MessageException.messageError(code) : message);
}

enum MessageErrorType {
  networkError,
  ipNotFound,
  accountLocked,
  socketError,
  invalidUser,
}
