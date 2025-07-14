// ignore_for_file: unnecessary_string_interpolations
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myproject/API%20CALL/server.dart';
import 'package:myproject/API%20CALL/config.dart';

import 'RTpage.dart';

class AnalysisPage extends StatefulWidget {
  final String slug;
  final String Name;
  final String description;
  final String code;

  const AnalysisPage({
    super.key,
    required this.slug,
    required this.Name,
    required this.description,
    required this.code,
  });

  @override
  _AnalysisPageState createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;
  late String _selectedTestType = ['ml', 'non_ml'][0];

  @override
  void initState() {
    super.initState();
    _pickImage(ImageSource.camera);
  }

  Future<void> uploadImage() async {
    if (image == null || _selectedTestType.isEmpty) {
      _showSnackBar(
        image == null ? 'No image selected.' : 'Please select a test type.',
      );
      return;
    }

    // Check if image file still exists (good for cache handling)
    if (!await File(image!.path).exists()) {
      _showSnackBar('Selected image no longer exists.');
      return;
    }

    // Check network connectivity
    try {
      final testUri = Uri.parse(AppConfig.baseUrl);
      final testResponse = await http.get(testUri).timeout(
        const Duration(seconds: 5),
      );
      if (testResponse.statusCode != 200 && testResponse.statusCode != 404) {
        _showSnackBar('Network connectivity issue. Please check your connection.');
        return;
      }
    } catch (e) {
      _showSnackBar('Cannot reach server. Please check your internet connection.');
      if (kDebugMode) print('Network test failed: $e');
      return;
    }

    setState(() => showSpinner = true);

    try {
      final uri = Uri.parse('${AppConfig.testDetectUrl}${widget.slug}/');

      final request =
          http.MultipartRequest('POST', uri)
            ..headers.addAll({'Accept': 'application/json'})
            ..fields['test_type'] = _selectedTestType
            ..files.add(
              await http.MultipartFile.fromPath(
                'image',
                image!.path,
                contentType: MediaType('image', 'jpeg'),
              ),
            );

      if (kDebugMode) {
        print("Request URL: $uri");
        print("Headers: ${request.headers}");
        print("Fields: ${request.fields}");
        print("File Path: ${image!.path}");
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final result = jsonDecode(responseBody);

        if (result is Map<String, dynamic>) {
          if (kDebugMode) {
            print("Success: $result");
          }

          _showSnackBar('Image uploaded successfully!');

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) => RTpage(
                    imagePath: image!.path,
                    slug: widget.slug,
                    Name: widget.Name,
                    description: widget.description,
                    code: widget.code,
                    analysisData: jsonEncode(result),
                  ),
            ),
          );
        } else {
          _showSnackBar('Unexpected response format.');
          if (kDebugMode) print('Invalid response structure: $result');
        }
      } else {
        _showSnackBar('Upload failed. Server error: ${response.statusCode}');
        if (kDebugMode) {
          print('Server responded with error. URL: $uri');
          print('Response body: $responseBody');
          print('Response headers: ${response.headers}');
        }
      }
    } catch (e) {
      _showSnackBar('An error occurred. Please try again.');
      if (kDebugMode) print('Exception during upload: $e');
    } finally {
      setState(() => showSpinner = false);
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final imagePath = pickedFile.path;
      final isConfirmed = await _showConfirmationDialog(imagePath);
      if (isConfirmed) {
        setState(() {
          image = File(imagePath);
        });
        await uploadImage();
      } else {
        setState(() {
          image = null;
        });
        _showSnackBar('Image selection cancelled.');
      }
    }
  }

  Future<bool> _showConfirmationDialog(String imagePath) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: AlertDialog(
                title: const Text('Confirm Image'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.file(File(imagePath)),
                    const SizedBox(height: 10),
                    const Text('Select analysis type:'),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedTestType,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedTestType = newValue;
                          });
                        }
                      },
                      items:
                          ['ml', 'non_ml'].map((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value.toUpperCase()),
                            );
                          }).toList(),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Retake'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            );
          },
        ) ??
        false;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(title: const Text('Choose Image')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (image != null) ...[
                Image.file(image!, height: 200),
                const SizedBox(height: 20),
              ],
              _buildCaptureButton(ImageSource.camera, 'Capture Image'),
              _buildCaptureButton(
                ImageSource.gallery,
                'Select Image from Gallery',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCaptureButton(ImageSource source, String text) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: () => _pickImage(source),
        child: Padding(padding: const EdgeInsets.all(10.0), child: Text(text)),
      ),
    );
  }
}
