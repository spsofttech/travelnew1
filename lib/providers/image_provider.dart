import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as j;
import 'package:provider/provider.dart';


class PhotoProvider with ChangeNotifier {

  // setData(BuildContext context, String colName, dynamic data) async {
  //   return await FirebaseFirestore.instance.collection(colName).add(data);
  // }
  final ImagePicker picker = ImagePicker();
  late ImageSource? imageSource;

  Future<void> selectPhoto(BuildContext context) async {
    return await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text("Camera"),
                onTap: () async {
                  Navigator.pop(context);

                  imageSource = ImageSource.camera;
                },
              ),
              ListTile(
                leading: const Icon(Icons.album),
                title: const Text("Gallery"),
                onTap: () async {
                  Navigator.pop(context);
                  imageSource = ImageSource.gallery;
                },
              )
            ],
          );
        });

  }

  Future getImage(ImageSource source) async {
    final imageFile = await picker.pickImage(source: source, imageQuality: 60);

    if (imageFile == null) {
      return;
    }

    var file = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));

    if (file == null) {
      return;
    }
    var filee = await compressImage(file.path, 85);
    return File(filee!.path);
  }

  Future compressImage(String path, int quality) async {
    final newpath = j.join((await getTemporaryDirectory()).path,
        "${DateTime.now()}.${j.extension(path)}");

    print(newpath);
    final result = await FlutterImageCompress.compressAndGetFile(path, newpath,
        quality: quality);
    return result;
  }

  Future<String> uploadToStorage(File file, String location) async {
    UploadTask uploadTask;
    String downloadUrl = "";
    Uint8List fileBytes = await file.readAsBytes(); //result.files.first.bytes;

    // Upload file
    //  await FirebaseStorage.instance.ref('uploads/$fileName').putData(fileBytes);
    Reference imageReference =
        FirebaseStorage.instance.ref().child("$location/${Timestamp.now()}");
    uploadTask = imageReference.putData(fileBytes);
    await uploadTask.whenComplete(() async {
      await imageReference.getDownloadURL().then((value) async {
        downloadUrl = value.toString();
      });
    });

    return downloadUrl;
  }
}
