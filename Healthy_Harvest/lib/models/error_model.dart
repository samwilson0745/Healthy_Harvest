class Error{
  final String error;
  Error(this.error);
  Error.fromJson(Map<String,dynamic> err):error=err["error"];
}