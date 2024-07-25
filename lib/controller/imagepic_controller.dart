import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagepicController extends GetxController{
  static ImagepicController get to => Get.put(ImagepicController());
  var _isLoading = false.obs;

  get isLoading => _isLoading.value;

  set isLoading(value) {
    _isLoading.value = value;
  }

  File? imageFile;
  var _imagefilename = ''.obs;

  get imagefilename => _imagefilename.value;

  set imagefilename(value) {
    _imagefilename.value = value;
  }

  var _cameraStatus = "".obs ;

  get cameraStatus => _cameraStatus.value;

  set cameraStatus(value) {
    _cameraStatus.value = value;
  }

  var _storageStatus = "".obs;

  get storageStatus => _storageStatus.value;

  set storageStatus(value) {
    _storageStatus.value = value;
  }

  final picker = ImagePicker();

  @override
  void onInit() {
    // TODO: implement onInit
    requestPermissions();
    super.onInit();
  }

  Future<void> requestPermissions() async {
    await requestcameraPermission();
    // await _isAndroidStorageApiScopedStorage();
    // await requestStoragePermission();
    // await requestPhotosNVideosPermission();
  }

  Future<void> requestcameraPermission() async {
    final cameraStatus2 = await Permission.camera.request();
    // print(camera_status);
    ///camera access request start
    if (cameraStatus2 == PermissionStatus.granted) {
      // Permission granted.
        cameraStatus = 'granted';
      // print('cameraStatus true');
    } else if (cameraStatus2 == PermissionStatus.denied) {
        cameraStatus = 'denied';
      // print('cameraStatus false');
      // Permission denied.
    } else if (cameraStatus2.isPermanentlyDenied) {
        cameraStatus = 'isPermanentlyDenied';
      // print('cameraStatus false');
      // Permission denied.
    } else if (cameraStatus2.isLimited) {

        cameraStatus = 'isLimited';
      // print('cameraStatus false');
      // Permission denied.
    } else {
        cameraStatus = 'denied';
    }

    ///camera access request end
  }

  Future<void> startFunc()async{

    isLoading = true;
    await Future.delayed(Duration(seconds: 2));
    isLoading = false;
  }

  var _isSelectingImage = false.obs;

  get isSelectingImage => _isSelectingImage.value;

  set isSelectingImage(value) {
    _isSelectingImage.value = value;
  }

  Future<void> captureImage()async{
    isSelectingImage = true;

    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      imagefilename = pickedFile.path;
      isSelectingImage = false;
    }else{
      imagefilename = "";
      imageFile = File("");
      isSelectingImage = false;
    }

  }

  Future<void> imagePicker() async {
    isSelectingImage = true;
      imagefilename = "";
      imageFile = File("");
    // final pickedFile = await picker.pickImage(source: source);
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        imagefilename = pickedFile.path;
        isSelectingImage = false;
      }else{
        imagefilename = "";
        imageFile = File("");
        isSelectingImage = false;
      }

  }


  Future<void>clearFunc()async{
    imagefilename = "";
    imageFile = File("");
    isSelectingImage = false;
  }







}