class CartProductModel{
  String id;
  String title;
  String imageUrl;
  String price;
  String individualPrice;
  var qty;

  CartProductModel({required this.id,required this.title,required this.imageUrl,required this.price,required this.qty,required this.individualPrice});

}