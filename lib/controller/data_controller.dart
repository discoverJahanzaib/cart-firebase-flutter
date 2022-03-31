import 'package:cart_project/controller/cart_controller.dart';
import 'package:cart_project/model/cart_model.dart';
import 'package:cart_project/model/data_model.dart';
import 'package:cart_project/service/data_service.dart';
import 'package:get/get.dart';

class DataController extends GetxController{
  CartController cartController = Get.put(CartController());

  Rx<List<DataModel>> dataList = Rx<List<DataModel>>([]);
  Rx<List<CartProductModel>> cartList = Rx<List<CartProductModel>>([]);
  // List<DataModel> dataList = <DataModel>[].obs;
  List<DataModel> get localDataList => dataList.value;
  List<CartProductModel> get localCartList => cartList.value;


  @override
  void onReady() {
    dataList.bindStream(DataService.fetchDataStream());
    cartList.bindStream(DataService.fetchCartStream());
    cartController.cartItemList.addAll(localCartList);
    cartController.cartItemList.refresh();
  }
}