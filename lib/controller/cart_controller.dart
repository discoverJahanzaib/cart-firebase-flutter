import 'package:cart_project/model/cart_model.dart';
import 'package:cart_project/model/item_selection_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  var cartItemList = List<CartProductModel>.empty(growable: true).obs ;
  var qty = 1.obs;
  var subtotal = 0.obs;

  addtoCart(PreCartModel selectedProductitem,{int quantity = 1}){
    var cartItem = CartProductModel(
      id: selectedProductitem.id.toString(),
      title: selectedProductitem.title,
      imageUrl: selectedProductitem.imageUrl,
      price: selectedProductitem.price,
      individualPrice: selectedProductitem.individualPrice.toString(),
      qty: qty.value,
    );
    var cartIndex = cartItemList.where((element) => element.id == cartItem.id);
    if(cartIndex.isNotEmpty){
      cartItemList.refresh();
      qty.value = 1;
      qty.refresh();
    }else{
      cartItemList.add(cartItem);
      cartItemList.refresh();
      qty.value = 1;
      qty.refresh();
    }
  }
  // bool isExist(item) {
  //   return cartItemList.contains(item);
  // }

  void incrementQty(id) {
    var index = cartItemList.indexWhere((listItems) => listItems.id == id);
    cartItemList[index].qty += 1;
  }

  void decreaseQty(id) {
    var index = cartItemList.indexWhere((listItems) => listItems.id == id);
    if(cartItemList[index].qty > 1){
      cartItemList[index].qty -= 1;
    }
  }

  double get totalPrice => cartItemList.fold(0, (previousValue, element) => previousValue + double.parse(element.price));
  int get count => cartItemList.length;

}