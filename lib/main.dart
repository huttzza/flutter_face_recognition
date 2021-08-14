import 'package:camera/camera.dart';
import 'package:flutter_face_recognition/calendar/calendar.dart';
import 'package:flutter_face_recognition/page/face_detector_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

List<CameraDescription> cameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();
  runApp(CameraApp(cameras: cameras));
}

class CameraApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  const CameraApp({Key? key, required this.cameras}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ko', 'KR'),
      ],
      title: 'Camera App',
      home: MyHomePage(
        title: 'hello',
      ), //TakePictureScreen(camera: cameras.first),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    cameras = await availableCameras();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FaceDetectorView(),
                      ),
                    );
                  },
                  child: Text('camera'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Calendar()));
                    },
                    child: Text('calendar'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
