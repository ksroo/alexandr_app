import 'package:alexandr_test_app/app/error/exceptions.dart';
import 'package:alexandr_test_app/app/error/failuers.dart';
import 'package:alexandr_test_app/app/model/photos_model.dart';
import 'package:alexandr_test_app/repository/photos/photos_api.dart';
import 'package:alexandr_test_app/repository/photos/photos_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'photos_repo_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PhotosApi>()])
void main() {
  group("Photos Repository", () {
    final mockPhotoApi = MockPhotosApi();
    final photoRepoUndertest = PhotosRepo(mockPhotoApi);

    group("should return PhotoModel", () {
      test("when PhotoApi return a PhotoModel", () async {
        final photos = List.generate(
            5,
            (index) => PhotosModel(
                albumId: index,
                id: index,
                title: 'title  $index',
                url: '"https://via.placeholder.com/600/92c952"',
                thumbnailUrl: '"https://via.placeholder.com/150/92c952"'));
        when(mockPhotoApi.getPhotos()).thenAnswer((_) => Future.value(photos));

        final result = await photoRepoUndertest.getPhotos();
        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(result, Right<Failure, List<PhotosModel>>(photos));
        verify(mockPhotoApi.getPhotos()).called(1);
        verifyNoMoreInteractions(mockPhotoApi);
      });
    });

    group("should return left with", () {
      test("a ServerFailure when a ServerException occurs", () async {
        when(mockPhotoApi.getPhotos()).thenThrow(const ServerException());

        final result = await photoRepoUndertest.getPhotos();
        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, List<PhotosModel>>(ServerFailure()));
      });
  
    });
  });
}
