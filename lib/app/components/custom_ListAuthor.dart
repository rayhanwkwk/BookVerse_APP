import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListAuthor extends StatelessWidget {
  final context;

  CustomListAuthor({
    super.key,
    required this.context,
  });

  List<CardItem> items = const [
    CardItem(
      imageURl: "assets/avatar/Avatar5.png",
      judulBuku: "Habiburrahman",
    ),
    CardItem(
      imageURl: "assets/avatar/Avatar2.png",
      judulBuku: "Andrea Hirata",
    ),
    CardItem(
      imageURl: "assets/avatar/Avatar3.png",
      judulBuku: "Pidi Baiq",
    ),
    CardItem(
      imageURl: "assets/avatar/Avatar4.png",
      judulBuku: "Asma Nadia",
    ),
    CardItem(
      imageURl: "assets/avatar/Avatar1.png",
      judulBuku: "Raditya Dika",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 165,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount : 5,
        separatorBuilder: (context, _) => const SizedBox(width: 10,),
        itemBuilder: (context, index) => builCard(items:items[index]),
      ),
    );
  }

  Widget builCard({
    required CardItem items,})=> Container(
    width: 125,
    height: 165,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.black.withOpacity(0.10),
        width: 0.3
      )
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  items.imageURl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.fitWidth,
                ),
              ),

              // Button Overlay
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    // Handle button tap (e.g., open image picker)
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF5F5F5),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: const Icon(
                      Icons.stars_rounded,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 10,
          ),

          FittedBox(
            child: Text(
              items.judulBuku,
              maxLines: 1,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16.0,
                letterSpacing: -0.3,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    ),
  );
}

class CardItem {
  final String imageURl;
  final String judulBuku;

  const CardItem({
    required this.imageURl,
    required this.judulBuku,
});
}
