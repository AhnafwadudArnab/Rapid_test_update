import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myproject/OnBoard/frontpage.dart';
import 'Profilepage.dart';
import 'RTpage.dart';
import 'analysis_page.dart';

class Testsfiles extends StatefulWidget {
  const Testsfiles({super.key});

  @override
  State<Testsfiles> createState() => _TestsfilesState();
}

//1st page//
class _TestsfilesState extends State<Testsfiles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<Map<String, String>> tests = [
    {
      "name": "Covid-19 Test",
      "image": "assets/covid19.jpg",
      "description":
          "A COVID-19 test kit checks for the virus using a swab or saliva sample. It includes rapid, PCR, or antibody tests, giving results in minutes or hours for detection and monitoring.",
      'Slug': 'covid19_c-19',
      'code': 'C19',
    },
    {
      "name": "HIV Rapid Test",
      "image": "assets/HIV.jpg",
      "description":
          "An HIV rapid test detects antibodies or antigens in blood or oral fluid, providing results within minutes to determine HIV status.",
      'Slug': 'hiv_rapid_test',
      'code': 'HIV',
    },
    {
      "name": "Malaria Rapid Test",
      "image": "assets/malaria.png",
      "description":
          "A malaria rapid test identifies malaria antigens in blood, offering quick results for diagnosing infection.",
      'Slug': 'malaria_rapid_test',
      'code': 'MAL',
    },
    {
      "name": "Dengue Rapid Test",
      "image": "assets/dengue.png",
      "description":
          "Dengue rapid tests detect dengue virus antigens or antibodies in blood, providing quick diagnosis for dengue fever.",
      'Slug': 'dengue_rapid_test',
      'code': 'DEN',
    },
    {
      "name": "Influenza (Flu) Test",
      "image": "assets/influenza.jpg",
      "description":
          "Flu rapid tests detect influenza viruses in respiratory specimens, delivering results within minutes for fast diagnosis.",
      'Slug': 'influenza_flu_test',
      'code': 'FLU',
    },
    {
      "name": "Pregnancy Test",
      "image": "assets/pregnency.jpeg",
      "description":
          "A pregnancy test detects hCG hormone in urine or blood, confirming pregnancy quickly and accurately.",
      'Slug': 'pregnancy_test',
      'code': 'PGT',
    },
    {
      "name": "Ovulation (LH) Test",
      "image": "assets/LH.png",
      "description":
          "An ovulation test detects LH surge in urine, predicting the most fertile days for conception.",
      'Slug': 'ovulation_lh_test',
      'code': 'OVT',
    },
    {
      "name": "Thyroid (TSH) Test",
      "image": "assets/Thyroid (TSH) Test.jpg",
      "description":
          "A TSH rapid test measures thyroid-stimulating hormone levels to assess thyroid function.",
      'Slug': 'thyroid_tsh_test',
      'code': 'TSH',
    },
    {
      "name": "Blood Glucose Test",
      "image": "assets/Blood Glucose Test.jpg",
      "description":
          "A glucose rapid test measures blood sugar levels for diabetes monitoring and management.",
      'Slug': 'blood_glucose_test',
      'code': 'BGT',
    },
    {
      "name": "HbA1c Test",
      "image": "assets/HbA1c Test.jpg",
      "description":
          "The HbA1c test checks average blood sugar levels over the past 2-3 months for diabetes control.",
      'Slug': 'hba1c_test',
      'code': 'HBA',
    },
    {
      "name": "Drug Abuse Test",
      "image": "assets/Drug Abuse Test.jpg",
      "description":
          "A drug abuse rapid test screens for multiple drugs in urine, providing quick detection of substance use.",
      'Slug': 'drug_abuse_test',
      'code': 'DAT',
    },
    {
      "name": "Troponin I Test",
      "image": "assets/Troponin I Test.jpg",
      "description":
          "A Troponin I test detects heart damage, helping diagnose heart attacks quickly.",
      'Slug': 'troponin_i_test',
      'code': 'TNT',
    },
    {
      "name": "Kidney Function Test",
      "image": "assets/Kidney Function Test.jpg",
      "description":
          "A kidney function rapid test assesses creatinine levels to monitor kidney health.",
      'Slug': 'kidney_function_test',
      'code': 'KFT',
    },
    {
      "name": "PSA (Prostate Cancer) Test",
      "image": "assets/PSA (Prostate Cancer) Test.jpg",
      "description":
          "A PSA rapid test measures prostate-specific antigen levels to screen for prostate cancer.",
      'Slug': 'psa_prostate_cancer_test',
      'code': 'PSA',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _signOut() async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );
      await _auth.signOut();
      Get.to(Onboard());
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rapid Test Details',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.lightBlue,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 30, 164, 226),

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
              tileColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.person_outline_rounded),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileDash()),
                );
              },
              tileColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.add_chart_rounded),
              title: Text('Results'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const Center(child: CircularProgressIndicator());
                  },
                );
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
              tileColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Us'),
              onTap: () {
                // Handle the settings tap here
              },
              tileColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: _signOut,
              tileColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Container(
            //bg color//
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bluebg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ...tests.map(
                  (test) => Container(
                    width: MediaQuery.of(context).size.width * 0.86,
                    height: MediaQuery.of(context).size.height * 0.290,
                    margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 225, 230, 238),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          child: Image.asset(
                            test["image"]!,
                            width: 355,
                            height: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                test["name"]!,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(228, 41, 150, 201),
                                ),
                              ),
                              Text(
                                test["description"]!,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => AnalysisPage(
                                              slug: test['Slug']!,
                                              Name: test['name']!,
                                              description: test['description']!,
                                              code: test['code']!,
                                            ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    iconColor: const Color.fromARGB(
                                      255,
                                      127,
                                      175,
                                      214,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 30,
                                      vertical: 12,
                                    ),
                                  ),
                                  child: Text(
                                    "Scan",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
