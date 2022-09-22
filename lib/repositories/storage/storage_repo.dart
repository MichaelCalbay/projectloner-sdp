import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectloner/repositories/database/database_repo.dart';
import 'package:projectloner/repositories/storage/base_storage_repo.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class StorageRepo extends BaseStorageRepo {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  Future<void> uploadImage(XFile image) async {
    try {
      await storage
          .ref('user_test/${image.name}')
          .putFile(
            File(image.path),
          )
          .then(
            (p0) => DatabaseRepository().updateUserPictures(image.name),
          );
      debugPrint('IMAGE UPDLOADED...');
    } catch (_) {
      debugPrint('EXCEPTION CAUGHT');
    }
  }

  @override
  Future<String> getDownloadUrl(String imageName) async {
    String downloadUrl =
        await storage.ref('user_test/$imageName').getDownloadURL();

    return downloadUrl;
  }
}
