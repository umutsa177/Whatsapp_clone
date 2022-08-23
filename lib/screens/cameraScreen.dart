import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screens/videoViewPage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp_clone/Screens/pictureView.dart';

late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  }

  late CameraController _cameraController;
  late Future<void> cameraValue;
  bool isRecording = false;
  bool flash = false;
  bool cameraFlip = false;
  double rotateCamera = 0;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
    /* _cameraController.initialize().then((_) async {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });*/
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: CameraPreview(_cameraController),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
          Positioned(
            bottom: 0,
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            flash = !flash;
                          });
                          flash
                              ? _cameraController.setFlashMode(FlashMode.torch)
                              : _cameraController.setFlashMode(FlashMode.off);
                        },
                        icon: Icon(
                          flash ? Icons.flash_on : Icons.flash_off,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      GestureDetector(
                        onLongPress: () async {
                          await _cameraController.startVideoRecording();
                          setState(() {
                            isRecording = true;
                          });
                        },
                        onLongPressUp: () async {
                          // ignore: unused_local_variable
                          XFile videoPath =
                              await _cameraController.stopVideoRecording();
                          setState(() {
                            isRecording = false;
                          });
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  VideoViewPage(path: videoPath.path),
                            ),
                          );
                        },
                        onTap: () {
                          if (!isRecording) {
                            takePicture(context);
                          }
                        },
                        child: isRecording
                            ? const Icon(
                                Icons.radio_button_on,
                                color: Colors.redAccent,
                                size: 55,
                              )
                            : const Icon(
                                Icons.panorama_fish_eye,
                                color: Colors.white,
                                size: 55,
                              ),
                      ),
                      IconButton(
                          onPressed: () async {
                            setState(() {
                              cameraFlip = !cameraFlip;
                              rotateCamera = rotateCamera + pi;
                            });
                            int cameraPosition = !cameraFlip ? 0 : 1;
                            _cameraController = CameraController(
                              cameras[cameraPosition],
                              ResolutionPreset.high,
                            );
                            cameraValue = _cameraController.initialize();
                          },
                          icon: Transform.rotate(
                            angle: rotateCamera,
                            child: const Icon(
                              Icons.flip_camera_android,
                              color: Colors.white,
                              size: 28,
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Hold for video, tap for photo",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void takePicture(BuildContext context) async {
    // final path =
    //     join((await getTemporaryDirectory()).path, "${DateTime.now()}.png");
    XFile path = await _cameraController.takePicture();
    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => PictureView(
                  path: path.path,
                )));
  }
}
