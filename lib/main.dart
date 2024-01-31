import 'package:flutter/material.dart';
import 'package:galaxy_planets/screen/home/provider/home_provider.dart';
import 'package:galaxy_planets/utils/app_routes.dart';
import 'package:galaxy_planets/utils/theme_data.dart';
import 'package:galaxy_planets/utils/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: HomeProvider()),
        ChangeNotifierProvider.value(value: ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          value.changeTheme();
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: app_routes,
            theme: value.isLight ? darkTheme : lightTheme,
          );
        },
      ),
    ),
  );
}
