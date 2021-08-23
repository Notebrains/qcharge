import 'package:flutter/material.dart';

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;
  final double iconSize;

  StarRating({this.starCount = 5, this.rating = .0, required this.onRatingChanged, required this.color, required this.iconSize,});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon =  Icon(
        Icons.star_border,
        size:  iconSize,
        color: Colors.amber[600],
      );
    }
    else if (index > rating - 1 && index < rating) {
      icon =  Icon(
        Icons.star_half,
        size:  iconSize,
        color: Colors.amber[600],
      );
    } else {
      icon =  Icon(
        Icons.star,
        size:  iconSize,
        color: Colors.amber[600],
      );
    }
    return  InkResponse(
      onTap: onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(starCount, (index) => buildStar(context, index),),);
  }
}