
abstract class AuthenticationEvent {}

class AuthenticationInitialEvent extends AuthenticationEvent {}

class AuthenticationErrorEvent extends AuthenticationEvent {
  final String phoneNumberValue;
  AuthenticationErrorEvent({required this.phoneNumberValue});
}

class AuthenticationLoadingEvent extends AuthenticationEvent{}

class AuthenticationSuccessEvent extends AuthenticationEvent {
  final String phoneNumber;
  AuthenticationSuccessEvent( {required this.phoneNumber});
}

class OTPInitialEvent extends AuthenticationEvent{}