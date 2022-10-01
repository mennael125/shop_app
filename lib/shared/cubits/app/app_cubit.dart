import 'package:bloc/bloc.dart';
import 'package:e_commerce_payment/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'app_states.dart';

class AppCubit extends Cubit < AppStates> {
  AppCubit() : super(AppInitialState());
static AppCubit get(context)=>BlocProvider.of(context);
  bool isDark =false;
  void changeTheme ({        bool ? fromShared}

      ) {
    if (fromShared!=null ) {
      isDark=fromShared ;

      emit(LightState());
    }
    else
      isDark = !isDark;
    CacheHelper.savetData(value: isDark, key: 'isDark');
    emit(LightState());
  }

  }

