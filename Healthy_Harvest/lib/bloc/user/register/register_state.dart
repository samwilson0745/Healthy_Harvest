import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable{
  @override
  List<Object> get props=>[];
}
class RegisterInitialize extends RegisterState{

}
class RegisterLoading extends RegisterState{

}
class UserRegistered extends RegisterState{

}
class RegistrationError extends RegisterState{

  final String error;

 RegistrationError({required this.error});

 @override
  List<Object>get props=>[error];
  String toString()=> 'Login Error: $error';
}