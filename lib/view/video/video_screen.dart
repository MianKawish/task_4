import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task_4/res/app_strings/app_strings.dart';
import 'package:video_player/video_player.dart';

import '../../bloc/video/video_bloc.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  void dispose() {
    context.read<VideoBloc>().state.videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: const Text(
          AppStrings.videoScreenTitleText,
          style: TextStyle(
            color: Colors.white70,
            fontStyle: FontStyle.italic,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocListener<VideoBloc, VideoState>(
        listener: (context, state) {
          if (state.showPermissionDialog) {
            _showPermissionDialog(
              context,
              state.dialogTitle ?? '',
              state.dialogContent ?? '',
            );
          }
        },
        child: BlocBuilder<VideoBloc, VideoState>(
          builder: (context, state) {
            final videoBloc = context.read<VideoBloc>();

            // Check if the VideoPlayerController needs to be initialized
            if (state.videoPlayerController != null &&
                !state.videoPlayerController!.value.isInitialized) {
              return const Center(
                  child:
                      CircularProgressIndicator()); // Show loading indicator while initializing
            }

            return ListView(
              children: [
                if (state.thumbnailPath != null &&
                    state.videoPlayerController == null)
                  GestureDetector(
                    onTap: () {
                      videoBloc.add(ToggleVideoPlaybackEvent());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(File(state.thumbnailPath!)),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.black,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                if (state.videoPlayerController != null &&
                    state.videoPlayerController!.value.isInitialized)
                  AspectRatio(
                    aspectRatio: state.videoPlayerController!.value.aspectRatio,
                    child: VideoPlayer(state.videoPlayerController!),
                  ),
                if (state.videoPlayerController != null)
                  IconButton(
                    icon: Icon(
                      state.videoPlayerController!.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                    onPressed: () {
                      if (state.videoPlayerController!.value.isPlaying) {
                        state.videoPlayerController!.pause();
                      } else {
                        state.videoPlayerController!.play();
                      }
                      setState(() {});
                    },
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        videoBloc.add(PickVideoFromGalleryEvent());
                      },
                      child: const Text(AppStrings.pickVideoText),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        videoBloc.add(RecordVideoEvent());
                      },
                      child: const Text(AppStrings.recordVideoText),
                    ),
                  ],
                ),
              ],
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
                context.read<VideoBloc>().add(ResetPermissionDialogForVideo());
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                openAppSettings();
                context.read<VideoBloc>().add(ResetPermissionDialogForVideo());
                Navigator.of(context).pop();
              },
              child: const Text("Allow"),
            ),
          ],
        );
      },
    );
  }
}
