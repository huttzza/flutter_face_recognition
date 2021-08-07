/*import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  CameraScreen({Key? key, required this.cameras}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  void initState() {
    initializeCamera(selectedCamera);
    super.initState();
  }

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  int selectedCamera = 0;
  List<File> capturedImages = [];

  initializeCamera(int cameraIndex) async {
    _controller =
        CameraController(widget.cameras[cameraIndex], ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
          Spacer(),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        if (widget.cameras.length > 1) {
                          setState(() {
                            selectedCamera = selectedCamera == 0 ? 1 : 0;
                            initializeCamera(selectedCamera);
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('No secondary camera found'),
                            duration: const Duration(seconds: 2),
                          ));
                        }
                      },
                      icon: Icon(Icons.switch_camera_rounded,
                          color: Colors.white)),
                  GestureDetector(
                    onTap: () async {
                      await _initializeControllerFuture;
                      var xFile = await _controller.takePicture();
                      setState(() {
                        capturedImages.add(File(xFile.path));
                      });
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (capturedImages.isEmpty) return;
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> GalleryScreen(images: capturedImages.reversed.toList())));
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        image: capturedImages.isNotEmpty
                            ? DecorationImage(
                                image: FileImage(capturedImages.last),
                                fit: BoxFit.cover)
                            : null,
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
*/
// A screen that allows users to take a picture using a given camera.
import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next steps.
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
