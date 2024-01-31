import 'package:flutter/material.dart';
import 'package:galaxy_planets/screen/home/provider/home_provider.dart';
import 'package:provider/provider.dart';
import '../../../utils/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeProvider? providerr;
  HomeProvider? providerw;

  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().getPlanetData();
    context.read<HomeProvider>().getBookMarkData();
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
        body: Stack(
          children: [
            Image.asset(
              context.watch<ThemeProvider>().isLight
                  ? "assets/image/dark.jpeg"
                  : "assets/image/light.jpeg",
              fit: BoxFit.fill,
              height: double.infinity,
            ),
            ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: providerw!.planetList.length,
                itemBuilder: (context, index) => SizedBox(height: 100,
                  child: ListTile(
                        onTap: () {
                          providerw!.changeIndex(index);
                          Navigator.pushNamed(context, "detail",
                              arguments: providerr!.planetList[index]);
                        },
                        leading:
                            Image.asset('${providerw!.planetList[index].image}'),
                        title: Text("${providerw!.planetList[index].name}"),
                      ),
                )
                // itemBuilder: (context, index) => InkWell(
                //   onTap: () {
                //     providerw!.changeIndex(index);
                //     Navigator.pushNamed(context, "detail",arguments: providerr!.planetList[index]);
                //   },
                //   child: Row(
                //     children: [
                //       Hero(
                //         tag: "planet",
                //         child: Image.network(
                //           "${providerr!.planetList[index].image}",
                //           height: 70,
                //         ),
                //       ),
                //       const SizedBox(
                //         width: 20,
                //       ),
                //       Text(
                //         "${providerw!.planetList[index].name}",
                //         style: const TextStyle(fontSize: 17),
                //       )
                //     ],
                //   ),
                // ),
                ),
          ],
        ),
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
