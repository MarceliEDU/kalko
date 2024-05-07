import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'form_list_element.dart';
import 'list_element.dart';

class ProductList extends StatefulWidget {
  final String documentId;

  ProductList(this.documentId, {super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  //app logic

  List<int> amountOfProduct = List.empty();
  fillZeroAmounts(int n) { amountOfProduct = List.filled(n, 0); }

  double money = 0;
  setMoney(double value) { money = value; }
  TextEditingController moneyController = TextEditingController();


  addToDb(double price, String product) async {
    DocumentReference ref = FirebaseFirestore.instance.collection("Users").doc(widget.documentId);
    await ref.update({'products': FieldValue.arrayUnion([product])});
    await ref.update({'prices': FieldValue.arrayUnion([price])});
  }

  add(double price, String product) async {
      await addToDb(price,product);
      setState(() {});
  }

  removeFromDb(double price, String product) async {
    DocumentReference ref = FirebaseFirestore.instance.collection("Users").doc(widget.documentId);
    await ref.update({'prices': FieldValue.arrayRemove([price])});
    await ref.update({'products': FieldValue.arrayRemove([product])});
  }

  remove(double price, String product) async {
      await removeFromDb(price,product);
      setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) { return Center(child: const Text("Log in to create your list", style: TextStyle(color: Colors.white, fontSize: 20))); }

        if (snapshot.hasData && !snapshot.data!.exists) { Center(child: const Text("Document does not exist, try to restart your app.", style: TextStyle(color: Colors.white, fontSize: 20))); }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<
              String,
              dynamic>;
          List<String> products = List.from(data['products'] ?? []);
          List<double> prices = List.from(data['prices'] ?? []);
          if (amountOfProduct.isEmpty) {
            fillZeroAmounts(prices.length);
          }

          try{
            return SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    child: Row(
                      children: [
                        Flexible(
                          child: TextField(
                            controller: moneyController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Kwota na zakupy (PLN)",
                              hintStyle: const TextStyle(color: Colors.white54),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: Colors.white24.withOpacity(0.1),
                              filled: true,
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                            width: 100,
                            child: GestureDetector(
                              onTap: () {
                                if (moneyController.text.isNotEmpty) {
                                  setState(() {
                                    money = double.parse(moneyController.text);
                                    int i = 0;
                                    prices.forEach((element) {
                                      amountOfProduct[i] =
                                          (money / element).floor();
                                      i++;
                                    });
                                  });
                                }
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8)),
                                  ),
                                  child: Text("Oblicz", style: TextStyle(
                                      color: const Color(0xFF051d29),
                                      fontSize: 20))
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ListElement(
                          documentId: widget.documentId,
                          key: UniqueKey(),
                          product: products[index],
                          price: prices[index],
                          displayAmount: amountOfProduct[index],
                          remove: remove,
                        );
                      }),
                  FormListElement(add: add),
                ],
              ),
            );
          }catch(e){
            setState(() {});
          }

        }

        return const Text("loading");
      },
    );
  }
}