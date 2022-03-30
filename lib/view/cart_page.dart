import 'package:cart_project/controller/cart_controller.dart';
import 'package:cart_project/model/item_selection_model.dart';
import 'package:cart_project/model/selectedproduct_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
              children: [
                Obx((){
                  if (cartController.cartItemList.isNotEmpty) {
                    return ListView(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      children: [
                        Obx(()=> ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cartController.cartItemList.length,
                          itemBuilder: (context, index) {
                            double prize = double.parse(cartController.cartItemList[index].individualPrice) * double.parse(cartController.cartItemList[index].qty.toString());
                            cartController.cartItemList[index].price = prize.toString();
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(cartController.cartItemList[index].title),
                                  // subtitle: Text("a"),
                                  trailing: Text("Rs. "+cartController.cartItemList[index].price,
                                  ),
                                ),
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
                                                cartController.decreaseQty(cartController.cartItemList[index].id);
                                                cartController.cartItemList.refresh();
                                              },
                                              child: Container(
                                                height: 30,width: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius: BorderRadius.circular(50),
                                                ),
                                                child: Center(child: const Text('-',)),
                                              ),
                                            ),

                                            Obx(()=> Text(cartController.cartItemList[index].qty.toString(),
                                            ),),

                                            InkWell(
                                              onTap:(){
                                                cartController.incrementQty(cartController.cartItemList[index].id);
                                                cartController.cartItemList.refresh();
                                              },
                                              child: Container(
                                                height: 30,width: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius: BorderRadius.circular(50),
                                                ),
                                                child: Center(child: Text('+')),
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.restore_from_trash),
                                              onPressed: (){
                                                cartController.cartItemList.removeAt(index);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),


                              ],
                            );
                          },
                        )),
                        Column(
                          children: [
                            const SizedBox(height: 15,),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 10,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Text('Cena produktu',
                                        ),
                                      ),
                                      Obx(()=> Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Text("Rs. ${cartController.totalPrice}",
                                          // style: MyTheme.hintText,
                                        ),
                                      )),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Text('Wysyłka'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 10,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Text('Razem'),
                              ),
                              // Obx(()=>
                              //     Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              //   child: Text("${cartController.totalPrice+int.parse(userDataController.userDataList.value.response!.detail!.deliveryFees)} zł",
                              //     // style: MyTheme.black18w700,
                              //   ),
                              // )),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                child: SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    ),
                                    onPressed: () async {
                                      print("asdasdas");

                                    },
                                    child:
                                    Row(
                                      children: const [
                                        Spacer(),
                                        Text("Dalej"),
                                        Spacer(),
                                      ],
                                    )
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  } else {
                    return const Center(child: Text("Cart Empty"));
                  }
                }),
              ]
          ),
        ),
      ),
    );
  }
}
