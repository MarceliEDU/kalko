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

  List<bool> changedAmountsStore = List.empty();
  fillFalseChanged(int n) { changedAmountsStore = List.filled(n, false); }

  double money = 0;
  setMoney(double value) { money = value; }
  TextEditingController moneyController = TextEditingController();

  setChanged(int i, int amount, double price) {
    setState(() {
      changedAmountsStore[i] = true;
      amountOfProduct[i] = amount;
      money -= amountOfProduct[i] * price;
    });
  }

  calculate(List prices) {
    int i = 0;
    for (var element in prices) {
      if(!changedAmountsStore[i]) {
        if(money > 0){
          amountOfProduct[i] =
              (money / element).floor();
        } else {
          amountOfProduct[i] = 0;
        }
      }
      i++;
    }
  }


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
        if (snapshot.hasError) { return const Center(child: Text("Log in to create your list", style: TextStyle(color: Colors.white, fontSize: 20))); }

        if (snapshot.hasData && !snapshot.data!.exists) { const Center(child: Text("Document does not exist, try to restart your app.", style: TextStyle(color: Colors.white, fontSize: 20))); }

        if (snapshot.connectionState == ConnectionState.done) {

          Map<String, dynamic> data = snapshot.data!.data() as Map<
              String,
              dynamic>;
          List<String> products = List.from(data['products'] ?? []);
          List<double> prices = List.from(data['prices'] ?? []);
          if (amountOfProduct.isEmpty) {
            fillZeroAmounts(prices.length);
          }
          if (changedAmountsStore.isEmpty) {
            fillFalseChanged(prices.length);
          }
          calculate(prices);

          try{
            return SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: Center(
                      child: TextField(
                        controller: moneyController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                        decoration: InputDecoration(
                          hintText: "Kwota na zakupy (PLN)",
                          hintStyle: const TextStyle(color: Colors.white60),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.white.withOpacity(0.1),
                          filled: true,
                        ),
                        onEditingComplete: () {

                          setState(() {
                            fillFalseChanged(prices.length);
                            money = double.parse(moneyController.text);
                          });

                        },
                      ),
                    )
                  ),
                  const SizedBox(height: 10,),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
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
                          isChanged: changedAmountsStore[index],
                          setChange: (int amount, double price) { setChanged(index, amount, price); },
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