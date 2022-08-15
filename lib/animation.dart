import 'dart:math';
import 'package:flutter/material.dart';

class PokemonGame extends StatefulWidget {
  const PokemonGame({Key? key}) : super(key: key);

  @override
  State<PokemonGame> createState() => _PokemonGameState();
}

class _PokemonGameState extends State<PokemonGame>
    with TickerProviderStateMixin {
  late AnimationController _pikachuController;
  late AnimationController _gameAnimation;

  late Animation _jumping;
  late bool _isJumped = true;
  late Animation _stoneController;
  int duration = 2500;

  @override
  void initState() {
    super.initState();

    _pikachuController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: duration),
    );

    _pikachuController.addListener(() => setState(() {}));
    _pikachuController.repeat(reverse: true);

    _gameAnimation =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    _gameAnimation.addListener(() => setState(() {}));

    _jumping = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0, -200))
        .animate(
            CurvedAnimation(parent: _gameAnimation, curve: Curves.decelerate));

    _stoneController =
        Tween<Offset>(begin: Offset(-200, 0), end: Offset(200, 0)).animate(
            CurvedAnimation(parent: _pikachuController, curve: Curves.linear));
  }

  @override
  void dispose() {
    _pikachuController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon Game'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Transform.translate(
                    offset: _jumping.value,
                    child: _isJumped
                        ? Image.asset(
                            'jump.png',
                            height: 85,
                            width: 85,
                          )
                        : Image.asset(
                            'stay.png',
                            height: 75,
                            width: 75,
                          ),
                  ),
                ),
                Center(
                  child: Transform.translate(
                    offset: _stoneController.value,
                    child: Image.asset(
                      'stone.png',
                      height: 75,
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _gameAnimation
                        .forward()
                        .whenComplete(() => _gameAnimation.reverse());
                    _isJumped = true;
                  });
                },
                child: const Text('Jump'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
