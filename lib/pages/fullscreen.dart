import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:iconsax/iconsax.dart';

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
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.grey.withOpacity(0.5),
        content: const Text(
          "Saved as Wallpaper",
          style: TextStyle(color: Colors.white),
        )));
  }

  void setlockScreen() async {
    int location = WallpaperManager.LOCK_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imgurl);
    bool result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.grey.withOpacity(0.5),
        content: const Text(
          "Saved as LockScreen",
          style: TextStyle(color: Colors.white),
        )));
  }

  void setBothScreen() async {
    int location = WallpaperManager.BOTH_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imgurl);
    bool result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.grey.withOpacity(0.5),
        content: const Text(
          "Saved as Both",
          style: TextStyle(color: Colors.white),
        )));
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.imgurl), fit: BoxFit.cover)),
          ),
          Align(
            alignment: Alignment(0, 0.9),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: setWallpaper,
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Center(
                              child: Icon(
                            Iconsax.home,
                            color: Colors.white,
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Homescreen",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: setlockScreen,
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Center(
                              child: Icon(
                            Iconsax.lock,
                            color: Colors.white,
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Lockscreen",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: setBothScreen,
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Center(
                              child: Icon(
                            Iconsax.devices_1,
                            color: Colors.white,
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Both",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
