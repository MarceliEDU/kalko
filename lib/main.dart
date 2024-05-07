import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kalko/product_list.dart';
import 'firebase_options.dart';
import 'navigation.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    home: App(),
    debugShowCheckedModeBanner: false,
  ));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  late User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _currentUser = user;
      });
    });
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF051d29),
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text("KALKO", style: TextStyle(
          color: Color(0xFF051d29),
          fontWeight: FontWeight.bold,
        )),
        centerTitle: true,
        backgroundColor: const Color(0xFF4AF4F7),
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(Icons.account_box, color: Color(0xFF051d29),),
        //     tooltip: 'Profile',
        //     onPressed: () {
        //       // handle the press
        //     },
        //   ),
        // ],
      ),
      body:
          ProductList(_currentUser != null ? _currentUser!.uid : "default"),


    );
  }
}






//final TextEditingController productController = TextEditingController();
//final TextEditingController priceController = TextEditingController();

// floatingActionButton: FloatingActionButton(
// onPressed: () {
// showDialog(
// context: context,
// builder: (ctx) => AlertDialog(
// title: Center(child: const Text("Dodaj produkt", style: TextStyle(color: Colors.white),)),
// backgroundColor: const Color(0xFF051d29),
// content: Container(
// height: 230,
// child: Column(
// children: [
// TextField(
// controller: productController,
// style: const TextStyle(color: Colors.white),
// decoration: InputDecoration(
// hintText: "Nazwa",
// hintStyle: const TextStyle(color: Colors.white54),
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(8),
// borderSide: BorderSide.none,
// ),
// fillColor: Colors.white24.withOpacity(0.1),
// filled: true,
// ),
// ),
// SizedBox(height: 10),
// TextField(
// controller: priceController,
// style: const TextStyle(color: Colors.white),
// decoration: InputDecoration(
// hintText: "Cena",
// hintStyle: const TextStyle(color: Colors.white54),
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(8),
// borderSide: BorderSide.none,
// ),
// fillColor: Colors.white24.withOpacity(0.1),
// filled: true,
// ),
// ),
// SizedBox(height: 20),
// GestureDetector(
// onTap: () {
// List<String> productList = [productController.text.trim()];
// List<double> priceList = [double.parse(priceController.text.trim())];
//
//
// FirebaseFirestore.instance.doc(documentId).update({'products': FieldValue.arrayUnion(productList)});
// FirebaseFirestore.instance.doc(documentId).update({'prices': FieldValue.arrayUnion(priceList)});
//
// setState(() {});
// Navigator.pop(context);
// },
// child: Container(
// alignment: Alignment.center,
// height: 50,
// decoration: BoxDecoration(
// color: const Color(0xFF4AF4F7),
// borderRadius: BorderRadius.all(Radius.circular(8)),
// ),
// child: Text("Dodaj", style: TextStyle(color: const Color(0xFF051d29), fontSize: 20))
// ),
// )
// ],
// ),
// ),
// )
// );
// },
// backgroundColor: const Color(0xFF4AF4F7),
// shape: CircleBorder(),
// child: Icon(Icons.add, color: const Color(0xFF051d29), size: 25),
// ),
