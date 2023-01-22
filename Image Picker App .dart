import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? image;
  List<XFile> multipleimage = [];

  Future<void> pickimagefromgallery() async {
    final imagepicked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (imagepicked != null) {
      setState(() {
        image = File(imagepicked.path);
      });
    }
  }

  Future<void> pickimagefromcamera() async {
    final imagepicked =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imagepicked != null) {
      setState(() {
        image = File(imagepicked.path);
      });
    }
  }

  Future<void> pickmultipleimage() async {
    List<XFile> imagepicked = await ImagePicker().pickMultiImage();
    setState(() {
      multipleimage.addAll(imagepicked);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 112, 36, 234),
        title: const Text('Image Picker App'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
            child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            image == null
                ? const SizedBox(
                    height: 400,
                    width: 300,
                    child: Placeholder(),
                  )
                : Image.file(
                    image!,
                    height: 400,
                    width: 300,
                    fit: BoxFit.contain,
                  ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(
                onPressed: () => pickimagefromgallery(),
                style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size(220, 40)),
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.deepOrange)),
                icon: SizedBox.square(
                  dimension: 35,
                  child: Image.asset('assets/gallery.png'),
                ),
                label: const Text(
                  'Pick Image',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
                onPressed: () => pickimagefromcamera(),
                style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size(220, 40)),
                    backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                icon: SizedBox.square(
                  dimension: 35,
                  child: Image.asset('assets/camera.png'),
                ),
                label: const Text(
                  'Open Camera',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  multipleimage.removeRange(0, multipleimage.length);
                  pickmultipleimage();
                },
                style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size(220, 40)),
                    backgroundColor: MaterialStatePropertyAll(Colors.teal)),
                icon: SizedBox.square(
                  dimension: 35,
                  child: Image.asset('assets/multipleimage.png'),
                ),
                label: const Text(
                  'Pick Multiple Image',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                )),
            const SizedBox(
              height: 30,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: multipleimage.length * 420, maxWidth: 300),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: multipleimage.length,
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        Image.file(
                          File(multipleimage[index].path),
                          height: 400,
                          width: 300,
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  })),
            )
          ],
        )),
      ),
    );
  }
}
