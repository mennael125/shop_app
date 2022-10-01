import 'package:bloc/bloc.dart';
import 'package:e_commerce_payment/modeles/register_model/register_model.dart';
import 'package:e_commerce_payment/shared/cubits/register_screen/register_screen__states.dart';
import 'package:e_commerce_payment/shared/network/end_point.dart';
import 'package:e_commerce_payment/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  RegisterModel? registerModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(ECommerceRegisterLoadingState());
    DioHelper.postData(
      data: {
        "email": email,
        "password": password,
        "phone": phone,
        "name": name,
      },
      url: REGISTER,
    ).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      emit(ECommerceRegisterDoneState(registerModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ECommerceRegisterErrorState(error.toString()));
    });
  }

  bool isPassword = true;

  IconData suffix = Icons.visibility;

  void passwordVisibility() {
    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(RegisterPasswordShowState());
  }
}
