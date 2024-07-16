import 'package:flutter/material.dart';

class RawButton extends StatelessWidget {
  const RawButton({
    super.key,
    required this.child,
    required this.onTap,
    this.onLongPress,
    this.radius = 8,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.elevation = 0,
  });

  final Widget child;
  final Function onTap;
  final Function? onLongPress;
  final double radius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    //Custom button widget
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Material(
          child: InkWell(
            onTap: ()=> onTap(),
            onLongPress: ()=> onLongPress!= null ? onLongPress!() : onTap(),
            child: Container(
                padding: padding,
                child: child
            ),
          ),
        ),
      ),
    );
  }
}


