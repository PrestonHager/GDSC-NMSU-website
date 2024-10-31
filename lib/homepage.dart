import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'custom_app_bar.dart';


class HomePage extends StatefulWidget {
  final Function(bool) onThemeChanged;

  const HomePage({super.key, required this.onThemeChanged});

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Google Developers Student Club\nNew Mexico State University", widget.onThemeChanged),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionTitle('Welcome to GDSC'), // Section title
              _buildAboutUsCard(),
              
              const SizedBox(height: 40), // Spacing between sections
              
              _buildSectionTitle('Gallery'),
              _buildGalleryCard(),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF8C0B42),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(221, 247, 243, 243),
        ),
      ),
    );
  }

  Widget _buildAboutUsCard() {
    return Card(

      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0), // Rounded corners
      ),
      
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
          gradient: const LinearGradient(
            colors: [Color.fromARGB(213, 77, 77, 77), Color.fromARGB(255, 182, 185, 187)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                'At GDSC NMSU, we’re a community of tech enthusiasts and problem-solvers passionate about learning and leveraging technology to make an impact. Whether you’re looking to expand your programming skills, explore new technologies, or connect with like-minded peers, our club offers you the chance to grow and collaborate. \n\nJoin us to attend mock interviews conducted by Google Engineers, work on real-world projects, and gain invaluable insights from guest speakers and Google experts. \n\nReady to build your future in tech? Become a part of GDSC NMSU (No prior programming experience required)!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20), // Spacing
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/events');
                }, 
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  textStyle: const TextStyle(fontSize: 18),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 0,
                ),
                child: Text('Club Activities'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGalleryCard() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 400, // Adjust for optimal image height
              child: CarouselSlider(
              options: CarouselOptions(
                height: 400.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              items: [
                'C:/Users/deyru/Desktop/gdsc/website/assets/img1.jpg',
                'C:/Users/deyru/Desktop/gdsc/website/assets/img2.jpg',
                'C:/Users/deyru/Desktop/gdsc/website/assets/img3.jpg',
              ].map((imagePath) {
                return Builder(
                builder: (BuildContext context) {
                  return _buildImageCard(imagePath);
                },
                );
              }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to create an image card
  Widget _buildImageCard(String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      width: 1600, // Fixed width for the card
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0), // Modern rounded corners
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 4),
          ),
        ],
        image: DecorationImage(
          image: AssetImage(imagePath), // Replace with your image
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
