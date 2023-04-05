import 'package:equatable/equatable.dart';
import 'package:healthy_harvest/models/auth_model.dart';

abstract class AuthState extends Equatable{
 @override
 List<Object> get props =>[];
}
class AuthUninitialized extends AuthState{

}
class AuthAuthenticated extends AuthState{
 final String User;
 AuthAuthenticated({required this.User});
 @override
 List<Object> get props=>[User];
}
class AuthUnauthenticated extends AuthState{

}
class AuthLoading extends AuthState{

}