import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerMapPlaceholder extends StatelessWidget {
  final double height;

  const ShimmerMapPlaceholder({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
