import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_select_n_capture_flutter/controller/imagepic_controller.dart';

class ImagePickerNView extends StatelessWidget {
   ImagePickerNView({super.key});

  final ImagepicController _imageController = Get.put(ImagepicController());

  @override
  Widget build(BuildContext context) {
    ImagepicController.to.startFunc();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Image Picker',style: TextStyle(color: Colors.white),),backgroundColor: Colors.black,),
      body: Obx((){
        if(_imageController.isLoading){
          return Center(child: CircularProgressIndicator(color: Colors.green,));
        }else{
          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Card(
                      color: Colors.black45,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Upload Image',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                _imageController.isSelectingImage ? CircularProgressIndicator(color: Colors.grey,) :
                                _imageController.imageFile != null &&
                                    _imageController.imagefilename.isNotEmpty
                                    ? Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey
                                              .withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0,
                                              2), // changes the position of the shadow
                                        ),
                                      ],
                                    ),
                                    child: Image.file(
                                      File(_imageController.imageFile!.path),
                                      fit: BoxFit.cover,
                                    ))
                                    : const Text(
                                    'You have not yet picked an image.',style: TextStyle(color: Colors.white),),
                                const SizedBox(width: 1.0),


                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 40,),

                  Container(
                    width: 350,
                    height: 60,
                    // color: Colors.grey,
                    child: Center(child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade200
                            ),
                            onPressed: (){
                          _imageController.imagePicker();
                        }, child: Row(
                          children: [
                            Icon(Icons.file_present),
                            Text('Image Picker',style: TextStyle(color: Colors.black),),
                          ],
                        )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade200
                            ),
                            onPressed: (){
                          _imageController.captureImage();
                        }, child: Row(
                          children: [
                            Icon(Icons.camera_alt),
                            Text('Capture Image',style: TextStyle(color: Colors.black)),
                          ],
                        )),
                      ],
                    ),),),
                  Container(
                    width: 350,
                    height: 50,
                    // color: Colors.grey,
                    child: Center(child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black
                          ),
                            onPressed: (){
                          _imageController.clearFunc();
                        }, child: Row(
                          children: [
                            Icon(Icons.cleaning_services,color: Colors.white,),
                            Text('Clear',style: TextStyle(color: Colors.white),),
                          ],
                        )),
                      ],
                    ),),),





                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
