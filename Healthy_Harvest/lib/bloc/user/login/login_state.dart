import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable{
 const LoginState();

 @override
  List<Object> get props =>[];
}

class LoginInitial extends LoginState{

}

class LoginLoading extends LoginState{

}

class LoginError extends LoginState{

  final String error;
  LoginError({required this.error});
  @override
  List<Object>get props =>[error];

  String toString()=> "Login Error: $error";
}