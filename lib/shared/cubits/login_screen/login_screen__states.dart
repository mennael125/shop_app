import 'package:e_commerce_payment/modeles/login_user_model/login_user_model.dart';

abstract class LoginStates{}
class ECommerceInitialState extends LoginStates{}
class ECommerceLoginDoneState extends LoginStates{

  final LoginModel loginModel;

  ECommerceLoginDoneState(this.loginModel);

}
class ECommerceLoginErrorState extends LoginStates{
  final String error;

  ECommerceLoginErrorState(this.error);


}
class ECommerceLoginLoadingState extends LoginStates{}
class ECommercePasswordShowState extends LoginStates{}
