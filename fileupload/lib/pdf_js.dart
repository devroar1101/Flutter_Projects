@JS()
import 'package:js/js.dart';

// Define the interop for pdf.js
@JS('window.pdfjsLib')
external dynamic get pdfjsLib;

@JS()
class PDFDocumentProxy {
  external int get numPages;
  external Future<PDFPageProxy> getPage(int pageNumber);
}

@JS()
class PDFPageProxy {
  external Future<void> render(Map<String, dynamic> params);
  external double get width;
  external double get height;
}

@JS()
external Future<PDFDocumentProxy> getDocument(dynamic pdfData);
