import 'package:cart_project/controller/cart_controller.dart';
import 'package:cart_project/model/item_selection_model.dart';
import 'package:cart_project/view/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDescription extends StatefulWidget {
  String? id;
  String title;
  String imageUrl;
  String price;

  ProductDescription({required this.id,required this.title,required this.imageUrl,required this.price});

  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    // timeDilation = 2;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(onTap: (){
                      Navigator.pop(context);
                    },child: Icon(Icons.cancel)),
                    Spacer(),
                    Image.network(widget.imageUrl,height: 200),
                    Spacer(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15,bottom: 25),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: widget.title,),
                        TextSpan(text: " x Rs. "+widget.price ,
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10,bottom: 15),
                  child: Text("Good Pen"),
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap:(){
                        // cartController.decreaseQty(widget.id);
                        if(cartController.qty.value >1){
                          cartController.qty.value -= 1;
                        }
                      },
                      child: Container(
                        height: 30,width: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(child: Text('-',)),
                      ),
                    ),

                    Obx(()=> Text("${cartController.qty}"),),

                    InkWell(
                      onTap:(){
                        cartController.qty.value += 1;
                      },
                      child: Container(
                        height: 30,width: 30,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(child: Text('+',)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: (){
                      double prize = double.parse(widget.price) * double.parse(cartController.qty.value.toString());
                      cartController.addtoCart(PreCartModel(id: widget.id,title: widget.title,imageUrl: widget.imageUrl,price: prize.toString(),individualPrice: double.parse(widget.price)));
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage()));
                    },
                    child: Row(
                      children: const [
                        Spacer(),
                        Text("Add to Cart"),
                        Spacer(),
                      ],
                    ),),
                ),
              ),)
          ],
        )
      ],
    );
  }
}
