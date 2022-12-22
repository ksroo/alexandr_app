import 'package:alexandr_test_app/app/model/photos_model.dart';
import 'package:alexandr_test_app/app/services/api_services.dart';
import 'package:alexandr_test_app/app/services/end_points.dart';

class PhotosApi {
  final ApiServices api;

  PhotosApi(this.api);

  Future<List<PhotosModel>> getPhotos() async {
    return await api.get(EndPoints.photosUrl).then(
        (value) => (value as List).map((e) => PhotosModel.fromMap(e)).toList());
  }
}
