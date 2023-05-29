import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/simple_bloc_observer.dart';

import 'package:notes_app/views/splash.dart';

import 'cubits/notes_cubit/notes_cubit.dart';

void main() async {
  await Hive.initFlutter();

  Bloc.observer = SimpleBlocObserver();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>(kNotesBox);

  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.light, fontFamily: 'Poppins'),
        home: const SplashScreen(),
      ),
    );
  }
}
