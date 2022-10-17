import 'package:flutter/material.dart';

class CustomUserImage extends StatelessWidget {
  final String? url;
  final double height;
  final double width;
  final EdgeInsets? margin;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? boxBorder;
  final Widget? child;

  const CustomUserImage.small({
    Key? key,
    this.url,
    this.height = 60,
    this.width = 60,
    this.margin,
    this.boxShadow,
    this.boxBorder,
    this.child,
  }) : super(key: key);

  const CustomUserImage.medium({
    Key? key,
    this.url,
    this.height = 200,
    this.width = double.infinity,
    this.margin,
    this.boxShadow,
    this.boxBorder,
    this.child,
  }) : super(key: key);

  const CustomUserImage.large({
    Key? key,
    this.url,
    this.height = double.infinity,
    this.width = double.infinity,
    this.margin,
    this.boxShadow,
    this.boxBorder,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: (url == null)
              ? const NetworkImage('https://unsplash.com/photos/fhrWAh2HMnM')
              : NetworkImage(url!),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        border: boxBorder,
        boxShadow: boxShadow,
        color: Theme.of(context).primaryColor,
      ),
      child: child,
    );
  }
}
