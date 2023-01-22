dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  image_picker: ^0.8.6   // ADD this package in yur flutter Project 
  video_player: ^2.4.10  // ADD this package in yur flutter Project 

// Add Permissions in your Flutter Project


import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? video;
  VideoPlayerController? videocontroller;
  Future<void> pickvideofromgallery() async {
    final videopicked =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (videopicked != null) {
      video = File(videopicked.path);
      videocontroller = VideoPlayerController.file(video!)
        ..initialize().then((_) {
          setState(() {});
          videocontroller!.play();
          videocontroller!.setLooping(true);
        });
    }
  }

  Future<void> pickvideofromcamera() async {
    final videopicked = await ImagePicker().pickVideo(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        maxDuration: const Duration(seconds: 60));
    if (videopicked != null) {
      video = File(videopicked.path);
      videocontroller = VideoPlayerController.file(video!)
        ..initialize().then((_) {
          setState(() {});
          videocontroller!.play();
          videocontroller!.setLooping(true);
        });
    }
  }

  @override
  void dispose() {
    videocontroller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Video Picker App'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            video == null
                ? const SizedBox(
                    height: 400,
                    width: 300,
                    child: Placeholder(),
                  )
                : ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxHeight: 400, maxWidth: 300),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {});
                        videocontroller!.value.isPlaying
                            ? videocontroller!.pause()
                            : videocontroller!.play();
                      },
                      child: AspectRatio(
                        aspectRatio: videocontroller!.value.aspectRatio,
                        child: Stack(children: [
                          VideoPlayer(videocontroller!),
                          Center(
                              child: videocontroller!.value.isPlaying
                                  ? const SizedBox()
                                  : SizedBox.square(
                                      dimension: 100,
                                      child:
                                          Image.asset('assets/playicon.png')))
                        ]),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(
                onPressed: () => pickvideofromgallery(),
                style: ButtonStyle(
                    minimumSize: const MaterialStatePropertyAll(Size(220, 50)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.deepOrange)),
                icon: SizedBox.square(
                  dimension: 35,
                  child: Image.asset('assets/video.png'),
                ),
                label: const Text(
                  'Pick Video',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                )),

                const SizedBox(height: 10,),
                ElevatedButton.icon(
                onPressed: () =>pickvideofromcamera() ,
                style: ButtonStyle(
                    minimumSize: const MaterialStatePropertyAll(Size(220, 50)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    backgroundColor:
                        const MaterialStatePropertyAll(Color.fromARGB(255, 17, 180, 131))),
                icon: SizedBox.square(
                  dimension: 35,
                  child: Image.asset('assets/camera.png'),
                ),
                label: const Text(
                  'Record Video',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                )),

          ],
        )));
  }
}
