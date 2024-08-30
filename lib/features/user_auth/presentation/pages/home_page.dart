import 'dart:js';

import 'package:demo/features/user_auth/presentation/pages/login_page.dart';
import 'package:demo/ui/exchange.dart';
import 'package:demo/ui/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex=0;

  Widget getView()
  {
    if(_selectedIndex==0){
      return Home();
    }
    return Exchange();
  }

  void _logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()),(Route)=>false);
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(child: Text("Currency Exchange")),
        actions: [
          IconButton(
           icon: Icon(Icons.logout),
           onPressed: ()=>_logout(context))
        ],
      ),
      body:getView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index){
          setState(() {
            _selectedIndex=index;
          });
        },
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.currency_exchange),label: "Exchange")


      ],),

       /*Center(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.baseline,
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
        
            //Text("Welcome to home Buddy",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),),
            //SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()),(Route)=>false);
              },
              child: Container(
                height: 45,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
        
                ),
                child: Center(child: Text("Sign out",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
              ),
            )
          ] 
        ),
      ),*/
    );
  }
}