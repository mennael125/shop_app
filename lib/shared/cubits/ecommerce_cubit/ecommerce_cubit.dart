import 'package:e_commerce_payment/modeles/cart/add_cart.dart';
import 'package:e_commerce_payment/modeles/cart/cart_data_model.dart';
import 'package:e_commerce_payment/modeles/cart/product_details.dart';
import 'package:e_commerce_payment/modeles/categories_model/categories.dart';
import 'package:e_commerce_payment/modeles/favorites_model/change_favorites_model.dart';
import 'package:e_commerce_payment/modeles/favorites_model/favorites_model.dart';
import 'package:e_commerce_payment/modeles/home_model/home_model.dart';
import 'package:e_commerce_payment/modeles/login_user_model/login_user_model.dart';
import 'package:e_commerce_payment/modules/category/category.dart';
import 'package:e_commerce_payment/modules/favorite/favorite.dart';
import 'package:e_commerce_payment/modules/products/products.dart';
import 'package:e_commerce_payment/modules/seetings/settings.dart';
import 'package:e_commerce_payment/shared/componentes/componentes.dart';
import 'package:e_commerce_payment/shared/network/end_point.dart';
import 'package:e_commerce_payment/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ecommerce_states.dart';


class ECommerceCubit extends Cubit<ECommerceStates> {
  ECommerceCubit() : super(ECommerceInitialState());

  static ECommerceCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;


  void change(int index) {
    currentIndex = index;
    emit(ECommerceBottomNav());
  }

  List<Widget> screens = [
    ProductsScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  bool? inFavorite;

  HomeModel? homeModel;
  Map<int, bool> favorite = {};

  void getModelData() {
    emit(HomeLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data.products.forEach((element) {
        favorite.addAll({element.id: element.inFavorites});
      });
      print(favorite.toString());
      emit(HomeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorState());
    });
  }

  CategoryModel? categoryModel;

  void getCategory() {
    DioHelper.getData(url: CATEGORY).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(CategorySuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CategoryErrorState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorite(int productId) {
    favorite[productId] = !favorite[productId]!;
    emit(ChangeSuccessState());

    DioHelper.postData(
        url: FAVORITES,
        token: token,
        data: {'product_id': productId}).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!(changeFavoritesModel!.status!)) {
        favorite[productId] = !favorite[productId]!;
      } else {
        getFavorite();
      }

      emit(ChangeFavoriteSuccessState(changeFavoritesModel!));
    }).catchError((error) {
      favorite[productId] = !favorite[productId]!;

      emit(ChangeFavoriteErrorState());
    });
  }

  FavoriteModel? favoriteModel;

  void getFavorite() {
    if (token != null) {
      emit(FavoriteLoadingState());
      DioHelper.getData(url: FAVORITES, token: token).then((value) {
        favoriteModel = FavoriteModel.fromJson(value.data);

        emit(FavoriteSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(FavoriteErrorState());
      });
    }
  }

  LoginModel? userModel;

  void getSettings() {
    if (token != null) {
      emit(UserLoadingState());

      DioHelper.getData(url: PROFILE, token: token).then((value) {
        userModel = LoginModel.fromJson(value.data);
        emit(UserSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(UserErrorState());
      });
    }
  }

  void putData({
    required String name,
    required String phone,
    required String email,
  }) {
    if (token != null) {
      emit(UpdateLoadingState());

      DioHelper.putData(
              url: UpdateProfile,
              data: {'name': name, 'phone': phone, 'email': email},
              token: token!)
          .then((value) {
        userModel = LoginModel.fromJson(value.data);
        emit(UpdateSuccessState(userModel!));
      }).catchError((error) {
        print(error.toString());
        emit(UpdateErrorState());
      });
    }
  }

  ProductDetailsModel? productDetailsModel;

  void getProductDetails(int productID) {
    emit(ECommerceLoadingGetProductDetailsState());
    DioHelper.getData(url: 'products/$productID', token: token).then((value) {
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      emit(ECommerceSuccessGetProductDetailsState());
    }).catchError((error) {
      print(error.toString());
      emit(ECommerceErrorGetProductDetailsState());
    });
  }
  CartModel? cartModel;

  void getCarts() {

      emit(CartLoadingState());
      DioHelper.getData(
        url: CARTS,
        token: token,
      ).then((value) {
        cartModel = CartModel.fromJson(value.data);
        emit(CartSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(CartErrorState());
      });
    }


  AddToCart? addToCart;

  void addCarts(productId) {
    if (token != null) {
      emit(CartAddLoadingState());
      DioHelper.postData(url: CARTS, data: {'product_id': productId}, token: token!)
          .then((value) {
        addToCart = AddToCart.fromJson(value.data);
        getCarts();
        emit(CartAddSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(CartAddErrorState());
      });
    }
  }

  void deleteCarts(int productId) {
    emit(CartRemoveLoadingState());
    DioHelper.deleteData(url: '$CARTS/$productId', token: token!).then((value) {
      if (value.data['status']) {
        getCarts();
      }
      print(value.data['message']);

      emit(CartRemoveSuccessState());
    }).catchError((onError) {
      print(onError.toString());

      emit(CartRemoveErrorState());
    });
  }

  void updateQuantityOfInCartProduct(int inCartProductID, int quantity) {
    emit(CartLoadingUpdateQuantityState());
    DioHelper.putData(
      url: '$CARTS/$inCartProductID',
      data: {
        'quantity': quantity,
      },
      token: token!,
    ).then((value) {
      if (value.data['status']) {
        getCarts();
      }
      emit(CartSuccessUpdateQuantityState());
    }).catchError((error) {
      print(error.toString());
      emit(CartErrorUpdateQuantityState());
    });
  }
}
