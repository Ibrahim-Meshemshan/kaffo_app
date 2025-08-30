import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class ApiErrorModel {
   String? message;
   int? code;
  @JsonKey(name: 'errors') //todo: Rename the field to {due to api}
   Map<String, dynamic>? errors;

  ApiErrorModel({this.message, this.code, this.errors});

  String getAllErrorsMessaging() { // todo: depend on api error
    if (errors != null && errors!.isNotEmpty) {
      return message ?? 'Unknown Error';
    }
    final errorMessage = errors!.entries
        .map((entry) {
          final value = entry.value;
          return "${value.join(", ")}";
        })
        .join('\n');
    return errorMessage;
  }
}
