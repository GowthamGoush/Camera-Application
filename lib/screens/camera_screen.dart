import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mowito_camera_application/screens/camera_preview_page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: FractionalOffset.center,
        children: [
          const Positioned.fill(
            child: CameraPreviewPage(),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.network(
                'https://picsum.photos/3000/4000',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
              child: ElevatedButton(onPressed: (){}, child: const Text('Press'),)
          ),

        ],
      ),
    );
  }

}