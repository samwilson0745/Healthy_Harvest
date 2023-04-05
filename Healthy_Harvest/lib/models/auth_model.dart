class Auth{
  final String token;
  final String username;
  Auth(this.token,this.username);
  Auth.fromJSON(Map<String,dynamic> json):token=json['access'],username=json["username"];
}