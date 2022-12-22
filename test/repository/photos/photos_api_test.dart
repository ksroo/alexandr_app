import 'package:alexandr_test_app/app/model/photos_model.dart';
import 'package:alexandr_test_app/app/services/api_services.dart';
import 'package:alexandr_test_app/app/services/end_points.dart';
import 'package:alexandr_test_app/repository/photos/photos_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'photos_api_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late final ApiServices mockApiServices;
  late final PhotosApi postsApi;

  setUp(() {
    mockApiServices = MockApiServices();
    postsApi = PhotosApi(mockApiServices);
  });

  group("Photos APi Testing", () {
    test("Get Photos Api Testing...", () async {
      final photos = List.generate(
          5,
          (index) => PhotosModel(
              albumId: index,
              id: index,
              title: 'title  $index',
              url: '"https://via.placeholder.com/600/92c952"',
              thumbnailUrl: '"https://via.placeholder.com/150/92c952"'));
      final photosMap = photos.map((post) => post.toMap()).toList();
      when(mockApiServices.get(EndPoints.photosUrl))
          .thenAnswer((_) => Future.value(photosMap));

      final result = await postsApi.getPhotos();

      expect(result, photos);
    });
  });

  
}
