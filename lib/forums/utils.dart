import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class Utils{
  static String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      if (diff.inHours > 0) {
        time = '${diff.inHours} hours';
      } else if (diff.inMinutes > 0) {
        time = '${diff.inMinutes} minutes';
      } else if (diff.inSeconds > 0) {
        time = 'now';
      } else if (diff.inMilliseconds > 0) {
        time = 'now';
      } else if (diff.inMicroseconds > 0) {
        time = 'now';
      } else {
        time = 'now';
      }
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      time = '${diff.inDays} days';
    } else if (diff.inDays > 6) {
      time = '${(diff.inDays / 7).floor()} weeks';
    } else if (diff.inDays > 29) {
      time = '${(diff.inDays / 30).floor()} months';
    } else if (diff.inDays > 365) {
      time = '${date.month} ${date.day}, ${date.year}';
    }
    return time;
  }

  static Widget cacheNetworkImageWithEvent(context,String imageURL,double width, double height){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child:
        CachedNetworkImage(
          imageUrl: imageURL,
          placeholder: (context, url) => Container(
            transform: Matrix4.translationValues(0.0, 0.0, 0.0),
            child: SizedBox(
                width: width,
                height: height,
                child: const Center(child: CircularProgressIndicator())),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          width: 500,
          height: 300,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

}
