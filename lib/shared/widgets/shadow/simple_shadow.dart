import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SimpleShadow extends StatelessWidget {
  final Widget child;
  final double opacity;
  final double sigma;
  final Color color;
  final Offset offset;
  SimpleShadow({
    required this.child,
    this.opacity = 0.5,
    this.sigma = 2,
    this.color = Colors.black,
    this.offset = const Offset(2, 2),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Transform.translate(
          offset: offset,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaY: sigma, sigmaX: sigma),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.transparent,
                  width: 0,
                ),
              ),
              child: Opacity(
                opacity: opacity,
                child: child,
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class Blur {
  final double sigmaX;
  final double sigmeY;
  const Blur(this.sigmaX, this.sigmeY);
}

class ExShadow extends StatelessWidget {
  final double opacity;
  final double scale;
  final Widget child;
  final Offset offset;
  final Blur blur;
  final ImageProvider<Object> image;
  ExShadow({
    this.opacity = 0.5,
    required this.child,
    this.scale = 1,
    this.offset = const Offset(5, 5),
    this.blur = const Blur(1, 1),
    required this.image,
  }) : assert(opacity >= 0 && opacity <= 1);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Transform.translate(
          offset: offset,
          child: Transform.scale(
              scale: scale,
              child: Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: image,
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: new Container(
                    decoration:
                        new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
              )),
        ),
        Transform.translate(
            offset: Offset(-10, -10),
            child: Transform.scale(scale: 1, child: child)),
      ],
    );
  }
}
