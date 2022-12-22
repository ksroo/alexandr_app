part of 'photos_bloc.dart';

abstract class PhotosState extends Equatable {
  const PhotosState();

  @override
  List<Object> get props => [];
}

class PhotosInitial extends PhotosState {}

class PhotosStateLoading extends PhotosState {}

class PhotosStateLoaded extends PhotosState {
  final List<PhotosModel> list;

  const PhotosStateLoaded(this.list);
}

class PhotosStateError extends PhotosState {
  final String message;

  const PhotosStateError(this.message);
}
