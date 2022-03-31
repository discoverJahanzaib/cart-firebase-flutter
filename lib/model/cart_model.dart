import 'package:cloud_firestore/cloud_firestore.dart';

class CartProductModel{
  String? id;
  late String title;
  late String imageUrl;
  late String price;
  late String individualPrice;
  var qty;

  CartProductModel({required this.id,required this.title,required this.imageUrl,required this.price,required this.qty,required this.individualPrice});

  CartProductModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {

    id = documentSnapshot.id;
    title = documentSnapshot["title"];
    imageUrl = documentSnapshot["imageUrl"];
    price = documentSnapshot["price"];
    individualPrice = documentSnapshot["individualPrice"].toString();
    qty = documentSnapshot["qty"];
  }

}