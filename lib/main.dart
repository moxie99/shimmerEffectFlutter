import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:shimmereffectcontactlist/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _page = 2;
  bool isShimmerEffectActive = false;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationBarKey =
      GlobalKey<CurvedNavigationBarState>();
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: Text("Inbox"),
          leading: Icon(Icons.menu),
          backgroundColor: Colors.teal,
          actions: [
            Icon(
              Icons.search,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              isShimmerEffectActive = !isShimmerEffectActive;
            });
          },
          child: Icon(Icons.arrow_circle_right_sharp),
          backgroundColor: Colors.teal,
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterTop,
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationBarKey,
          index: _page,
          height: 60.0,
          items: const <Widget>[
            Icon(Icons.add, size: 30, color: Colors.blue),
            Icon(Icons.list, size: 30, color: Colors.blue),
            Icon(Icons.compare_arrows, size: 30, color: Colors.blue),
            Icon(Icons.call, size: 30, color: Colors.blue),
            Icon(Icons.people, size: 30, color: Colors.blue),
          ],
          color: Colors.black,
          buttonBackgroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOutQuad,
          animationDuration: Duration(milliseconds: 500),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.all(10),
          child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (ctx, i) {
                final delay = (i * 300);
                return ListTile(
                    leading: isShimmerEffectActive
                        ? FadeShimmer.round(
                            size: 60,
                            fadeTheme:
                                isDarkMode ? FadeTheme.dark : FadeTheme.light,
                            millisecondsDelay: delay,
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.teal,
                            radius: 25,
                            child: Icon(Icons.person, color: Colors.black)),
                    title: isShimmerEffectActive
                        ? FadeShimmer(
                            height: 10,
                            width: 10,
                            fadeTheme:
                                isDarkMode ? FadeTheme.dark : FadeTheme.light,
                            millisecondsDelay: delay + 1000,
                          )
                        : Text("Name"),
                    subtitle: isShimmerEffectActive
                        ? FadeShimmer(
                            width: 10,
                            height: 10,
                            fadeTheme:
                                isDarkMode ? FadeTheme.dark : FadeTheme.light,
                            millisecondsDelay: delay + 2000,
                          )
                        : Text("Email"),
                    trailing: isShimmerEffectActive
                        ? null
                        : Icon(Icons.delete, size: 30, color: Colors.teal));
              },
              separatorBuilder: (ctx, i) {
                return Divider();
              },
              itemCount: 20),
        ));
  }
}
