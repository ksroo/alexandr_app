import 'package:alexandr_test_app/app/error/failuers.dart';
import 'package:alexandr_test_app/app/model/photos_model.dart';
import 'package:alexandr_test_app/repository/photos/photos_repo.dart';
import 'package:alexandr_test_app/view/photos/logic/photos_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPhotosRepo extends Mock implements PhotosRepo {}

void main() {
  group("PhotosBloc", () {
    PhotosRepo photosRepo = MockPhotosRepo();

    final photos = List.generate(
        5,
        (index) => PhotosModel(
            albumId: index,
            id: index,
            title: 'title  $index',
            url: '"https://via.placeholder.com/600/92c952"',
            thumbnailUrl: '"https://via.placeholder.com/150/92c952"'));
    group("should emits", () {
      blocTest(
        'nothing when no event is added',
        build: () => PhotosBloc(photosRepo),
        expect: () => const <PhotosState>[],
      );

      blocTest(
        '[PhotoStateLoading, PhotoStateLoaded] when phototRequested() is called',
        setUp: () => when(() => photosRepo.getPhotos()).thenAnswer(
          (_) => Future.value(Right<Failure, List<PhotosModel>>(photos)),
        ),
        build: () => PhotosBloc(photosRepo),
        act: (bloc) => bloc..add(GetPhotosEvent()),
        expect: () =>
            <PhotosState>[PhotosStateLoading(), PhotosStateLoaded(photos)],
      );
    });

    group(
        '[PhotoStateLoading, PhotoStateError] when PhotoRequested() is called',
        () {
      blocTest(
        'and a ServerFailure occors',
        setUp: () => when(() => photosRepo.getPhotos()).thenAnswer(
          (_) =>
              Future.value(Left<Failure, List<PhotosModel>>(ServerFailure())),
        ),
        build: () => PhotosBloc(photosRepo),
        act: (bloc) => bloc..add(GetPhotosEvent()),
        expect: () =>
            <PhotosState>[PhotosStateLoading(), const PhotosStateError("Error Message")],
      );
    });
  });
}
