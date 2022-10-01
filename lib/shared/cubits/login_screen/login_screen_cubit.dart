import 'package:bloc/bloc.dart';
import 'package:e_commerce_payment/modeles/login_user_model/login_user_model.dart';
import 'package:e_commerce_payment/shared/network/end_point.dart';
import 'package:e_commerce_payment/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_screen__states.dart';


class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(ECommerceInitialState());
   LoginModel ? loginModel ;

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ECommerceLoginLoadingState());
    DioHelper.postData(
      data: {"email": email, "password": password},
      url: LOGIN,
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);


      emit(ECommerceLoginDoneState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ECommerceLoginErrorState(error.toString()));
    });
  }

  bool isPassword = true;

  IconData suffix = Icons.visibility;

  void passwordVisibility() {
    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ECommercePasswordShowState());
  }
}
