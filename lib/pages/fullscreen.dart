import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class FullScreen extends StatefulWidget {
  final String imgurl;
  const FullScreen({
    Key? key,
    required this.imgurl,
  }) : super(key: key);

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  void setWallpaper() async {
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imgurl);
    bool result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  void setlockScreen() async {
    int location = WallpaperManager.LOCK_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imgurl);
    bool result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  void setBothScreen() async {
    int location = WallpaperManager.BOTH_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imgurl);
    bool result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: SizedBox(
            child: Image.network(
              widget.imgurl,
              fit: BoxFit.cover,
            ),
          )),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: setWallpaper,
                child: Container(
                  height: 60,
                  color: dark ? Colors.black : Colors.white,
                  child: Center(
                      child: Text(
                    'Set wallpaper',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: InkWell(
                onTap: setlockScreen,
                child: Container(
                  height: 60,
                  color: dark ? Colors.black : Colors.white,
                  child: Center(
                      child: Text(
                    'Set LockScreen',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: InkWell(
                onTap: setBothScreen,
                child: Container(
                  height: 60,
                  color: dark ? Colors.black : Colors.white,
                  child: Center(
                      child: Text(
                    'Set as Both',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
