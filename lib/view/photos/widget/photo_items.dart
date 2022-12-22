part of '../home_page.dart';

class PhotoItems extends StatelessWidget {
  final String title;
  final String image;
  final int id;
  const PhotoItems(
      {super.key, required this.title, required this.image, required this.id});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(image),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        id.toString(),
        style: const TextStyle(fontSize: 16),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      onTap: () {},
    );
  }
}
