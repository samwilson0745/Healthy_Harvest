class Register{
  final Map<String,dynamic> args;
  Register(this.args);
  Register.fromJSON(Map<String,dynamic> json):args=json;
}