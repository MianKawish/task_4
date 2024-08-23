import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task_4/res/app_colors/app_colors.dart';

import '../../bloc/images/images_bloc.dart';
import '../../res/app_strings/app_strings.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({super.key});

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: const Text(
          AppStrings.imagesScreenTitleText,
          style: TextStyle(
              color: Colors.white70,
              fontStyle: FontStyle.italic,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocListener<ImagesBloc, ImagesState>(
        listener: (context, state) {
          if (state.showPermissionDialog) {
            _showPermissionDialog(
              context,
              state.dialogTitle ?? '',
              state.dialogContent ?? '',
            );
          }
        },
        child: BlocBuilder<ImagesBloc, ImagesState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.05),
              child: ListView(
                children: [
                  Container(
                    child: state.file == null
                        ? null
                        : Image.file(File(state.file!.path.toString())),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  AppColors.primaryColor)),
                          onPressed: () => context
                              .read<ImagesBloc>()
                              .add(PickImageFromGalleryEvent()),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 30),
                            child: Text(
                              "Gallery",
                              style: TextStyle(color: AppColors.secondaryColor),
                            ),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      TextButton(
                          style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  AppColors.primaryColor)),
                          onPressed: () => context
                              .read<ImagesBloc>()
                              .add(PickImageFromCameraEvent()),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 30),
                            child: Text(
                              "Camera",
                              style: TextStyle(color: AppColors.secondaryColor),
                            ),
                          )),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showPermissionDialog(
      BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                context.read<ImagesBloc>().add(ResetPermissionDialog());
                Navigator.of(context).pop();
              },
              child: Text(AppStrings.cancelText),
            ),
            TextButton(
              onPressed: () {
                openAppSettings();
                context.read<ImagesBloc>().add(ResetPermissionDialog());
                Navigator.of(context).pop();
              },
              child: Text(AppStrings.allowText),
            ),
          ],
        );
      },
    );
  }
}
