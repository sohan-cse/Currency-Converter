import 'package:demo/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:demo/features/user_auth/presentation/pages/home_page.dart';
import 'package:demo/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:demo/features/user_auth/presentation/widgets/form_container_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'path/to/form_container_widget.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

final FirebaseAuthService _auth= FirebaseAuthService();

TextEditingController  _emailController=TextEditingController();
TextEditingController  _passwordController=TextEditingController();

@override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 165, 176, 237),
        title: Text("LoginPage",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),
              SizedBox(height: 30,),
              FormContainerWidget(
                controller: _emailController,
                hintText: "Email",
                ispasswordfield: false,
              ),
              SizedBox(height: 10,),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Password",
                ispasswordfield: true,
              ),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: _signIn,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.blue,
                  borderRadius: BorderRadius.circular(15)),
                  child: Center(child: Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account",style: TextStyle(color: Colors.white),),
                  SizedBox(width: 5,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SignUpPage()),(Route)=>false);
                    },
                    child: Text("SignUp",style: TextStyle(color: Colors.blue),),
                  )
                ],
              )
        
            ],
            
          ),
        ),
      ),
    );
  }

  void _signIn() async{

    //String username=_usernameController.text;
    String email=_emailController.text;
    String password=_passwordController.text;

    User? user= await _auth.signInWithEmailAndPassword(email, password);//signInWithEmailAndPassword

    if(user!=null)
    {
      print("User is successfully sign in");
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()),(Route)=>false);
    }
    else
    {
      print("Some error occured");
    }
  }
}