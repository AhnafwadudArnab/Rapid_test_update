import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'RTpage.dart';
import 'Registrations/signup.dart';
import 'TestsFiles.dart';

// ignore: must_be_immutable
class ProfileDash extends StatefulWidget {
  const ProfileDash({super.key});

  @override
  State<ProfileDash> createState() => _ProfileDashState();
}

class _ProfileDashState extends State<ProfileDash> {
  String profileImagePath = 'assets/profiledemo.png';
  TextEditingController profileImageController = TextEditingController();

  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
      if (doc.exists) {
        setState(() {
          userData = doc.data();
          isLoading = false;
        });
      } else {
        setState(() {
          userData = null;
          isLoading = false;
        });
      }
    } else {
      setState(() {
        userData = null;
        isLoading = false;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        profileImageController.text = pickedFile.path;
      });
      profileImagePath = pickedFile.path;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 82, 156, 199),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  'assets/profiledemo.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Testsfiles()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Handle the settings tap here
              },
            ),
            ListTile(
              leading: Icon(Icons.person_outline_rounded),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileDash()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.add_chart_rounded),
              title: Text('Results'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => RTpage(
                          imagePath: '',
                          slug: '',
                          Name: '',
                          description: '',
                          code: '',
                          analysisData: '',
                        ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('About Us'),
              onTap: () {
                // Handle the settings tap here
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
            ),
          ],
        ),
      ),
      //profile details container//
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : userData == null
              ? const Center(child: Text('No profile data found.'))
              : Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/bg.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.45,
                            margin: EdgeInsets.all(9),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color(0xFF89A8B2),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],

                              
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.asset(
                                    'assets/profiledemo.png',
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 7),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Name: ',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: userData?['name'] ?? '',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 7),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Email: ',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: userData?['email'] ?? '',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 7),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Phone Number: ',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: userData?['phone'] ?? '',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 7),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Blood Group:  ',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: userData?['bloodGroup'] ?? '',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 7),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Bio: ',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: userData?['bio'] ?? '',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 7),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Address: ',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: userData?['address'] ?? '',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 7),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // TODO: Implement profile editing and update Firestore
                                      },
                                      child: Icon(Icons.edit),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          TakeAtest(),
                          SizedBox(height: 10),
                          TestHistory(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}

class TakeAtest extends StatelessWidget {
  const TakeAtest({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.12,
        decoration: BoxDecoration(
          color: Color(0xffE5E1DA),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'If you have not taken any tests yet.',
              style: TextStyle(
                fontSize: 19,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Testsfiles()),
                );
              },
              child: Text('Take a Test'),
            ),
          ],
        ),
      ),
    );
  }
}

class TestHistory extends StatelessWidget {
  const TestHistory({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample test history data
    final List<Map<String, String>> testHistories = [
      {'date': '2023-01-01', 'score': '85%', 'TestName': 'Malaria Test'},
      {'date': '2023-01-15', 'score': '90%', 'TestName': 'Blood Test'},
      {'date': '2023-02-01', 'score': '78%', 'TestName': 'Urine Test'},
      {'date': '2023-02-15', 'score': '95%', 'TestName': 'Sugar Test'},
      {'date': '2023-03-15', 'score': '88%', 'TestName': 'Cholesterol Test'},
      {'date': '2023-04-01', 'score': '92%', 'TestName': 'HIV Test'},
      {'date': '2023-04-15', 'score': '85%', 'TestName': 'COVID-19 Test'},
      {'date': '2023-05-01', 'score': '90%', 'TestName': 'Hepatitis Test'},
      {'date': '2023-05-15', 'score': '78%', 'TestName': 'Typhoid Test'},
    ];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => RTpage(
                  imagePath: '',
                  slug: '',
                  Name: '',
                  description: '',
                  code: '',
                  analysisData: '',
                ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          color: Color(0xffB3C8CF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Text(
                'Test Histories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: testHistories.length,
                  itemBuilder: (context, index) {
                    final test = testHistories[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 11),
                      child: ListTile(
                        title: Text('Test: ${test['TestName']}'),
                        subtitle: Text(
                          'Date: ${test['date']} - Score: ${test['score']}',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//API CALL//

class ApiCall {
  static const String baseUrl =
      'http://127.0.0.1:8000/'; // Base URL of your API
  static const String api = 'api/';
  static const String userProfile =
      'profile/'; // Assuming user profile endpoint is api/profile/

  // Method to get user profile data
  static Future<Map<String, dynamic>> getUserProfile(String token) async {
    final Uri url = Uri.parse('$baseUrl$api$userProfile');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        }, // Assuming Bearer token authentication
      );

      if (response.statusCode == 200) {
        // Parse the response if it's successful
        return json.decode(response.body);
      } else {
        throw Exception(
          'Failed to load user profile. Status code: ${response.statusCode}',
        );
      }
    } catch (error) {
      throw Exception('Failed to get user profile: $error');
    }
  }

  // Method to update user profile data
  static Future<Map<String, dynamic>> updateUserProfile(
    String token,
    Map<String, dynamic> data,
  ) async {
    final Uri url = Uri.parse('$baseUrl$api$userProfile');

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(
          data,
        ), // Assuming 'data' contains the profile fields to be updated
      );

      if (response.statusCode == 200) {
        // Parse the response if it's successful
        return json.decode(response.body);
      } else {
        throw Exception(
          'Failed to update user profile. Status code: ${response.statusCode}',
        );
      }
    } catch (error) {
      throw Exception('Failed to update user profile: $error');
    }
  }
}
