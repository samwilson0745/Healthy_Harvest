import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_harvest/bloc/user/auth/auth_bloc.dart';
import 'package:healthy_harvest/bloc/user/auth/auth_event.dart';
import 'package:healthy_harvest/bloc/user/login/login_event.dart';
import 'package:healthy_harvest/bloc/user/login/login_state.dart';
import 'package:healthy_harvest/models/auth_model.dart';
import 'package:healthy_harvest/store/login/auth_repo.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  final auth_repo repo;
  final AuthBloc authenticationBloc;

  LoginBloc({required this.repo, required this.authenticationBloc}):super(LoginInitial()){
    on<LoginButtonPressed>((event, emit)async{
      emit(LoginLoading());
      try{
        Auth auth =await repo.login(event.email,event.password);
        authenticationBloc.add(LoggedIn(auth: auth));
        emit(LoginInitial());
      }catch(error){
        print(error);
        emit(LoginError(error: "Invalid credentials"));
      }
    });
  }
}

