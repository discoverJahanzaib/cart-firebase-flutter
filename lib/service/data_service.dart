import 'package:cart_project/model/data_model.dart';
import 'package:cart_project/utils/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataService{

  static Stream<List<DataModel>> fetchDataStream() {
    return firebaseFirestore
        .collection('data')
        .snapshots()
        .map((QuerySnapshot query) {
      List<DataModel> todos = [];
      for (var todo in query.docs) {
        final todoModel =
        DataModel.fromDocumentSnapshot(documentSnapshot: todo);
        todos.add(todoModel);
      }
      return todos;
    });
  }

}