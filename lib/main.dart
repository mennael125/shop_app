import 'package:e_commerce_payment/shared/componentes/componentes.dart';
import 'package:e_commerce_payment/shared/cubits/app/app_cubit.dart';
import 'package:e_commerce_payment/shared/cubits/app/app_states.dart';
import 'package:e_commerce_payment/shared/cubits/ecommerce_cubit/ecommerce_cubit.dart';
import 'package:e_commerce_payment/shared/network/local/cache_helper.dart';
import 'package:e_commerce_payment/shared/network/remote/dio_helper.dart';
import 'package:e_commerce_payment/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'layout/ecommerce_layout.dart';
import 'modules/login/login.dart';
import 'modules/on_boarding/on_boarding.dart';
import 'shared/cubits/bloc_provider/bloc_provider.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  dynamic onBoardingSkip ;


  onBoardingSkip = CacheHelper.getData
    (key: 'onBoardingSkip') ;
  token = CacheHelper.getData
  (key: 'token') ;
  print ( "token $token " );
  Widget start;
  if(onBoardingSkip != null){
    if(token == ''){
      start = LoginScreen();
    }else{
      start = ECommerceLayout();
    }
  }else
    start = OnBoarding();
  runApp(MyApp(start: start));
}




class MyApp extends StatelessWidget {
  final Widget start ;

  MyApp({
    required this.start,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider( create: (context)=> ECommerceCubit()..getModelData()..getCategory()..getFavorite()..getSettings()..getCarts())
,

        BlocProvider(
            create: (context) => AppCubit())
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            themeMode:
            ThemeMode.light,
            theme: lightMode,
            darkTheme: darkMode,
            debugShowCheckedModeBanner: false,
            home: start ,
          );
        },
      ),
    );
  }
}
