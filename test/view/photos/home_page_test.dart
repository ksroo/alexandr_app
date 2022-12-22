import 'package:alexandr_test_app/view/photos/home_page.dart';
import 'package:alexandr_test_app/view/photos/logic/photos_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class MockPhotoBloc extends MockCubit<PhotosState> implements PhotosBloc {}

void main() {
  Widget widgetUderTest({required PhotosBloc bloc}) {
    return MaterialApp(
      home: BlocProvider<PhotosBloc>(
        create: (context) => bloc,
        child: const HomePage(),
      ),
    );
  }

  group("HomePage", () {
    late PhotosBloc mockPhotoBloc;

    setUp(
      () {
        mockPhotoBloc = MockPhotoBloc();
      },
    );
    group("should test listView", () {
      testWidgets(
        "Loading when bloc emits PhotosStateLoading",
        (widgetTester) async {
          whenListen(
            mockPhotoBloc,
            Stream.fromIterable([PhotosStateLoading()]),
            initialState: PhotosInitial(),
          );

          await widgetTester.pumpWidget(widgetUderTest(bloc: mockPhotoBloc));
          await widgetTester.pump();

          final photoLoading = find.byType(CircularProgressIndicator);
          expect(photoLoading, findsOneWidget);
        },
      );

      testWidgets(
        "LoadedData when bloc emits PhotosStateLoaded",
        (widgetTester) async {
          whenListen(
            mockPhotoBloc,
            Stream.fromIterable([const PhotosStateLoaded([])]),
            initialState: PhotosInitial(),
          );

          await widgetTester.pumpWidget(widgetUderTest(bloc: mockPhotoBloc));
          await widgetTester.pump();

          final photoLoaded = find.byType(ListView);
          expect(photoLoaded, findsOneWidget);
        },
      );
    });
  });
}
