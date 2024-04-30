import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              // todo
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle, color: Colors.white,),
            title: Text("Login", style: TextStyle(color: Colors.white),),
            onTap: () => {
              // todo
            },
          )
        ],
      ),
    );
  }
}
