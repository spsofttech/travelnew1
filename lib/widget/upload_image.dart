import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FireBaseImageUpload {
  FireBaseImageUpload._();

  static final FireBaseImageUpload fireBaseImageUpload = FireBaseImageUpload._();

  final storage = FirebaseStorage.instance;

  final storageRef = FirebaseStorage.instance.ref();

  Future<String> userUploadImage({required String fileImagePath, required String folderPath}) async {
    String url = "";
    Reference referenceRoot = storage.ref();
    Reference referenceDirImages = referenceRoot.child(folderPath);
    Reference referenceImageUpload = referenceDirImages.child(DateTime.now().microsecondsSinceEpoch.toString());
    try {
      await referenceImageUpload.putFile(File(fileImagePath));
      url = await referenceImageUpload.getDownloadURL();
    } catch (error) {
      print("----------error -0)))))$error");
    }
    // .then((res) async{
    //     url = await res.ref.getDownloadURL();
    // });

    // FirebaseStorage storage = FirebaseStorage.instance;
    // Reference ref = storage.ref().child("image1${DateTime.now()}");
    // UploadTask uploadTask = ref.putFile(File(fileImagePath));
    // uploadTask.then((res) async{
    //   print("-----------------upload_successfully");
    //   url = await res.ref.getDownloadURL();
    // });
    return url;
  }
}

class FirebaseFolderPath {
  static const String userImageUpload = "userProfile";
  // static const String createGroundImagesUpload = "createground";
  // static const String insertCoach = "insertcoach";
  // static const String CoachCertificates = "CoachCertificates";
  // static const String createTeam = "createTeam";
  // static const String startTournament = "startTournament";
  // static const String ads = "ads";
}
