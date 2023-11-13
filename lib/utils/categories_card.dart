// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../pages/wallpaperpage.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({
    Key? key,
    required this.text,
    required this.img,
  }) : super(key: key);
  final String text;
  final String img;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return WallPaperPage(text: text,);
          },
        ));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover)),
        child: Center(
          child: Text(text,
              style: const TextStyle(color: Colors.white, fontSize: 22)),
        ),
      ),
    );
  }
}
