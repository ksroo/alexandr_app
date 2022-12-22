import 'package:alexandr_test_app/app/error/exceptions.dart';
import 'package:alexandr_test_app/app/error/failuers.dart';
import 'package:alexandr_test_app/app/model/photos_model.dart';
import 'package:alexandr_test_app/repository/photos/photos_api.dart';
import 'package:dartz/dartz.dart';

class PhotosRepo {
  final PhotosApi photosApi;

  PhotosRepo(this.photosApi);

  Future<Either<Failure, List<PhotosModel>>> getPhotos() async {
    try {
      final result = await photosApi.getPhotos();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
