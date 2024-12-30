import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> searchResults = [];
  bool isLoading = false;
  final TextEditingController _searchController = TextEditingController();

  Future<void> _search(String query) async {
    if (query.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    try {
      final response =
      await Dio().get('https://api.tvmaze.com/search/shows?q=$query');
      setState(() {
        searchResults = response.data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching search results: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search movies...',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
          style: TextStyle(color: Colors.white),
          onSubmitted: _search,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              _search(_searchController.text.trim());
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : searchResults.isEmpty
          ? Center(
        child: Text(
          'Search for a movie!',
          style: TextStyle(color: Colors.white70, fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final movie = searchResults[index]['show'];
          return Card(
            margin: EdgeInsets.symmetric(
                horizontal: 10, vertical: 5),
            color: Colors.grey[900],
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 10, vertical: 10),
              leading: movie['image'] != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  movie['image']['medium'],
                  fit: BoxFit.cover,
                  width: screenWidth * 0.2,
                  height: screenHeight * 0.1,
                ),
              )
                  : Icon(Icons.movie, size: 50, color: Colors.white),
              title: Text(
                movie['name'] ?? 'Unknown Title',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                movie['summary'] != null
                    ? movie['summary']
                    .replaceAll(RegExp(r'<[^>]*>'), '')
                    : 'No summary available',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white70),
              ),
              onTap: () {
                // Navigate to the DetailsScreen when a movie is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                      movie: movie,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
