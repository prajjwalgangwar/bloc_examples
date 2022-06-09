abstract class AuthenticationState {}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticationValidState extends AuthenticationState {

}

class AuthenticationErrorState extends AuthenticationState {
  final String errorMessage;

  AuthenticationErrorState(this.errorMessage);
}

class AuthenticationSuccessState extends AuthenticationState{

}

class AuthenticatedUserState extends AuthenticationState {
  final String phoneNumber;
  AuthenticatedUserState({required this.phoneNumber});
}

class NewUserState extends AuthenticationState {
  final String number;
  NewUserState({required this.number});
}