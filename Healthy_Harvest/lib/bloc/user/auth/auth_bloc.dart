import 'auth_event.dart';
import 'auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_harvest/store/login/auth_repo.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{
 final auth_repo repo;
 AuthBloc({required this.repo}):super(AuthUninitialized()){
   on<AppStarted>((event,emit)async{
     final bool hasToken = await repo.hasToken();
     if(hasToken){
       final String username = await repo.getUsername();
       emit(AuthAuthenticated(User: username));
     }else{
       emit(AuthUnauthenticated());
     }
   });
   on<LoggedIn>((event,emit)async{
     emit(AuthLoading());
     print("2");
     print(event.auth.token);
     print(event.auth.username);
     await repo.putTokentoStorage(event.auth.token);
     await repo.putUsernametoStorage(event.auth.username);
     emit(AuthAuthenticated(User: event.auth.username));
   });
   on<LoggedOut>((event, emit)async{
     emit(AuthLoading());
     await repo.deleteToken();
     emit(AuthUnauthenticated());
   });
 }
}