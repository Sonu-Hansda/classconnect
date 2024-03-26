enum ResponseType { success, error }

class Response {
  final String? message;
  final ResponseType status;

  Response({this.message, required this.status});
}
