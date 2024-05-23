// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_tablo/core/extensions.dart';
import 'package:e_tablo/views/image_detail/image_detail.dart';
import 'package:flutter/material.dart';

class MarketplaceView extends StatefulWidget {
  const MarketplaceView({super.key});

  @override
  State<MarketplaceView> createState() => _MarketplaceViewState();
}

class _MarketplaceViewState extends State<MarketplaceView> {
  int selectedIndex = 0; // Seçili kareyi takip etmek için bir index
  String _currentCategory = "art";

  Future<List<String>> getFirebaseData() async {
    var collection = FirebaseFirestore.instance.collection(_currentCategory);
    var querySnapshot = await collection.get();
    return querySnapshot.docs.map((doc) => doc['image'] as String).toList();
  }

  final List<Map<String, dynamic>> _categories = [
    {"name": "ART", "image": "assets/images/images_category/art.png", "firebase_name": "art"},
    {"name": "AI", "image": "assets/images/images_category/AI.jpg", "firebase_name": "Ai"},
    {"name": "TREND", "image": "assets/images/images_category/populer.jpg", "firebase_name": "trends"},
    {"name": "DOĞA", "image": "assets/images/images_category/snowing.jpg", "firebase_name": "natue"},
    {"name": "SÜRREAL", "image": "assets/images/images_category/surrealisme.jpg", "firebase_name": "surrealism"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // 10 kare
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          _currentCategory = _categories[index]["firebase_name"];
                        });
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            decoration: BoxDecoration(
                                image:
                                    DecorationImage(fit: BoxFit.cover, image: AssetImage("${_categories[index]["image"]}")),
                                borderRadius: BorderRadius.circular(15)),
                            width: selectedIndex == index ? 250.0 : 120.0, // Seçili kare geniş, diğerleri dar
                            margin: const EdgeInsets.all(5.0),
                          ),
                          Positioned(
                              child: Text(
                            _categories[index]["name"],
                            style: context.texts.titleLarge?.copyWith(color: Colors.white, letterSpacing: 3),
                          ))
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const Divider(),
            Expanded(
                flex: 3,
                child: FutureBuilder<List<String>>(
                  future: getFirebaseData(),
                  builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return imagesItems(
                        category: _currentCategory,
                        images: snapshot.data ?? [],
                      );
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}

class imagesItems extends StatelessWidget {
  const imagesItems({
    Key? key,
    required this.images,
    required this.category,
  }) : super(key: key);
  final List<String> images;
  final String category;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ImageDetail(
                          imageUrl: images[index],
                          heroTag: "images-$category-$index",
                          category: category,
                        )));
          },
          child: Hero(
            tag: "images-$category-$index",
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(fit: BoxFit.cover, image: CachedNetworkImageProvider(images[index])),
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey,
              ),
              margin: const EdgeInsets.all(10),
            ),
          ),
        );
      },
    );
  }
}
