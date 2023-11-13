import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:iconsax/iconsax.dart';

import '../utils/subheadingtext.dart';
import 'fullscreen.dart';

class AllScreen extends StatefulWidget {
  const AllScreen({super.key});

  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
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

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SubHeadingText(
                  text: 'Wallpapers',
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
                                imgurl: images[index]['src']['large'],
                              );
                            },
                          ));
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              images[index]['src']['small'],
                              fit: BoxFit.cover,
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
      ),
    );
  }
}
