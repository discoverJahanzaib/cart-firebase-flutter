import 'package:cart_project/model/data_model.dart';
import 'package:cart_project/service/data_service.dart';
import 'package:get/get.dart';

class DataController extends GetxController{
  Rx<List<DataModel>> dataList = Rx<List<DataModel>>([]);
  // List<DataModel> dataList = <DataModel>[].obs;
  List<DataModel> get localDataList => dataList.value;

  @override
  void onReady() {
    dataList.bindStream(DataService.fetchDataStream());
  }
}