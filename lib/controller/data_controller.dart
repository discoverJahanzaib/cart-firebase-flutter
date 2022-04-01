import 'package:cart_project/controller/cart_controller.dart';
import 'package:cart_project/model/cart_model.dart';
import 'package:cart_project/model/data_model.dart';
import 'package:cart_project/service/data_service.dart';
import 'package:get/get.dart';

class DataController extends GetxController{
  CartController cartController = Get.put(CartController());

  /// Stream for active listening
  Rx<List<DataModel>> dataList = Rx<List<DataModel>>([]);
  Rx<List<CartProductModel>> cartList = Rx<List<CartProductModel>>([]);
  List<DataModel> get localDataList => dataList.value;
  List<CartProductModel> get localCartList => cartList.value;


  /// Checking for Previous Cart
  @override
  void onReady() {
    cartList.stream.listen((event) {
      for(var e in event){
        var cartIndex = cartController.cartItemList.where((element) => element.id == e.id);
        if(cartIndex.isNotEmpty){

        }else{
          cartController.cartItemList.add(e);
          cartController.cartItemList.refresh();
        }
      }
    });
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    dataList.bindStream(DataService.fetchDataStream());
    cartList.bindStream(DataService.fetchCartStream());
  }
}