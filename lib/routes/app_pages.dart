import 'package:flutter_template/pages/home/view.dart';
import 'package:flutter_template/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static AppPages? _instance;

  AppPages._();

  factory AppPages() => _instance ??= AppPages._();

  final routes = [
    GetPage(
      name: AppRoutes().home,
      page: () => const HomeScreen(),
    ),

    //   GetPage(name: Routes.PLAYLIST_DETAIL, page: () => PlaylistDetailPage()),
    //   GetPage(
    //     name: Routes.PLAYING,
    //     page: () => const PlayingPage(),
    //     binding: PlayingBinding(),
    //   ),
    //   GetPage(
    //     name: Routes.VIDEO_PLAY,
    //     page: () => const VideoPage(),
    //     binding: VideoBinding(),
    //   ),
    //   //singer detail
    //   GetPage(
    //       name: Routes.SINGER_DETAIL,
    //       page: () => SingerDetailPage(),
    //       preventDuplicates: false,
    //       transition: Transition.rightToLeft),
  ];
}
