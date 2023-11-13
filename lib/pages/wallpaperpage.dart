// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/pages/fullscreen.dart';
import '../utils/headingtext.dart';

class WallPaperPage extends StatefulWidget {
  const WallPaperPage({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  State<WallPaperPage> createState() => _WallPaperPageState();
}

class _WallPaperPageState extends State<WallPaperPage> {
  @override
  void initState() {
    searchImages(widget.text);
    super.initState();
  }

  List images = [];
  void searchImages(text) async {
    await http.get(
        Uri.parse(
          "https://api.pexels.com/v1/search?query=$text&per_page=80",
        ),
        headers: {
          "Authorization":
              "api key"
        }).then((value) {
      var result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              HeadingText(
                text: widget.text,
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "80 wallpaper available",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: MasonryGridView.builder(
                itemCount: images.length,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return FullScreen(
                              imgurl: images[index]['src']['large2x'],
                            );
                          },
                        ));
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            images[index]['src']["small"],
                            fit: BoxFit.cover,
                          )),
                    ),
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
