import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(PdfToImagesApp());
}

class PdfToImagesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PdfToImagesPage(),
    );
  }
}

class PdfToImagesPage extends StatefulWidget {
  @override
  _PdfToImagesPageState createState() => _PdfToImagesPageState();
}

class _PdfToImagesPageState extends State<PdfToImagesPage> {
  final Dio _dio = Dio();
  List<Map<String, dynamic>> _pages = [];
  bool _isLoading = false;

  Future<void> pickAndConvertPdf() async {
    setState(() {
      _isLoading = true;
      _pages.clear();
    });

    try {
      // Pick a PDF file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        // Get file bytes and convert to Base64
        Uint8List fileBytes = result.files.single.bytes!;
        String base64Pdf = base64Encode(fileBytes);

        // Send the Base64 to the API
        Response response = await _dio.post(
          'http://your-api-endpoint/api/pdf/convert',
          options: Options(headers: {'Content-Type': 'application/json'}),
          data: {'PdfBase64': base64Pdf},
        );

        if (response.statusCode == 200) {
          // Parse the response
          List<dynamic> data = response.data;
          setState(() {
            _pages = data
                .map((e) => {
                      'page': e['PageNumber'],
                      'image': base64Decode(e['ImageBase64']),
                    })
                .toList();
          });
        } else {
          throw Exception('Failed to convert PDF. ${response.data}');
        }
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PDF to Images')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _pages.isEmpty
              ? Center(child: Text('No images to display.'))
              : ListView.builder(
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Page ${page['page']}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.memory(page['image']),
                        ),
                      ],
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickAndConvertPdf,
        child: Icon(Icons.upload),
      ),
    );
  }
}
