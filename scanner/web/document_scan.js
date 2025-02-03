// Ensure Dynamsoft SDK is loaded and ready before using it
function loadDynamsoftSDK() {
    if (typeof Dynamsoft !== 'undefined' && Dynamsoft.WebTwainEnv) {
      // Register the event to initialize once the WebTwain is ready
      Dynamsoft.WebTwainEnv.RegisterEvent('OnWebTwainReady', function () {
        console.log("Dynamsoft WebTwain is ready!");
  
        // Initialize the WebTwain object
        var DWObject = Dynamsoft.WebTwainEnv.GetWebTwain('dwtcontrolContainer');
  
        if (DWObject) {
          console.log("WebTwain object initialized.");
          // Perform any setup if needed
          DWObject.SetWebTwainRegion('dwtcontrolContainer'); // Specify the container
        } else {
          console.error("Failed to initialize WebTwain object.");
        }
      });
    } else {
      console.error("Dynamsoft SDK is not loaded.");
    }
  }
  
  // Function to initialize the WebTwain object and set up the scanning functionality
  function initializeDynamsoft() {
    loadDynamsoftSDK();  // Ensures the SDK is loaded and ready
  }
  
  // Function to acquire an image from the scanner
  function acquireImage() {
    var DWObject = Dynamsoft.WebTwainEnv.GetWebTwain('dwtcontrolContainer');
    if (DWObject) {
      console.log("Starting image acquisition...");
      DWObject.AcquireImage();  // Acquire image
    } else {
      console.error("WebTwain object is not available.");
    }
  }
  
  // Function to handle document scanning from Dart (called via js.context.callMethod)
  function startDocumentScan() {
    // Initialize Dynamsoft WebTwain
    initializeDynamsoft();
  
    // Wait for WebTwain to be ready, then trigger the acquisition
    var DWObject = Dynamsoft.WebTwainEnv.GetWebTwain('dwtcontrolContainer');
    if (DWObject) {
      console.log("Document scan started...");
      DWObject.AcquireImage();  // Start the scanning process
    } else {
      console.error("WebTwain object is not initialized or unavailable.");
    }
  }
  
  // Expose the methods to be called from Dart
  function exposeMethodsToDart() {
    if (typeof window !== 'undefined') {
      window.startDocumentScan = startDocumentScan;  // Make this function available for Dart
    } else {
      console.error("Window object is not available. Cannot expose methods.");
    }
  }
  
  // Initialize the methods on page load or when the SDK is available
  window.onload = function() {
    exposeMethodsToDart();  // Expose methods to Dart once the page is ready
    console.log("Dynamsoft SDK loaded and methods exposed.");
  };
  
  // Example for additional cleanup or reinitialization
  function reinitializeWebTwain() {
    var DWObject = Dynamsoft.WebTwainEnv.GetWebTwain('dwtcontrolContainer');
    if (DWObject) {
      console.log("Reinitializing WebTwain...");
      DWObject.CloseSource();  // Close any existing scanner source
      DWObject.OpenSource();   // Reopen the scanner source
    }
  }
  