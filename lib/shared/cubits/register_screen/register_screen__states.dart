
import 'package:e_commerce_payment/modeles/register_model/register_model.dart';

abstract class RegisterStates{}
class RegisterInitialState extends RegisterStates{}
class ECommerceRegisterDoneState extends RegisterStates{

  final RegisterModel registerModel;

  ECommerceRegisterDoneState(this.registerModel);
}
class ECommerceRegisterErrorState extends RegisterStates{
  final String error;

  ECommerceRegisterErrorState(this.error);


}
class ECommerceRegisterLoadingState extends RegisterStates{}
class RegisterPasswordShowState extends RegisterStates{}
