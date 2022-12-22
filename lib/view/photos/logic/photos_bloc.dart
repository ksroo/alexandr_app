import 'package:alexandr_test_app/app/error/failuers.dart';
import 'package:alexandr_test_app/app/model/photos_model.dart';
import 'package:alexandr_test_app/repository/photos/photos_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'photos_event.dart';
part 'photos_state.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  final PhotosRepo repo;

  PhotosBloc(this.repo) : super(PhotosInitial()) {
    on<GetPhotosEvent>((event, emit) async {
      emit(PhotosStateLoading());

      Either<Failure, List<PhotosModel>> result = await repo.getPhotos();

      emit(result.fold((l) => const PhotosStateError("Error Message"),
          (r) => PhotosStateLoaded(r)));
    });
  }
}
