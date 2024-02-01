import 'dart:math';

import 'package:flutter/material.dart';
import 'package:galaxy_planets/screen/home/model/home_model.dart';
import 'package:galaxy_planets/screen/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/shared_helper.dart';
import '../../../utils/theme_provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  HomeProvider? providerr;
  HomeProvider? providerw;

  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    animationController!.repeat();
  }

  Widget build(BuildContext context) {
    providerr = context.read<HomeProvider>();
    providerw = context.watch<HomeProvider>();
    HomeModel planetData =
        ModalRoute.of(context)!.settings.arguments as HomeModel;
    return PopScope(
      onPopInvoked: (didPop) {
        providerr!.animation(!providerw!.ani);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Galaxy'),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Consumer<ThemeProvider>(
                          builder: (context, value, child) => Switch(
                            value: value.isLight,
                            onChanged: (value1) {
                              ShareHelper shr = ShareHelper();
                              shr.setTheme(value1);
                              value.changeTheme();
                            },
                          ),
                        ),
                        const Text("Theme"),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            providerr!.getBookMarkData();
                            if (!providerr!.bookMarkList!.contains(providerr!
                                .planetList[providerw!.isIndex!].name)) {
                              providerr!.addBookMarkData();
                            } else {
                              providerr!.removeBookMarkData();
                            }
                          },
                          icon: providerw!.bookMarkList!.contains(providerr!
                                  .planetList[providerw!.isIndex!].name)
                              ? const Icon(Icons.bookmark_add)
                              : const Icon(Icons.bookmark_add_outlined),
                        ),
                        const Text("BookMark")
                      ],
                    ),
                  ),
                ],
              )
            ],
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    context.watch<ThemeProvider>().isLight
                        ? "assets/image/bg1.png"
                        : "assets/image/light1.jpg",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: context.watch<ThemeProvider>().isLight
                        ? null
                        : Colors.grey.withOpacity(0.6),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Hi User"),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Which planet\nwould you like to explore?",
                          style: TextStyle(fontSize: 15, fontFamily: 'Space'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AnimatedBuilder(
                          animation: animationController!,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: pi * animationController!.value * 2,
                              child: Image.asset(
                                "${planetData.image}",
                                height:
                                    MediaQuery.sizeOf(context).height * 0.25,
                                width: MediaQuery.sizeOf(context).width,
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            "${planetData.name}",
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Center(
                            child: Text(
                          "The ${planetData.type}",
                          style: TextStyle(fontFamily: "Space"),
                        )),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Distance of Sun",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Space"),
                        ),
                        Text(
                          "${planetData.distanceFromSun}",
                          style: const TextStyle(
                              fontSize: 15, fontFamily: "Space"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Mass",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Space"),
                        ),
                        Text(
                          "${planetData.mass}",
                          style: const TextStyle(
                              fontSize: 15, fontFamily: "Space"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Radius",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Space"),
                        ),
                        Text(
                          "${planetData.radius}",
                          style: const TextStyle(
                              fontSize: 15, fontFamily: "Space"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "About ${planetData.name}-",
                          style: const TextStyle(
                              fontSize: 20,
                              fontFamily: "Space",
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${planetData.description}",
                          style: const TextStyle(
                              fontSize: 15, fontFamily: "Space"),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: const Alignment(-0.15, -0.64),
                    child: Image.asset("assets/image/border.png"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }
}
