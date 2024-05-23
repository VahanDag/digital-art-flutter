// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_tablo/core/extensions.dart';
import 'package:flutter/material.dart';

class ImageDetail extends StatefulWidget {
  const ImageDetail({
    Key? key,
    required this.imageUrl,
    required this.heroTag,
    required this.category,
  }) : super(key: key);

  final String imageUrl;
  final String heroTag;
  final String category;
  @override
  State<ImageDetail> createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Hero(
              tag: widget.heroTag,
              child: Container(
                height: 350,
                clipBehavior: Clip.antiAlias,
                width: context.width * 0.75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(fit: BoxFit.cover, image: CachedNetworkImageProvider(widget.imageUrl))),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(colors: [Colors.purple, Colors.blue])),
              width: context.width * 0.5,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(
                widget.category.toUpperCase(),
                style: context.texts.titleLarge?.copyWith(fontWeight: FontWeight.w700, color: Colors.white70),
              ),
            ),
            ElevatedButton(onPressed: () {}, child: const Text("Tabloda Göster"))
          ],
        ),
      ),
    );
  }
}
