class StatusResponse {
  int status;
  String message;

  StatusResponse({
    this.status,
    this.message,
  });

  factory StatusResponse.fromJson(Map<dynamic, dynamic> parsedJson){
    return StatusResponse(
        status: parsedJson['status'],
        message : parsedJson['message'],
    );
  }
}