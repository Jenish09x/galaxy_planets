import 'dart:math';

import 'package:flutter/material.dart';
import 'package:galaxy_planets/screen/home/provider/home_provider.dart';
import 'package:provider/provider.dart';
import '../../../utils/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  HomeProvider? providerr;
  HomeProvider? providerw;

  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().getPlanetData();
    context.read<HomeProvider>().getBookMarkData();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    animationController!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    providerr = context.read<HomeProvider>();
    providerw = context.watch<HomeProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Galaxy'),
          centerTitle: true,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: context.watch<ThemeProvider>().isLight
                  ? [const Color(0xff030313), Colors.black]
                  : [Colors.white, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedAlign(
                alignment: providerw!.ani?Alignment.topRight:Alignment.topLeft,
                duration: const Duration(seconds: 2),
                child: const Text(
                  "Planets in our solar system",
                  style: TextStyle(fontFamily: 'Space', fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemExtent: 70,
                  itemCount: providerw!.planetList.length,
                  itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        providerw!.changeIndex(index);
                        Navigator.pushNamed(context, "detail",
                            arguments: providerr!.planetList[index]);
                      },
                      leading: AnimatedBuilder(
                        animation: animationController!,
                        builder: (BuildContext context, Widget? child) {
                          return Transform.rotate(
                            angle: pi * animationController!.value * 2,
                            child: Image.asset(
                              '${providerw!.planetList[index].image}',
                              height: 60,
                            ),
                          );
                        },
                      ),
                      title: Center(
                        child: Text(
                          "${providerw!.planetList[index].name}",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontFamily: 'Space', fontSize: 18),
                        ),
                      ),
                      trailing: const Icon(Icons.navigate_next)),
                ),
              ),
            ],
          ),
        ),
        // body: Stack(
        //   children: [
        //     Image.asset(
        //       context.watch<ThemeProvider>().isLight
        //           ? "assets/image/dark.jpeg"
        //           : "assets/image/light.jpeg",
        //       fit: BoxFit.fill,
        //       height: double.infinity,
        //     ),
        //     ListView.builder(
        //         padding: const EdgeInsets.all(10),
        //         itemCount: providerw!.planetList.length,
        //         itemBuilder: (context, index) => SizedBox(height: 100,
        //           child: ListTile(
        //                 onTap: () {
        //                   providerw!.changeIndex(index);
        //                   Navigator.pushNamed(context, "detail",
        //                       arguments: providerr!.planetList[index]);
        //                 },
        //                 leading:
        //                     Image.asset('${providerw!.planetList[index].image}'),
        //                 title: Text("${providerw!.planetList[index].name}"),
        //               ),
        //         )
        //         // itemBuilder: (context, index) => InkWell(
        //         //   onTap: () {
        //         //     providerw!.changeIndex(index);
        //         //     Navigator.pushNamed(context, "detail",arguments: providerr!.planetList[index]);
        //         //   },
        //         //   child: Row(
        //         //     children: [
        //         //       Hero(
        //         //         tag: "planet",
        //         //         child: Image.network(
        //         //           "${providerr!.planetList[index].image}",
        //         //           height: 70,
        //         //         ),
        //         //       ),
        //         //       const SizedBox(
        //         //         width: 20,
        //         //       ),
        //         //       Text(
        //         //         "${providerw!.planetList[index].name}",
        //         //         style: const TextStyle(fontSize: 17),
        //         //       )
        //         //     ],
        //         //   ),
        //         // ),
        //         ),
        //   ],
        // ),
        drawer: Drawer(
          child: ListView.builder(
            itemCount: providerw!.bookMarkList!.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(providerr!.bookMarkList![index]),
            ),
          ),
        ),
      ),
    );
  }
}
