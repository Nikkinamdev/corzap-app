import 'dart:io';
import 'package:get/get.dart';

class DocumentUploadController extends GetxController {
  // RxMap for storing files by key (uploaderKey)
  RxMap<String, File?> images = <String, File?>{}.obs; // Observable map

  // Set image for specific key
  void setImage(String key, File file) {
    print("Setting image for key '$key': ${file.path}"); // Debug print
    images[key] = file;
    images.refresh(); // Force UI update
    print(
      "Current images map keys: ${images.keys.toList()}",
    ); // Debug: Keys list
  }

  // Get image by key
  File? getImage(String key) {
    final file = images[key];
    print("Getting image for key '$key': ${file?.path ?? 'NULL'}"); // Debug
    return file;
  }

  // ADD THIS: Remove image by key (for close icon)
  void removeImage(String key) {
    print("Controller removeImage for key '$key'"); // Debug
    images.remove(key);
    images.refresh(); // UI update
    print("Removed - Current keys: ${images.keys.toList()}"); // Debug
  }

  // ADD THIS: Per key validation (use in DriverRegistration too)
  bool isValid(String key) {
    final file = getImage(key);
    final bool hasPath = file != null && file.path.isNotEmpty;
    final bool fileExists = hasPath && file.existsSync();
    print(
      "Controller isValid for '$key': hasPath=$hasPath, exists=$fileExists (path: ${file?.path ?? 'NULL'})",
    );
    return hasPath; // CHANGE: Return hasPath (loose for cache)
  }

  // Clear all (for reset)
  void clearAll() {
    images.clear();
    images.refresh();
  }

  @override
  void onClose() {
    clearAll();
    super.onClose();
  }
}
