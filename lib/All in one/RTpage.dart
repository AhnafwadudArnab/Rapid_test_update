import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'TestsFiles.dart';

class RTpage extends StatefulWidget {
  final String imagePath;
  final String slug;
  final String analysisData;

  const RTpage({
    super.key,
    required this.imagePath,
    required this.slug,
    required this.analysisData,
    required String Name,
    required String description,
    required String code,
  });

  @override
  State<RTpage> createState() => _RTpageState();
}

class _RTpageState extends State<RTpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Analysis'),
        centerTitle: true,
        backgroundColor: const Color(0xFFEEF5FF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Testsfiles()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Test Result Container
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFB4D4FF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 162, 184, 212),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              'Analysis Result',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Display Captured Image
                            widget.imagePath.isNotEmpty
                                ? Image.file(
                                  File(widget.imagePath),
                                  height: 200,
                                  width: 240,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 200,
                                      width: 240,
                                      color: Colors.grey[300],
                                      child: const Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.broken_image,
                                              size: 48,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              'Image not found',
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                                : Container(
                                  height: 200,
                                  width: 240,
                                  color: Colors.grey[300],
                                  child: const Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.image_not_supported,
                                          size: 48,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'No image selected',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            // Extracted Text Display
                            const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildResultWidget(widget.analysisData),
                              ],
                            ),
                            // const SizedBox(height: 10),
                            // const Text(
                            //   'Object Detected: ',
                            //   style: TextStyle(color: Colors.white, fontSize: 18),
                            // ),
                            // const SizedBox(height: 10),
                            // const Text(
                            //   'Confidence level: ',
                            //   style: TextStyle(color: Colors.white, fontSize: 18),
                            // ),
                            // const SizedBox(height: 10),
                            // const Text(
                            //   'Dominant Color: ',
                            //   style: TextStyle(color: Colors.white, fontSize: 18),
                            // ),
                            // const SizedBox(height: 10),
                            // const Text(
                            //   'Environment: ',
                            //   style: TextStyle(color: Colors.white, fontSize: 18),
                            // ),
                            // const SizedBox(height: 10),
                            // const Text(
                            //   'Summary: ',
                            //   style: TextStyle(color: Colors.white, fontSize: 18),
                            // ),
                          ],
                        ),
                      ),
                      // Statistical Report Container
                      //   Container(
                      //     width: MediaQuery.of(context).size.width * 0.8,
                      //     margin: const EdgeInsets.all(16),
                      //     padding: const EdgeInsets.all(16),
                      //     decoration: BoxDecoration(
                      //       color: const Color(0xFF176B87),
                      //       borderRadius: BorderRadius.circular(10),
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: Colors.black.withOpacity(0.5),
                      //           spreadRadius: 2,
                      //           blurRadius: 5,
                      //           offset: const Offset(0, 3),
                      //         ),
                      //       ],
                      //     ),
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: const [
                      //         Text(
                      //           'Statistical Report',
                      //           style: TextStyle(
                      //             color: Colors.white,
                      //             fontSize: 24,
                      //           ),
                      //         ),
                      //         SizedBox(height: 10),
                      //         Text(
                      //           'Percentage: 85%',
                      //           style: TextStyle(
                      //             color: Colors.white,
                      //             fontSize: 18,
                      //           ),
                      //         ),
                      //         SizedBox(height: 10),
                      //         LinearProgressIndicator(
                      //           value: 0.85,
                      //           backgroundColor: Colors.white,
                      //           valueColor: AlwaysStoppedAnimation<Color>(
                      //             Colors.blue,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ApiService {
  static String baseUrl = "http://127.0.0.1:8000/rapid_tests/test-result/";

  static Future<Map<String, dynamic>?> analyzeImage(
    String imageUrl,
    String slug,
  ) async {
    var request = http.MultipartRequest("POST", Uri.parse("$baseUrl$slug/"));

    request.fields['imageUrl'] = imageUrl;

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      return json.decode(responseData);
    } else {
      if (kDebugMode) {
        print("Failed to analyze image: ${response.statusCode}");
      }
      return null;
    }
  }
}

Widget _buildResultWidget(String analysisData) {
  if (analysisData.isEmpty) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'No analysis data available.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ),
    );
  }
  try {
    Map<String, dynamic> data = jsonDecode(analysisData);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Analysis Result',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...data.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Text(
                        '${entry.key}: ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          '${entry.value}',
                          style: const TextStyle(color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  } catch (e) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Invalid analysis data.',
            style: TextStyle(fontSize: 16, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
