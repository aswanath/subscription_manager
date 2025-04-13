import 'dart:async';

import 'package:flutter/material.dart';
import 'package:subsciption_manager/config/constants/app_constants.dart';

const List<double> xInitialPositions = [
  -140.0,
  70.0,
  -90.0,
  20.0,
  -35.5,
];

const List<int> logoSwapPositions = [
  2,
  0,
  4,
  1,
  3,
];

class AnimatedLogos extends StatefulWidget {
  const AnimatedLogos({super.key});

  @override
  State<AnimatedLogos> createState() => _AnimatedLogosState();
}

class _AnimatedLogosState extends State<AnimatedLogos>
    with SingleTickerProviderStateMixin {
  late List<_Circle> _logos = [];
  late List<double> _xPosition = [];
  late final Timer _timer;
  bool _initial = true;

  List<double> _swapPositionItems<T>(List<double> list) {
    return [
      list[1],
      list[3],
      list[0],
      list[4],
      list[2],
    ];
  }

  List<T> _swapLogoItems<T>(List<T> list) {
    final List<T> newList = [];
    for (int i = 0; i < list.length; i++) {
      newList.add(list[logoSwapPositions[i]]);
    }
    return newList;
  }

  @override
  void initState() {
    super.initState();
    _xPosition.addAll([
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
    ]);
    _logos.addAll(
      AppConstants.subscriptions.values.take(5).map(
            (e) => _Circle(
              imagePath: e.imagePath,
              size: 62.0,
            ),
          ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _initial = false;
        _xPosition = List.from(xInitialPositions);
      });
      Future.delayed(Durations.long4, () {
        _timer = Timer.periodic(const Duration(seconds: 2), (_) {
          setState(() {
            _xPosition = _swapPositionItems(_xPosition);
          });
          Future.delayed(Durations.medium4, () {
            setState(() {
              _logos = _swapLogoItems(_logos);
              _xPosition = _swapLogoItems(_xPosition);
            });
          });
        });
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      width: width,
      height: MediaQuery.sizeOf(context).height * 0.25,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          DecoratedBox(
            key: const Key("logoBackgroundDecoratedBoxKey"),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppConstants.subscriptions.values
                      .firstWhere((e) => _logos[4].imagePath == e.imagePath)
                      .glowColor,
                  blurRadius: 100,
                  spreadRadius: 50,
                ),
              ],
            ),
          ),
          ...List.generate(
            5,
            (index) => AnimatedPositioned(
              key: Key("logoAnimatedPositionedKey$index"),
              left: width * (_initial ? 0.4 : 0.5) + (_xPosition[index]),
              top: _initial ? MediaQuery.sizeOf(context).height * 0.8 : null,
              duration: Durations.medium2,
              child: _logos[index]
                ..size = index == 4
                    ? 76.0
                    : index == 2 || index == 3
                        ? 68.0
                        : 60.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  final String imagePath;
  double size;

  _Circle({
    required this.imagePath,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key("circleContainerKey"),
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Image.asset(
          imagePath,
          key: const Key("logoImageKey"),
        ),
      ),
    );
  }
}
