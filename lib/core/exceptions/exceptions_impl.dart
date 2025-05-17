import '../models/erorr_data.dart';

class ServerError implements Exception {
  ErrorModel? errorModel;

  ServerError(this.errorModel);

  @override
  String toString() {
    return errorModel?.toString() ?? 'Unknown server error';
  }
}


class NetworkError implements Exception {
  String? message;

  NetworkError(this.message);
}

class ClientError implements Exception {
  final ErrorModel? errorModel;

  ClientError({this.errorModel});

  @override
  String toString() {
    return errorModel?.toString() ?? 'Unknown client error';
  }
}



class ServerSideError implements Exception {
  ErrorModel? errorModel;

  ServerSideError(this.errorModel);
}
