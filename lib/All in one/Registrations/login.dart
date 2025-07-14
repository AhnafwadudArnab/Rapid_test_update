import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../ADMIN/adminLogin.dart';
import '../TestsFiles.dart';
import 'forgetpass.dart';
import 'signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlueAccent,
        // title: Image.asset("assets/test-tube.png", height: 30),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.86,
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20.0),
              child: const LoginFormWidget(),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  LoginFormWidgetState createState() => LoginFormWidgetState();
}

class LoginFormWidgetState extends State<LoginFormWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isVisible = true;

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
          Text(
            "Login",
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15.0),
          // Name field
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Username',
              labelStyle: TextStyle(color: Colors.black),
              prefixIcon: Icon(Icons.person, color: Colors.black),
            ),
            style: const TextStyle(color: Colors.black),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),
          // Email field
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.black),
              prefixIcon: Icon(Icons.email, color: Colors.black),
            ),
            style: const TextStyle(color: Colors.black),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          // Password field
          TextFormField(
            controller: passwordController,
            obscureText: isVisible,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: const TextStyle(color: Colors.black),
              prefixIcon: const Icon(Icons.lock, color: Colors.black),
              suffixIcon: IconButton(
                icon: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
              ),
            ),
            style: const TextStyle(color: Colors.black),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgetPassword(),
                    ),
                  );
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              //add a admin login button
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const AdminLogin()),
                  );
                },
                child: const Text(
                  'Login as Admin',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 96, 180, 219),
            ),
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                User? user = await _signInWithEmailAndPassword(
                  emailController.text,
                  passwordController.text,
                );
                if (user != null) {
                  Fluttertoast.showToast(msg: "Login successful");
                  Get.to(() => const Testsfiles());
                } else {
                  Fluttertoast.showToast(msg: "Invalid email or password");
                }
              }
            },
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),

          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SignUpPage()),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(width: 4),
                Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<User?> _signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Firestore logic removed
      return userCredential.user;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }
}
