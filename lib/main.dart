import 'package:badges/badges.dart';
import 'package:cart_project/controller/cart_controller.dart';
import 'package:cart_project/controller/data_controller.dart';
import 'package:cart_project/model/item_selection_model.dart';
import 'package:cart_project/model/selectedproduct_model.dart';
import 'package:cart_project/view/cart_page.dart';
import 'package:cart_project/view/product_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
   DataController dataController = Get.put(DataController());
   CartController cartController = Get.put(CartController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DataController dataController = Get.find<DataController>();
  CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // cartController.cartItemList.addAll(dataController.cartList.value);
    // cartController.cartItemList.refresh();
    // print(cartController.cartItemList[0].title);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cre"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey,
          elevation: 0,
          actions: [
            Obx(()=>cartController.cartItemList.isNotEmpty ? GestureDetector(onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage()));
            },child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: Badge(
                  badgeColor: Colors.green,
                  badgeContent: Text(cartController.cartItemList.length.toString(),),
                  child: const Icon(Icons.shopping_cart,color: Colors.black,)),
            )):const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.shopping_cart,color: Colors.black,),
            )),
          ],
        ),
       body:Obx(()=>ListView.builder(
         itemCount: dataController.localDataList.length,
         itemBuilder:(context,index){
           return GestureDetector(
             onTap: (){
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDescription(
                 title: dataController.localDataList[index].title,
                 id: dataController.localDataList[index].documentId,
                 imageUrl: dataController.localDataList[index].image,
                 price: dataController.localDataList[index].price,
               )));
             },
             child: Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.symmetric(vertical: 10),
                   child: Container(
                     height: 150,
                     width: 150,
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(10),
                       boxShadow: [
                         BoxShadow(
                             color: Colors.grey.shade300,
                             blurRadius: 2,
                             spreadRadius: 1,
                             offset: Offset(1,1)
                         )
                       ],
                       image: DecorationImage(
                           fit: BoxFit.fill,
                           image: NetworkImage(dataController.localDataList[index].image)
                       ),
                     ),
                   ),
                 ),
                 Text(dataController.localDataList[index].title),
                 Text("Rs. "+ dataController.localDataList[index].price),
               ],
             ),
           );
         }
       ))
    );
  }
}
