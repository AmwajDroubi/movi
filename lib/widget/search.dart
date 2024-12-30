//*_*
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movi/utils/app_constant.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>> srch = [];
  List<Map<String, dynamic>> slct = [];

  TextEditingController _searchController = TextEditingController();

  final String apiKey = AppConstants.moviApiKey;

  @override
  void initState() {
    super.initState();
    slct = srch;
  }

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      setState(() {
        srch = [];
        slct = [];
      });
      return;
    }

    final encodedQuery = Uri.encodeComponent(query);

    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$encodedQuery&language=ar'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> movies = data['results'];

      setState(() {
        srch = movies.map((movie) {
          return {
            "id": movie["id"],
            "name": movie["title"],
          };
        }).toList();
        slct = srch;
      });
    } else {
      throw Exception('فشل في تحميل الأفلام');
    }
  }

  void choose(String letter) {
    List<Map<String, dynamic>> result = [];
    if (letter.isEmpty) {
      result = srch;
    } else {
      result = srch
          .where((movie) =>
              movie["name"].toLowerCase().startsWith(letter.toLowerCase()))
          .toList();
    }

    setState(() {
      slct = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: screenHeight * .06),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: screenHeight * .065,
                  width: screenWidth * .8,
                  color: Colors.blue[100],
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: "بحث عن الأفلام",
                      suffixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      searchMovies(
                          value); 
                      choose(
                          value); 
                    },
                    textDirection: TextDirection.rtl, 
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: slct.length,
              itemBuilder: (context, index) => Card(
                key: ValueKey(slct[index]["id"]),
                child: ListTile(
                  leading: Icon(Icons.movie),
                  title: Text(
                    slct[index]["name"],
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
