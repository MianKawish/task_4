import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_4/res/app_colors/app_colors.dart';
import 'package:task_4/res/app_strings/app_strings.dart';
import 'package:task_4/view/audio/audio_screen.dart';
import 'package:task_4/view/images/images_screen.dart';
import 'package:task_4/view/video/video_screen.dart';

import '../../bloc/home/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.status == PageToDisplay.video) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const VideoScreen(),
              ));
        } else if (state.status == PageToDisplay.audio) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AudioScreen(),
              ));
        } else if (state.status == PageToDisplay.image) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ImagesScreen(),
              ));
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.secondaryColor,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.deepPurple,
              title: const Text(
                AppStrings.appBarText,
                style: TextStyle(
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            drawer: Drawer(
              backgroundColor: AppColors.secondaryColor,
              child: ListView(
                children: [
                  const UserAccountsDrawerHeader(
                      currentAccountPictureSize: Size.square(72),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.grey,
                      ),
                      decoration: BoxDecoration(color: Colors.deepPurple),
                      accountName: (Text(AppStrings.userAccountNameText)),
                      accountEmail: Text(AppStrings.userGmailText)),
                  ListTile(
                    leading: const Icon(Icons.video_collection),
                    title: const Text(AppStrings.videoScreenTitleText),
                    onTap: () =>
                        context.read<HomeBloc>().add(VideoScreenEvent()),
                  ),
                  const Divider(
                    color: Colors.deepPurple,
                  ),
                  ListTile(
                    leading: const Icon(Icons.music_note),
                    title: const Text(AppStrings.audioScreenTitleText),
                    onTap: () =>
                        context.read<HomeBloc>().add(AudioScreenEvent()),
                  ),
                  const Divider(
                    color: Colors.deepPurple,
                  ),
                  ListTile(
                    leading: const Icon(Icons.image),
                    title: const Text(AppStrings.imagesScreenTitleText),
                    onTap: () =>
                        context.read<HomeBloc>().add(ImagesScreenEvent()),
                  ),
                  const Divider(
                    color: Colors.deepPurple,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
