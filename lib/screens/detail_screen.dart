import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final dynamic movie;

  DetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          movie['name'] ?? 'Movie Details',
          style: TextStyle(fontSize: screenWidth * 0.045),
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            movie['image'] != null
                ? Image.network(
              movie['image']['original'],
              width: double.infinity,
              height: screenHeight * 0.4,
              fit: BoxFit.cover,
            )
                : Container(
              height: screenHeight * 0.4,
              color: Colors.grey[800],
              child: Center(
                child: Icon(Icons.movie, size: 50, color: Colors.white),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              movie['name'] ?? 'Unknown Title',
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.08,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              movie['summary'] != null
                  ? movie['summary'].replaceAll(RegExp(r'<[^>]*>'), '')
                  : 'No summary available',
              style: TextStyle(color: Colors.white70, fontSize: screenWidth * 0.045),
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
