import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/core/app_storage.dart';
import 'package:flutter_template/core/app_theme.dart';
import 'package:flutter_template/core/constants/constants.dart';
import 'package:flutter_template/localization/messages.dart';
import 'package:flutter_template/pages/home/view.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppStorage().init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AppStorage().setting.listenable(keys: [
        SettingBoxKey.themeModeKey,
        SettingBoxKey.appFontFamilyKey,
        SettingBoxKey.primaryColorKey
      ]),
      builder: (context, value, child) {
        final ThemeMode themeMode = ThemeMode
            .values[value.get(SettingBoxKey.themeModeKey, defaultValue: 0)];
        final int color =
            value.get(SettingBoxKey.primaryColorKey, defaultValue: 0xff3FA796);
        final String fontFamily =
            value.get(SettingBoxKey.appFontFamilyKey, defaultValue: "Nunito");
        final Color primaryColor = Color(color);

        return DynamicColorBuilder(
          builder: (lightDynamic, darkDynamic) {
            ColorScheme lightColorScheme;
            ColorScheme darkColorScheme;
            // 动态颜色适配
            if (lightDynamic != null && darkDynamic != null) {
              lightColorScheme = lightDynamic.harmonized();
              darkColorScheme = darkDynamic.harmonized();
            } else {
              lightColorScheme = ColorScheme.fromSeed(
                  seedColor: primaryColor, brightness: Brightness.light);
              darkColorScheme = ColorScheme.fromSeed(
                  seedColor: primaryColor, brightness: Brightness.dark);
            }

            return GetMaterialApp(
              title: Constants.appName,
              themeMode: themeMode,
              theme: AppTheme().lightTheme(lightColorScheme, fontFamily),
              darkTheme: AppTheme().darkTheme(darkColorScheme, fontFamily),
              locale: const Locale("zh", "CN"),
              fallbackLocale: const Locale("en", "US"),
              translations: Messages(),
              home: const HomeScreen(),
            );
          },
        );
      },
    );
  }
}
