import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

import 'fullscreen.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List images = [];
  int page = 1;
  void fetchImages() async {
    await http.get(
        Uri.parse(
          'https://api.pexels.com/v1/curated?per_page=80',
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

  void loadmore() async {
    setState(() {
      page++;
    });
    String url = 'https://api.pexels.com/v1/curated?per_page=80&page=$page';
    await http.get(
        Uri.parse(
          url,
        ),
        headers: {
          "Authorization":
              "7DCdXzXDu6jtm9sI9nJo1uPbYl4IpswkYstEHwsbJWoPoxuyfwbgGhP9"
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: dark ? Colors.grey.shade700 : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        searchImages(value);
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search wallpaper',
                          prefixIcon: Icon(Iconsax.search_normal))),
                ),
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
              )),
              InkWell(
                onTap: loadmore,
                child: Container(
                  height: 60,
                  width: double.infinity,
                  color: dark ? Colors.black : Colors.white,
                  child: Center(
                      child: Text(
                    'Load More',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
