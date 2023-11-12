import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;

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
      body: Column(
        children: [
          Expanded(
              child: MasonryGridView.builder(
            itemCount: images.length,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 180,
                      child: Image.network(
                        images[index]['src']['tiny'],
                        fit: BoxFit.cover,
                      ),
                    )),
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
    );
  }
}
