import 'package:bloc/bloc.dart';
import 'package:e_commerce_payment/modeles/search_model/search_model.dart';
import 'package:e_commerce_payment/shared/componentes/componentes.dart';
import 'package:e_commerce_payment/shared/cubits/search_cubit/search_states.dart';
import 'package:e_commerce_payment/shared/network/end_point.dart';
import 'package:e_commerce_payment/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(InitialSearchState());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;

  void search(String text) {
    emit(LoadingSearchState());
    DioHelper.postData(url: SEARCH, token: token, data: {'text': text})
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(DoneSearchState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorSearchState());
    });
  }
}
