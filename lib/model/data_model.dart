import 'package:cloud_firestore/cloud_firestore.dart';

class DataModel {
  String? documentId;
  late String image;
  late String price;
  late String title;

  DataModel({
    required this.documentId,
    required this.image,
    required this.price,
    required this.title,

  });

  DataModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    documentId = documentSnapshot.id;
    image = documentSnapshot["image"];
    price = documentSnapshot["price"];
    title = documentSnapshot["title"];
  }
}