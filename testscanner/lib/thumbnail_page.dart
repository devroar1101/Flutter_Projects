import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/foundation.dart';
import 'dart:html' as html; // For web download functionality
import 'package:path_provider/path_provider.dart'; // For storing PDFs on mobile platforms
import 'dart:io';

class ImageThumbnailPage extends StatelessWidget {
  final List<Uint8List> imagePaths; // List of image blobs (Uint8List)

  ImageThumbnailPage({Key? key, required this.imagePaths}) : super(key: key);

  // Function to generate PDF from images
  Future<void> _generatePDF(BuildContext context) async {
    // Create a new PDF document
    final pdf = pw.Document();

    try {
      // Add each image to a new page in the PDF
      for (var imageData in imagePaths) {
        final image = pw.MemoryImage(imageData);
        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Image(image); // Add the image to the page
            },
          ),
        );
      }

      // Save the PDF to a file
      final pdfBytes = await pdf.save();

      if (kIsWeb) {
        // Web download logic
        final blob = html.Blob([pdfBytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..target = 'blank'
          ..download = 'scanned_images.pdf' // File name for download
          ..click(); // Trigger download
        html.Url.revokeObjectUrl(url);
      } else {
        // Mobile download logic (Android/iOS)
        final directory = await getExternalStorageDirectory();
        if (directory != null) {
          final file = File('${directory.path}/scanned_images.pdf');
          await file.writeAsBytes(pdfBytes);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('PDF saved to ${file.path}')),
          );
        }
      }
    } catch (e) {
      print('Error generating PDF: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating PDF')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Thumbnails'),
        actions: [
          // Add the download button
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              _generatePDF(context); // Call the generate PDF function
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return Card(
            child: Center(
              child: Image.memory(
                imagePaths[index], // Display each image from the Uint8List
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
