import 'package:cart_project/model/cart_model.dart';
import 'package:cart_project/model/item_selection_model.dart';
import 'package:cart_project/service/data_service.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  var cartItemList = <CartProductModel>[].obs ;
  var qty = 1.obs;
  var subtotal = 0.obs;

  /// adding item to cart after Checking
  addtoCart(PreCartModel selectedProductitem){
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
      DataService.cartFirebase(PreCartModel(id: cartItem.id,title: cartItem.title,imageUrl: cartItem.imageUrl,price: cartItem.price,individualPrice: double.parse(cartItem.price)),cartItem.qty);
      cartItemList.refresh();
      qty.value = 1;
      qty.refresh();
    }
  }

  void incrementQty(id) {
    var index = cartItemList.indexWhere((listItems) => listItems.id == id);
    cartItemList[index].qty += 1;
    cartItemList.refresh();
  }

  void decreaseQty(id) {
    var index = cartItemList.indexWhere((listItems) => listItems.id == id);
    if(cartItemList[index].qty > 1){
      cartItemList[index].qty -= 1;
      cartItemList.refresh();
    }
  }

  double get totalPrice => cartItemList.fold(0, (previousValue, element) => previousValue + double.parse(element.price));
  int get count => cartItemList.length;

}