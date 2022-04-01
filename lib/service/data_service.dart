import 'package:cart_project/model/cart_model.dart';
import 'package:cart_project/model/data_model.dart';
import 'package:cart_project/model/item_selection_model.dart';
import 'package:cart_project/utils/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataService{

  /// Fetch Products ///
  static Stream<List<DataModel>> fetchDataStream() {
    return firebaseFirestore
        .collection('data')
        .snapshots()
        .map((QuerySnapshot query) {
      List<DataModel> dataLs = [];
      for (var e in query.docs) {
        final fModel =
        DataModel.fromDocumentSnapshot(documentSnapshot: e);
        dataLs.add(fModel);
      }
      return dataLs;
    });
  }

  /// Fetch Cart ///
  static Stream<List<CartProductModel>> fetchCartStream() {
    return firebaseFirestore
        .collection('cart')
        .snapshots()
        .map((QuerySnapshot query) {
      List<CartProductModel> dataLs = [];
      for (var e in query.docs) {
        final fModel =
        CartProductModel.fromDocumentSnapshot(documentSnapshot: e);
        dataLs.add(fModel);
      }
      return dataLs;
    });
  }

  /// Add Cart to Firebase ///
  static cartFirebase(PreCartModel cartData,qty) async {
    await firebaseFirestore
        .collection('cart')
        .doc(cartData.id)
        .set({
          'productID': cartData.id,
          'title':cartData.title,
          'imageUrl':cartData.imageUrl,
          'price':cartData.price,
          'individualPrice':cartData.individualPrice,
          'qty': qty,
    });
  }

  /// Update Cart to Firebase ///
  static updateCart(id,quantity,totalPrice) {
    firebaseFirestore
        .collection('cart')
        .doc(id)
        .update(
      {
        'qty': quantity,
        'price': totalPrice,
      },
    );
  }

  /// delete Cart to Firebase ///
  static deleteCart(id)  {
    firebaseFirestore
        .collection('cart')
        .doc(id)
        .delete();
  }

  /// delete Cart to Firebase ///

  static Future cartDelete() async {
    final instance = FirebaseFirestore.instance;
    final batch = instance.batch();
    var collection = instance.collection('cart');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

}