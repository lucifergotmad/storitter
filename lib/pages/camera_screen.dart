import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraScreen({Key? key, required this.cameras}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  bool _isCameraInitialized = false;
  bool _isBackCameraSelected = true;
  CameraController? controller;

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    final cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
    );

    await previousCameraController?.dispose();

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      if (kDebugMode) {
        print('Error initializing camera: $e');
      }
    }

    if (mounted) {
      setState(() {
        controller = cameraController;
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    onNewCameraSelected(widget.cameras.first);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              _isCameraInitialized
                  ? SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: CameraPreview(controller!),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: FloatingActionButton(
                    onPressed: () => _onCameraButtonClick(),
                    child: const Icon(Icons.camera_alt),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      child: IconButton(
                        onPressed: () => _onCameraSwitch(),
                        icon: Icon(
                          Icons.cameraswitch,
                          size: 32,
                          color: _isBackCameraSelected
                              ? Colors.white
                              : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onCameraButtonClick() async {
    final image = await controller?.takePicture();
    await Future.microtask(() => context.pop(image));
  }

  void _onCameraSwitch() {
    if (widget.cameras.length == 1) return;

    setState(() {
      _isCameraInitialized = false;
    });

    onNewCameraSelected(
      widget.cameras[_isBackCameraSelected ? 1 : 0],
    );

    setState(() {
      _isBackCameraSelected = !_isBackCameraSelected;
    });
  }
}
