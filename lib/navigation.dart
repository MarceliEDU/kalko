import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kalko/login_view.dart';
import 'package:kalko/signup_view.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF051d29),
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.account_box, color: Colors.white,),
            title: Text("Sign Up", style: TextStyle(color: Colors.white),),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignupPage()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle, color: Colors.white,),
            title: Text("Login", style: TextStyle(color: Colors.white),),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              )
            },
          )
        ],
      ),
    );
  }
}
