import 'package:equatable/equatable.dart';
import 'package:healthy_harvest/models/auth_model.dart';
abstract class AuthEvent extends Equatable{
 const AuthEvent();
 @override
  List<Object>get props=>[];
}
class AppStarted extends AuthEvent{

}
class LoggedIn extends AuthEvent{
  final Auth auth;
  const LoggedIn({required this.auth});

  @override
  List<Object> get props=>[auth];

  String toString()=>"Logged In: ${auth.token}";
}
class LoggedOut extends AuthEvent{
  String toString()=>"Logged Out";
}
