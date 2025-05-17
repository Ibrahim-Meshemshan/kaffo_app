class ErrorModel {
  String? message;
  String? errors;

  ErrorModel({this.message, this.errors});

  factory ErrorModel.fromJson(dynamic json) {
    return ErrorModel(
      message: json['message'],
      errors: json['error'],
    );
  }

  @override
  String toString() {
    if (message != null && message!.isNotEmpty) {
      return message!;
    } else if (errors != null && errors!.isNotEmpty) {
      return errors!;
    } else {
      return 'Unknown error';
    }
  }
}
