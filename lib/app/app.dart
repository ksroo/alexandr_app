import 'package:alexandr_test_app/view/photos/home_page.dart';
import 'package:alexandr_test_app/view/photos/logic/photos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alexandr_test_app/app/app_injector.dart' as di;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<PhotosBloc>()..add(GetPhotosEvent()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
