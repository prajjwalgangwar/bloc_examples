import 'package:bloc/bloc.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitialState()) {

    on<AuthenticationInitialEvent>(initialState);

    on<AuthenticationErrorEvent>(errorState);

    on<AuthenticationSuccessEvent>(successState);
  }

  void initialState(AuthenticationInitialEvent event, Emitter<AuthenticationState> emit) async {
    print("emitting AuthenticationInitialState");
    emit(AuthenticationInitialState());
  }

  void errorState(AuthenticationErrorEvent event , Emitter<AuthenticationState> emit) async {
    if(event.phoneNumberValue.length != 10){
      print("emitting AuthenticationErrorState");
      emit(AuthenticationErrorState("Enter valid phone number"));
    }else{
      print("emitting AuthenticationValidState");
      emit(AuthenticationValidState());
    }
  }

  // void isUserRegistered(AuthenticationSuccessEvent event , Emitter<AuthenticationState> emit) async {
  //   if(event.phoneNumber == "7053974421"){
  //     emit(AuthenticatedUserState(number: event.phoneNumber));
  //
  //   }
  // }
  void successState(AuthenticationSuccessEvent event , Emitter<AuthenticationState> emit) async {
    if(event.phoneNumber == "1234567890"){

      emit(AuthenticatedUserState(phoneNumber: event.phoneNumber));
    }else{
      emit(NewUserState(number: event.phoneNumber));
    }

    print("emitting AuthenticationSuccessState");

  }
}
