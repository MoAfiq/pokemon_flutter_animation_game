import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        scaffoldBackgroundColor: Colors.white,
      ),
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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  // final GifController _controller = GifController(vsync: this);
  // late Animation<Offset> _playerAnimation;
  // late Animation<Offset> _stoneAnimation;
  late AnimationController _animationController;
  int duration = 32;

  //Checking whether the jump button is tapped by user
  bool isTapped = false;
  bool hasGameStarted = false;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: duration),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<Offset> _playerAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0, 5.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  ));

  late final Animation<Offset> _stoneAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(5, 0.0),
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

  @override
  void initState() {
    super.initState();

    final AnimationController _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: duration),
        )

    _controller.addListener(() => setState(() {}));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon Game'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Image(
                  height: 85,
                  width: 85,
                  image: AssetImage('jump.png'),
                ),
                Container(
                  height: 150,
                  width: 300,
                  child: Column(
                    children: [
                      SlideTransition(
                        // key: _pikachu,
                        position: _playerAnimation,
                        child: const Image(
                          height: 75,
                          width: 75,
                          image: AssetImage('walking-pikachu.gif'),
                        ),
                      ),
                      SlideTransition(
                        position: _stoneAnimation,
                        child: const Image(
                          height: 75,
                          width: 75,
                          image: AssetImage('stone.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Jump'),
            )
          ],
        ),
      ),
    );
  }
}
