import 'dart:js' as js;

class DocumentScan {
  // Initialize the Dynamsoft WebTwain Object
  static void initializeDWObject() {
    js.context.callMethod('initializeDWObject');
  }

  // Load PDF from base64
  static void loadBase64PDF(String base64String) {
    js.context.callMethod('DocumentScan.Base64PDF', [base64String]);
  }

  // Show thumbnails
  static void showThumbnail() {
    js.context.callMethod('DocumentScan.thumbnail');
  }

  // Update page info
  static void updatePageInfo() {
    js.context.callMethod('DocumentScan.updatePageInfo');
  }
}

void initializeDynamsoft() {
  js.context.callMethod('initializeDynamsoft');
}
