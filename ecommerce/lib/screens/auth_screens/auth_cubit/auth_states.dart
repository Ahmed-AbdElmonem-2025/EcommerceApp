
abstract class AuthStates {}

class AuthInitialStates extends AuthStates {}




class RegisterSuccssState extends AuthStates {}
class RegisterErrorState extends AuthStates {
  String message;
  RegisterErrorState({required this.message });
}
class RegisterLoadingState extends AuthStates {}








class LoginSuccssState extends AuthStates {}
class LoginErrorState extends AuthStates {
  final String message;

  LoginErrorState({required this.message});
  
}
class LoginLoadingState extends AuthStates {}
