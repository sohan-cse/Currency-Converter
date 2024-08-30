import 'package:demo/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:demo/features/user_auth/presentation/pages/home_page.dart';
import 'package:demo/features/user_auth/presentation/pages/login_page.dart';
import 'package:demo/features/user_auth/presentation/widgets/form_container_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'path/to/form_container_widget.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final FirebaseAuthService _auth= FirebaseAuthService();

TextEditingController  _usernameController=TextEditingController();
TextEditingController  _emailController=TextEditingController();
TextEditingController  _passwordController=TextEditingController();

@override
  void dispose() {
    _usernameController.dispose();
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
        title: Text("Sign Up",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sign Up",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),
              SizedBox(height: 30,),
              FormContainerWidget(
                controller: _usernameController,
                hintText: "Username",
                ispasswordfield: false,
              ),
              SizedBox(height: 10,),
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
                onTap: _signUp,
                //     (){
                //   Navigator.pushNamed(context, "/home");
                // },

                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),),
                  child: Center(child: Text("Sign Up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                ),

              ),
              SizedBox(height: 30,),
             
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account",style: TextStyle(color: Colors.white),),
                  SizedBox(width: 5,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()),(Route)=>false);
                    },
                    child: Text("Login",style: TextStyle(color: Colors.blue),),
                  )
                ],
              )
        
            ],
            
          ),
        ),
      ),
    );
  }


  void _signUp() async{

    String username=_usernameController.text;
    String email=_emailController.text;
    String password=_passwordController.text;

    User? user= await _auth.signUpWithEmailAndPassword(email, password);

    if(user!=null)
    {
      print("User is successfully created");

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()),(Route)=>false);
    }
    else
    {
      print("Some error occured");
    }
  }
}