import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:storitter/data/result_state.dart';
import 'package:storitter/generated/assets.dart';
import 'package:storitter/provider/add_story_provider.dart';
import 'package:storitter/provider/app_provider.dart';
import 'package:storitter/provider/home_provider.dart';
import 'package:storitter/shared/locale.dart';
import 'package:storitter/widgets/storitter_text_field.dart';

class AddStoryScreen extends StatefulWidget {
  final XFile? file;

  const AddStoryScreen({Key? key, required this.file}) : super(key: key);

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    Future.microtask(() => context.read<AddStoryProvider>().resetFile());
    super.initState();
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
                const SizedBox(
                  height: 32,
                ),
                Text(
                  AppLocalizations.of(context)!.description,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black54),
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
    );

    provider.resetFile();

    if (isPosted) {
      bool isFetched = await homeProvider.fetchAllStory(token);
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
