import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var uid = Uuid().v4();

  Future<String> uploadImageToStorage(String name, File file) async {
    try {
      print("Starting upload process...");

      // Check if the file exists
      if (!file.existsSync()) {
        throw Exception("File does not exist at path: ${file.path}");
      }

      print("File path: ${file.path}");

      // Get a reference to the location where the file will be uploaded
      Reference ref = _storage.ref().child(name).child(_auth.currentUser!.uid).child(uid);
      print("Firebase Storage Reference: ${ref.fullPath}");

      // Start the file upload
      UploadTask uploadTask = ref.putFile(file);

      // Monitor the upload task
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        print('Task state: ${snapshot.state}');
        print('Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
      });

      // Wait for the upload to complete
      TaskSnapshot snapshot = await uploadTask;
      print("Upload complete. Retrieving download URL...");

      // Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print("Download URL: $downloadUrl");

      return downloadUrl;
    } on FirebaseException catch (e) {
      print("FirebaseException: ${e.message}");
      throw Exception("Failed to upload image: ${e.message}");
    } catch (e) {
      print("Exception: $e");
      throw Exception("Failed to upload image: $e");
    }
  }
}
