import 'dart:convert' show jsonEncode;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../Registrations/login.dart';
import '../TestsFiles.dart';

class AddTestsWidget extends StatelessWidget {
  const AddTestsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const AddTestsPage();
  }
}

class AddTestsPage extends StatefulWidget {
  const AddTestsPage({super.key});

  @override
  _AddTestsPageState createState() => _AddTestsPageState();
}

class _AddTestsPageState extends State<AddTestsPage> {
  List<TestForm> testForms = [TestForm()];

  void addTestForm() {
    setState(() => testForms.add(TestForm()));
  }

  void removeTestForm(int index) {
    setState(() => testForms.removeAt(index));
  }

  Future<void> submitTests() async {
    List<Map<String, String>> testData = testForms.map((form) {
      return {
        "name": form.nameController.text,
        "code": form.codeController.text,
        "modelCode": form.modelCodeController.text,
        "modelUrl": form.modelUrlController.text,
        "description": form.desController.text,
        "hint": form.hintController.text,
        "slug": form.slugController.text,
      };
    }).toList();

    final url = Uri.parse(
        "https://e112-103-135-252-94.ngrok-free.app/admin/rapid_test/test/add/");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"tests": testData}),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Tests submitted successfully!",
            snackPosition: SnackPosition.BOTTOM);
            if (kDebugMode) {
              print("success_Url:$url");
            }
      } else { if (kDebugMode) {
              print("from else-Url:$url");
            }
        Get.snackbar("Error", "Failed to submit tests: ${response.body}",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
       if (kDebugMode) {
              print("from catch(e)Url:$url");
            }
      Get.snackbar("Error", "An error occurred: $e",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue.withOpacity(0.8),
        title: const Text("Add Tests for Patients"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () {
              Get.to(() => const Login(), transition: Transition.rightToLeft);
            },
          ),
        ],
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
              height: MediaQuery.of(context).size.height / 1.5,
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              padding: const EdgeInsets.all(20.0),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: testForms.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.all(12),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                testForms[index],
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (testForms.length > 1)
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () => removeTestForm(index),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        heroTag: "add",
                        onPressed: addTestForm,
                        tooltip: "Add another test",
                        child: const Icon(Icons.add),
                      ),
                      FloatingActionButton(
                        heroTag: "submit",
                        onPressed: () {
                          List<Map<String, String>> testData =
                              testForms.map((form) {
                                return {
                                  "name": form.nameController.text,
                                  "code": form.codeController.text,
                                  "modelCode": form.modelCodeController.text,
                                  "modelUrl": form.modelUrlController.text,
                                  "description": form.desController.text,
                                  "hint": form.hintController.text,
                                  "slug": form.slugController.text,
                                };
                              }).toList();
                              
                          Get.to(
                            () => const Testsfiles(),
                            arguments: testData,
                            transition: Transition.rightToLeft,
                          );
                        },
                        tooltip: "Submit tests",
                        child: const Icon(Icons.check),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TestForm extends StatelessWidget {
  final TextEditingController imgupController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController modelCodeController = TextEditingController();
  final TextEditingController modelUrlController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  final TextEditingController hintController = TextEditingController();
  final TextEditingController slugController = TextEditingController();

  TestForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // buildImageUploadField(
        //   "Upload an image for test details",
        //   imgupController,
        // ),
        buildField("Name", nameController),
        buildField("Code", codeController),
        buildField("Model Code", modelCodeController),
        buildField("Model URL", modelUrlController),
        buildField("Description", desController),
        buildField("Hint", hintController, maxLines: 3),
        buildField("Slug", slugController),
      ],
    );
  }

  Widget buildField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildImageUploadField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: true,
              decoration: InputDecoration(
                labelText: label,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: () async {
              final pickedFile = await ImagePicker().pickImage(
                source: ImageSource.gallery,
              );
              if (pickedFile != null) {
                controller.text = pickedFile.path;
              }
            },
          ),
        ],
      ),
    );
  }
}
