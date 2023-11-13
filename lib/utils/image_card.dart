import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) {
        //     return FullScreen(
        //       imgurl: images[index]['src']['large2x'],
        //     );
        //   },
        // ));
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 180,
            child: Image.network(
              "images[index]['src']['tiny']",
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}
