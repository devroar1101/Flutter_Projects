import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_twain_scanner/dynamsoft_service.dart';
import 'package:testscanner/thumbnail_page.dart';

void main() {
  runApp(ScannerApp());
}

class ScannerApp extends StatefulWidget {
  @override
  _ScannerAppState createState() => _ScannerAppState();
}

class _ScannerAppState extends State<ScannerApp> {
  final DynamsoftService dynamsoftService = DynamsoftService();
  String host = 'http://127.0.0.1:18622'; // Ensure this host is correct

  List<Map<String, dynamic>> devices = [];
  List<String> scannerNames = [];
  String? _selectedScanner;
  List<Uint8List> imagePaths = [];

  // Use GlobalKey to safely access the Navigator
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey, // Set the navigator key
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Scanner App'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Button to List Scanners
              MaterialButton(
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: _listScanners,
                child: const Text('List Scanners'),
              ),
              const SizedBox(height: 20),

              // Dropdown to Select Scanner
              DropdownButton<String>(
                value: scannerNames.contains(_selectedScanner)
                    ? _selectedScanner
                    : null,
                hint: const Text("Select a Scanner"),
                items: scannerNames
                    .map((name) => DropdownMenuItem(
                          value: name,
                          child: Text(name),
                        ))
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedScanner = newValue;
                    print("Selected Scanner: $_selectedScanner"); // Debug log
                  });
                },
              ),
              const SizedBox(height: 20),

              // Button to Scan Document
              MaterialButton(
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: _selectedScanner != null ? _startScan : null,
                child: const Text('Scan Document'),
              ),
              const SizedBox(height: 20),

              // Display Scanned Images in a scrollable view
              Expanded(
                child: imagePaths.isEmpty
                    ? Center(child: Image.asset('images/default.png'))
                    : SingleChildScrollView(
                        child: Column(
                          children: imagePaths
                              .map((image) => Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.memory(
                                      image,
                                      fit: BoxFit.cover,
                                      height: 600,
                                      width: 600,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
              ),

              // Button to Navigate to Thumbnails Page
              MaterialButton(
                textColor: Colors.white,
                color: Colors.green,
                onPressed: imagePaths.isNotEmpty ? _navigateToThumbnails : null,
                child: const Text('Navigate to Thumbnails'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to List Scanners
  Future<void> _listScanners() async {
    try {
      print("Listing scanners..."); // Debug log
      final scanners = await dynamsoftService.getDevices(
        host,
        ScannerType.TWAINSCANNER | ScannerType.TWAINX64SCANNER,
      );

      devices.clear();
      scannerNames.clear();

      // Add scanners and avoid duplicates in scannerNames
      for (var scanner in scanners) {
        if (!scannerNames.contains(scanner['name'])) {
          devices.add(scanner);
          scannerNames.add(scanner['name']);
        }
      }

      setState(() {
        if (scannerNames.isNotEmpty) {
          _selectedScanner = scannerNames[0];
        }
      });
      print("Scanners found: $scannerNames"); // Debug log
    } catch (error) {
      print('An error occurred: $error');
    }
  }

  // Function to Start Document Scan
  Future<void> _startScan() async {
    print("Scan Document button pressed..."); // Debug log
    if (_selectedScanner != null) {
      int index = scannerNames.indexOf(_selectedScanner!);
      await _scanDocument(index);
    }
  }

  // Function to Scan Document
  Future<void> _scanDocument(int index) async {
    print(
        "Starting scan for scanner: ${devices[index]['device']}"); // Debug log
    final Map<String, dynamic> parameters = {
      'license':
          't01898AUAAFI2dqdd6qhAtJwiVbIp3yqHm5pca2Zjq8ifagRJqUBodcZouee2X5hR39JwyO7iYhwFJ6EhrEisEZjbDoEDHbbdfjnVwGn1nYb6TjZw6pITeEzDOJ92+MblAGXgOQG2XocVYAnMueyAoVtyowfIA8wBzMuBHnC6iuPmC/sCKf/+c6CjUw2cVt9ZFkgdJxs4dcmZCqSPCO+02vdcICxvzgaQB9gpwOUhOxQI9oA8wA5AIKIF0wcsczF3',
      'device': devices[index]['device'],
    };

    parameters['config'] = {
      'IfShowUI': false,
      'PixelType': 2,
      'Resolution': 200,
      'IfFeederEnabled': false,
      'IfDuplexEnabled': false,
    };

    try {
      final String jobId =
          await dynamsoftService.scanDocument(host, parameters);

      print("Scan job started with jobId: $jobId"); // Debug log
      if (jobId != '') {
        List<Uint8List> paths =
            await dynamsoftService.getImageStreams(host, jobId);
        await dynamsoftService.deleteJob(host, jobId);

        if (paths.isNotEmpty) {
          setState(() {
            imagePaths.insertAll(0, paths); // Insert new images at the top
          });
          print("Scan completed and images loaded"); // Debug log
        }
      }
    } catch (error) {
      print('An error occurred while scanning: $error');
    }
  }

  // Function to Navigate to Thumbnails Page
  void _navigateToThumbnails() {
    // Pass image blobs (Uint8List) directly to the next screen
    _navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => ImageThumbnailPage(imagePaths: imagePaths),
      ),
    );
  }
}
