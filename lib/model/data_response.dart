class DataResponse {
  bool status;
  List data;
  final String message;

  DataResponse(
      {required this.status, required this.data, required this.message});

  factory DataResponse.success(List items) {
    return DataResponse(status: true, data: items, message: "");
  }

  factory DataResponse.error(String message) {
    return DataResponse(status: false, data: [], message: message);
  }
}
