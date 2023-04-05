import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_harvest/bloc/user/login/login_event.dart';
import 'package:healthy_harvest/bloc/user/register/register_event.dart';
import 'package:healthy_harvest/bloc/user/register/register_state.dart';
import 'package:healthy_harvest/store/register/register_repo.dart';
import 'package:healthy_harvest/bloc/user/login/login_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent,RegisterState>{
  final register_repo repo;
  final LoginBloc loginBloc;
  RegisterBloc({required this.repo,required this.loginBloc}):super(RegisterInitialize()){
    on<RegisterButtonPressed>((event,emit)async{
      emit(RegisterLoading());
      try{
        var response=await repo.register(event.username,event.email, event.password,);
        print(response);
        emit(UserRegistered());
        loginBloc.add(LoginButtonPressed(email: event.email, password: event.password));
      }catch(error){
        print(error);
        emit(RegistrationError(error: error.toString()));
      }
    });

  }
}