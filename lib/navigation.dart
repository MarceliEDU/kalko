import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kalko/screens/login_screen.dart';
import 'package:kalko/screens/signup_screen.dart';

class NavBar extends StatefulWidget {
  NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final String? navTop = FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser?.email : "User not found";

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
    return Drawer(
      backgroundColor: Color(0xFF051d29),
      child: ListView(
        children: [
          Container(
            height: 55,
            color: Color(0xFF4AF4F7),
            child: Center(child:
              Text(_currentUser != null ? _currentUser!.email! : "Welcome!",
                style: TextStyle(
                  color: Color(0xFF051d29),
                  fontWeight: FontWeight.bold,
                  fontSize: 18
              ),)
            ),
          ),

          userDependent(_currentUser != null, context)

        ],
      ),
    );
  }
}

ListTile userDependent(bool isLogged, context) {
  if(isLogged){
    return ListTile(
      leading: Icon(Icons.logout, color: Colors.white,),
      title: Text("Logout", style: TextStyle(color: Colors.white),),
      onTap: () => {
        FirebaseAuth.instance.signOut()
      },
    );
  } else {
    return ListTile(
      leading: Icon(Icons.account_circle, color: Colors.white,),
      title: Text("Login", style: TextStyle(color: Colors.white),),
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        )
      },
    );
  }
}
