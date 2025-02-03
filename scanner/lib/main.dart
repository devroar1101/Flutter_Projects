import 'package:flutter/material.dart';
import 'js_interop.dart';
import 'dart:js' as js;
// Import the JS interop file

class ScannerWidget extends StatefulWidget {
  @override
  _ScannerWidgetState createState() => _ScannerWidgetState();
}

class _ScannerWidgetState extends State<ScannerWidget> {
  @override
  void initState() {
    super.initState();
    // Initialize the scanning functionality on widget load
    DocumentScan.initializeDWObject();
  }

  // Function to trigger loading a PDF (Base64)
  void loadPdf() {
    String base64String =
        "YOUR_BASE64_ENCODED_PDF_STRING"; // Replace with actual Base64 string
    DocumentScan.loadBase64PDF(base64String);
  }

  // Function to trigger thumbnail display
  void showThumbnailViewer() {
    DocumentScan.showThumbnail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: loadPdf,
              child: Text('Load PDF from Base64'),
            ),
            ElevatedButton(
              onPressed: showThumbnailViewer,
              child: Text('Show Thumbnails'),
            ),
            // Optionally, add a place to show images or thumbnails
            // Example: Image.asset("path_to_thumbnail.jpg")
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ScannerWidget(),
  ));
  js.context.callMethod('initializeDynamsoft');
}
