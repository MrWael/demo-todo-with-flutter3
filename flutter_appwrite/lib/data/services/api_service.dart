import 'dart:math';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:appwrite/appwrite.dart';
import 'package:demotodoflutter_sdk3/data/model/addData_model.dart';
import 'package:demotodoflutter_sdk3/data/model/user_model.dart';

import 'package:demotodoflutter_sdk3/res/constant.dart';

class ApiService {
  static ApiService _instance = ApiService._internal();

  Client _client = Client();
  Account _account = Account(Client());
  Databases _db = Databases(Client());
  Storage _storage = Storage(Client());

  ApiService._internal() {
    _client = Client(endPoint: AppConstant.endPoint)
        .setProject(AppConstant.projectid)
        .setSelfSigned(status: true);
    _account = Account(_client);
    _db = Databases(_client);
    _storage = Storage(_client);
  }

  static ApiService get instance {
    if (_instance == null) {
      _instance = ApiService._internal();
    }
    return _instance;
  }

  Future login({required String email, required String password}) {
    return _account.createEmailSession(email: email, password: password);
  }

  Future signup(
      {required String name, required String email, required String password}) {
    return _account.create(
        userId: ID.unique(), name: name, email: email, password: password);
  }

  Future updateanylogin({required String email, required String password}) {
    return _account.updateEmail(email: email, password: password);
  }

  Future logout() {
    return _account.deleteSession(sessionId: 'current');
  }

  Future getcurrentsesstion() async {
    //check if a user logged in, if not then log in to guest then redirect to login page (from main.dart)
    try {
      final response = await _account.get();
    } on AppwriteException catch (e) {
      if (e.message!.contains('errno = 1225')) {
        return Future.error(
            "errno (1225)", StackTrace.fromString("Unable to Reach Database!"));
      }
      return _account.createEmailSession(
          email: 'guest@temp.com', password: '12345678');
    }
  }

  Future<User> getUser() async {
    await getcurrentsesstion();
    final res = await _account.get();
    return User.fromMap(res.toMap());
  }

  Future<AddData> getAddData({
    AddData? addData,
    List<String>? permissions,
  }) async {
    final res = await _db.createDocument(
      databaseId: AppConstant.database,
      collectionId: AppConstant.collection,
      documentId: ID.unique(),
      data: addData!.toMap(),
      permissions: permissions,
    );
    return AddData.fromMap_ae(res.data);
  }

  Future<List<AddData>> insertData() async {
    final res = await _db.listDocuments(
      databaseId: AppConstant.database,
      // offset: 100,
      // limit: 100,
      collectionId: AppConstant.collection,
    );

    return List<Map<String, dynamic>>.from(res.toMap()['documents'])
        .map((e) => AddData.fromMap(e))
        .toList();
  }

  Future deleteData({required String documentId}) async {
    return await _db.deleteDocument(
        databaseId: AppConstant.database,
        collectionId: AppConstant.collection,
        documentId: documentId);
  }

  Future<AddData> editData({
    required String documentId,
    required AddData addData,
    List<String>? permissions,
  }) async {
    final res = await _db.updateDocument(
        databaseId: AppConstant.database,
        collectionId: AppConstant.collection,
        documentId: documentId,
        data: addData.toMap(),
        permissions: permissions);
    return AddData.fromMap_ae(res.data);
  }

  Future<Map<String, dynamic>> uploadPicture(
    FilePickerResult file,
    List<String> permission,
  ) async {
    var res = await _storage.createFile(
        bucketId: AppConstant.profileImgBucketId,
        fileId: ID.unique(),
        file: kIsWeb
            ? InputFile(bytes: file.files.first.bytes)
            : InputFile(path: file.paths.first),
        permissions: permission);

    return res.toMap();
  }

  Future deleteProfilePicture(
    String fileId,
    List<String> permission,
  ) async {
    var res = await _storage.deleteFile(
      bucketId: AppConstant.profileImgBucketId,
      fileId: fileId,
    );
  }

  Future<Map<String, dynamic>> updatePrefs(Map<String, dynamic> prefs) async {
    final res = await _account.updatePrefs(prefs: prefs);
    return res.toMap();
  }

  Future<Uint8List> getProfile(String fileId) async {
    var res;
    try {
      res = await _storage.getFilePreview(
          bucketId: AppConstant.profileImgBucketId, fileId: fileId);

      return res.sublist(0);
    } on AppwriteException {
      print('File Not Found');
      return res;
    }
  }
}
