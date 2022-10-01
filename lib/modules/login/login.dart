import 'package:e_commerce_payment/layout/ecommerce_layout.dart';
import 'package:e_commerce_payment/modules/register/register_screen.dart';
import 'package:e_commerce_payment/shared/componentes/componentes.dart';
import 'package:e_commerce_payment/shared/cubits/ecommerce_cubit/ecommerce_cubit.dart';
import 'package:e_commerce_payment/shared/cubits/login_screen/login_screen__states.dart';
import 'package:e_commerce_payment/shared/cubits/login_screen/login_screen_cubit.dart';
import 'package:e_commerce_payment/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is ECommerceLoginDoneState) {
            if (state.loginModel.status) {
              CacheHelper.savetData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
                ECommerceCubit.get(context).getModelData();
                ECommerceCubit.get(context).getCategory();

                ECommerceCubit.get(context).getFavorite();

                ECommerceCubit.get(context).getSettings();

                pushAndRemove(context: context, widget: ECommerceLayout());
              });
            } else {
              toast(text: state.loginModel.message, state: ToastState.Error);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN ',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Log in now to get our offers ',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.blueGrey)),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: emailController,
                            textKeyboard: TextInputType.emailAddress,
                            prefix: Icons.email_outlined,
                            validate: (value) {
                              if (value!.isEmpty)
                                return 'Please enter your Email';
                            },
                            textLabel: 'EmailAddress'),
                        SizedBox(
                          height: 10,
                        ),
                        defaultFormField(
                            onFieldSubmitted: (value) {
                              if (state is ECommerceLoginLoadingState) {
                                Center(child: CircularProgressIndicator());
                              } else {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              }
                            },
                            controller: passwordController,
                            textKeyboard: TextInputType.text,
                            prefix: Icons.lock_outline,
                            validate: (value) {
                              if (value!.isEmpty)
                                return 'Password is too short';
                            },
                            textLabel: 'Password',
                            isPassword: LoginCubit.get(context).isPassword,
                            suffixPressed: () {
                              LoginCubit.get(context).passwordVisibility();
                            },
                            suffix: LoginCubit.get(context).suffix),
                        SizedBox(
                          height: 20,
                        ),
                        state is ECommerceLoginLoadingState
                            ? Center(child: CircularProgressIndicator())
                            : defaultButton(
                                text: 'login',
                                fun: () {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                isUpper: true),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account ',
                                style: TextStyle(fontSize: 16)),
                            SizedBox(
                              width: 5,
                            ),
                            textButton(
                                text: "register now",
                                fun: () {
                                  navigateTo(
                                       context: context,
                                      widget: RegisterScreen());
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
