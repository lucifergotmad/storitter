import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:storitter/data/result_state.dart';
import 'package:storitter/generated/assets.dart';
import 'package:storitter/provider/add_story_provider.dart';
import 'package:storitter/provider/app_provider.dart';
import 'package:storitter/provider/home_provider.dart';
import 'package:storitter/shared/locale.dart';
import 'package:storitter/widgets/storitter_text_field.dart';
import 'package:geocoding/geocoding.dart' as geo;

class AddStoryScreen extends StatefulWidget {
  final XFile? file;

  const AddStoryScreen({Key? key, required this.file}) : super(key: key);

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  late GoogleMapController mapController;
  final TextEditingController _descriptionController = TextEditingController();
  final Set<Marker> markers = {};
  LatLng? latLng;
  bool _withLocation = false;

  @override
  void initState() {
    Future.microtask(() => context.read<AddStoryProvider>().resetFile());
    Future.microtask(() => getPermission());
    super.initState();
  }

  void defineMarker(LatLng latLng, String street, String address) {
    final marker = Marker(
      markerId: const MarkerId("source"),
      position: latLng,
      onTap: () {
        mapController.animateCamera(
          CameraUpdate.newLatLngZoom(latLng, 18),
        );
      },
      infoWindow: InfoWindow(
        title: street,
        snippet: address,
      ),
    );

    setState(() {
      markers.clear();
      markers.add(marker);
    });
  }

  void getPermission() async {
    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print("Location services is not available");
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print("Location permission is denied");
        return;
      }
    }

    locationData = await location.getLocation();
    latLng = LatLng(
      locationData.latitude!,
      locationData.longitude!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onLongPress: () => _onCustomCameraView(),
                  child: SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: context.watch<AddStoryProvider>().imagePath == null
                        ? Image.asset(
                            Assets.imagesPreviewPlaceholder,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(
                              context
                                  .read<AddStoryProvider>()
                                  .imagePath
                                  .toString(),
                            ),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.cameraHint,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontStyle: FontStyle.italic),
                    )
                  ],
                ),
                _withLocation
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: SizedBox(
                          width: double.infinity,
                          height: 300,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: latLng!,
                              zoom: 18,
                            ),
                            gestureRecognizers: Set()
                              ..add(
                                Factory<PanGestureRecognizer>(
                                  () => PanGestureRecognizer(),
                                ),
                              ),
                            markers: markers,
                            onMapCreated: (controller) async {
                              final info = await geo.placemarkFromCoordinates(
                                latLng!.latitude,
                                latLng!.longitude,
                              );

                              final place = info.first;
                              final street = place.street!;
                              final address =
                                  '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

                              defineMarker(latLng!, street, address);

                              setState(() {
                                mapController = controller;
                              });
                            },
                          ),
                        ),
                      )
                    : const SizedBox(
                        height: 32,
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.description,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black54),
                    ),
                    Row(
                      children: [
                        Text(
                          "Location",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Switch(
                          value: _withLocation,
                          onChanged: (bool value) {
                            setState(() {
                              _withLocation = value;
                            });
                          },
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                StoritterTextField.description(
                  label: null,
                  icon: null,
                  controller: _descriptionController,
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  onPressed: context.watch<AddStoryProvider>().state ==
                          ResultState.loading
                      ? null
                      : () => _onUpload(),
                  child: Text(
                    AppLocalizations.of(context)!.upload,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onUpload() async {
    final token = Provider.of<AppProvider>(context, listen: false).token;

    final provider = context.read<AddStoryProvider>();
    final homeProvider = context.read<HomeProvider>();

    if (provider.imageFile == null ||
        provider.imagePath == null ||
        _descriptionController.text.isEmpty) return;

    final isPosted = await provider.uploadStory(
      token,
      File(provider.imagePath!),
      _descriptionController.text,
      latLng,
    );

    provider.resetFile();

    if (isPosted) {
      bool isFetched = await homeProvider.fetchAllStory(token, true);
      if (isFetched) {
        if (!mounted) return;
        context.pop();
      }
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.uploadFailed),
        ),
      );
    }
  }

  _onCustomCameraView() async {
    final provider = context.read<AddStoryProvider>();

    final cameras = await availableCameras();

    if (cameras.isEmpty) return;

    final XFile? resultImageFile = await Future.microtask(
      () async => await context.pushNamed(
        "camera",
        extra: cameras,
      ),
    );

    if (resultImageFile != null) {
      provider
        ..setImageFile(resultImageFile)
        ..setImagePath(resultImageFile.path);
    }
  }
}
