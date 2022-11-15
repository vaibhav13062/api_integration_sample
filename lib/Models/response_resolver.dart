// TODO: Common backend Response Model will have to change according backend.

class ResponseResolver {
  ResponseResolver({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  dynamic data;

  factory ResponseResolver.fromJson(Map<String, dynamic> json) =>
      ResponseResolver(
          status: json["status"] ?? false,
          message: json["message"] ?? "",
          data: json['data'] ?? "");

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}
