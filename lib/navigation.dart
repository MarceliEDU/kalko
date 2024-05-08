import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kalko/screens/login_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

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
      backgroundColor: const Color(0xFF051d29),
      child: ListView(
        children: [
          Container(
            height: 55,
            color: const Color(0xFF4AF4F7),
            child: Center(child:
              Text(_currentUser != null ? _currentUser!.email! : "Welcome!",
                style: const TextStyle(
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
      leading: const Icon(Icons.logout, color: Colors.white,),
      title: const Text("Log out", style: TextStyle(color: Colors.white),),
      onTap: () => {
        FirebaseAuth.instance.signOut()
      },
    );
  } else {
    return ListTile(
      leading: const Icon(Icons.account_circle, color: Colors.white,),
      title: const Text("Log in", style: TextStyle(color: Colors.white),),
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        )
      },
    );
  }
}
