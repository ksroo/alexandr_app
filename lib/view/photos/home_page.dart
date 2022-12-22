import 'package:alexandr_test_app/view/photos/logic/photos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../photos/widget/photo_items.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const Text(
          "Alexandr Kharin",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<PhotosBloc, PhotosState>(
        builder: (context, state) {
          if (state is PhotosStateLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            );
          } else if (state is PhotosStateLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: state.list.length,
                itemBuilder: (context, index) {
                  return PhotoItems(
                    title: state.list[index].title,
                    image: state.list[index].url,
                    id: state.list[index].id,
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
              ),
            );
          } else if (state is PhotosStateError) {
            return Text(state.message);
          }
          return const SizedBox();
        },
      ),
    );
  }
}
