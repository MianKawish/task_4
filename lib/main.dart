import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_4/bloc/audio/audio_bloc.dart';
import 'package:task_4/bloc/home/home_bloc.dart';
import 'package:task_4/bloc/images/images_bloc.dart';
import 'package:task_4/bloc/video/video_bloc.dart';
import 'package:task_4/utils/utils.dart';
import 'package:task_4/view/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => VideoBloc(Utils()),
        ),
        BlocProvider(
          create: (context) => AudioBloc(),
        ),
        BlocProvider(
          create: (context) => ImagesBloc(Utils()),
        ),
        BlocProvider(
          create: (context) => HomeBloc(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
