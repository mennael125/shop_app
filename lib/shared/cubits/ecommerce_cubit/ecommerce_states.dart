
import 'package:e_commerce_payment/modeles/favorites_model/change_favorites_model.dart';
import 'package:e_commerce_payment/modeles/login_user_model/login_user_model.dart';

abstract class ECommerceStates {}

class ECommerceInitialState extends ECommerceStates {}

class ECommerceBottomNav extends ECommerceStates {}

class HomeLoadingState extends ECommerceStates {}

class HomeSuccessState extends ECommerceStates {}

class HomeErrorState extends ECommerceStates {}

class CategorySuccessState extends ECommerceStates {}

class CategoryErrorState extends ECommerceStates {}

class ChangeFavoriteSuccessState extends ECommerceStates {
  final ChangeFavoritesModel favoritesModel;

  ChangeFavoriteSuccessState(this.favoritesModel);
}

class ChangeFavoriteErrorState extends ECommerceStates {}

class ChangeSuccessState extends ECommerceStates {}

class FavoriteErrorState extends ECommerceStates {}

class FavoriteSuccessState extends ECommerceStates {}
class FavoriteLoadingState extends ECommerceStates {}
class UserLoadingState extends ECommerceStates {}

class UserSuccessState extends ECommerceStates {}

class UserErrorState extends ECommerceStates {}
class UpdateLoadingState extends ECommerceStates {}

class UpdateSuccessState extends ECommerceStates {
  final LoginModel model;

  UpdateSuccessState(this.model);

}

class UpdateErrorState extends ECommerceStates {}

class CartSuccessState extends ECommerceStates {}

class CartErrorState extends ECommerceStates {}
class CartLoadingState extends ECommerceStates {}
class CartAddSuccessState extends ECommerceStates {}

class CartAddErrorState extends ECommerceStates {}
class CartAddLoadingState extends ECommerceStates {}
class CartRemoveSuccessState extends ECommerceStates {}

class CartRemoveErrorState extends ECommerceStates {}
class CartRemoveLoadingState extends ECommerceStates {}
class CartSuccessUpdateQuantityState extends ECommerceStates {}

class ECommerceLoadingGetProductDetailsState extends ECommerceStates {}

class ECommerceSuccessGetProductDetailsState extends ECommerceStates {}

class ECommerceErrorGetProductDetailsState extends ECommerceStates {}
class CartErrorUpdateQuantityState extends ECommerceStates {}
class CartLoadingUpdateQuantityState extends ECommerceStates {}
