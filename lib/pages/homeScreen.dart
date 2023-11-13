// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/pages/fullscreen.dart';
import '../constants/image_strings.dart';
import '../models/categories_model.dart';
import '../utils/categories_card.dart';
import '../utils/subheadingtext.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Categories> categories = [
    Categories(text: "Abstract", image: abstract),
    Categories(text: "Nature", image: nature),
    Categories(text: "Universe", image: universe),
    Categories(text: "Animals", image: animals),
    Categories(text: "Tech", image: tech),
    Categories(text: "Sports", image: sports),
  ];
  List images = [];

  void fetchImages() async {
    await http.get(
        Uri.parse(
          'https://api.pexels.com/v1/curated?per_page=30',
        ),
        headers: {
          "Authorization":
              "7DCdXzXDu6jtm9sI9nJo1uPbYl4IpswkYstEHwsbJWoPoxuyfwbgGhP9"
        }).then((value) {
      var result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
    });
  }

  void searchImages(value) async {
    await http.get(
        Uri.parse(
          "https://api.pexels.com/v1/search?query=$value&per_page=80",
        ),
        headers: {
          "Authorization":
              "7DCdXzXDu6jtm9sI9nJo1uPbYl4IpswkYstEHwsbJWoPoxuyfwbgGhP9"
        }).then((value) {
      var result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
    });
  }

  @override
  void initState() {
    fetchImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        backgroundColor: !dark ? Colors.white.withOpacity(0.95) : null,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: dark ? Colors.grey.shade700 : Colors.white,
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
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade400),
                                hintText: 'Find wallpaper...',
                                suffixIcon: const Icon(Iconsax.search_normal))),
                      ),
                    ),
                  ),
                ),
                const SubHeadingText(text: "Best of the month"),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 210,
                  child: Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: 8,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
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
                                child: SizedBox(
                                  height: 180,
                                  child: Image.network(
                                    images[index]['src']['tiny'],
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const SubHeadingText(text: "Categories"),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Expanded(
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 3 / 1.5),
                        itemBuilder: (context, index) {
                          return CategoriesCard(
                            text: categories[index].text,
                            img: categories[index].image,
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
