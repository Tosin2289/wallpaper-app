import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

import '../utils/subheadingtext.dart';
import 'fullscreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List images = [];
  void searchImages(value) async {
    await http.get(
        Uri.parse(
          "https://api.pexels.com/v1/search?query=$value&per_page=80",
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
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SubHeadingText(
                text: 'Search',
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: dark ? Colors.grey.shade700 : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: TextField(
                          onChanged: (value) {
                            searchImages(value);
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey.shade400),
                              hintText: 'Find wallpaper...',
                              suffixIcon: const Icon(Iconsax.search_normal))),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: MasonryGridView.builder(
                itemCount: images.length,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
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
