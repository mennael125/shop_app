class ProductDetailsModel {
  late bool status;
  late ProductModelDetails productModel;

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    productModel = ProductModelDetails.fromJson(json['data']);
  }
}

class ProductModelDetails {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;
  late List<dynamic> images;
  late String description;

  ProductModelDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
    images = json['images'];
    description = json['description'];
  }
}
