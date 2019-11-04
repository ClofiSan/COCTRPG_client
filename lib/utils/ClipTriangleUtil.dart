import 'dart:math' as Math;
import 'package:flutter/material.dart';
class ClipTriangle extends CustomClipper<Path>{

  final bool isKeeper;

  ClipTriangle({this.isKeeper});

  /// 角度转弧度公式
  double degree2Radian(int degree) {
    return (Math.pi * degree / 180);
  }

  @override
  Path getClip(Size size) {
    // TODO: implement getClip

    Path path = new Path();
    if(this.isKeeper){
      path.moveTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.lineTo(size.width, (size.height-size.width*Math.tan(degree2Radian(60))));
    }else{
      path.moveTo(0.0, 0.0);
      path.lineTo(size.width, 0);
      path.lineTo(0, size.width*Math.tan(degree2Radian(60)));
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(ClipTriangle oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }

}

