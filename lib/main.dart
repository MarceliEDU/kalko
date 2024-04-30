import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'navigation.dart';

void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GetMaterialApp(
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

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF051d29),
      drawer: NavBar(),
      appBar: AppBar(
        title: Text("KALKO", style: TextStyle(color: Color(0xFF051d29))),
        //centerTitle: true,
        backgroundColor: const Color(0xFF4AF4F7),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_box, color: Color(0xFF051d29),),
            tooltip: 'Profile',
            onPressed: () {
              // handle the press
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Text("formularz"),
          Text("lista")
        ],
      ),
    );
  }
}
