
class Failure {
  int statusCode; // 200 or 400
  String statusMessage;// error or success

  Failure({required this.statusCode, required this.statusMessage});
}

