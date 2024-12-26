import 'package:flutter/material.dart';

class MovieDetailsPage extends StatelessWidget {
  final dynamic movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}',
                  height: 300,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Positioned(
                  top: 20,
                  left: 10,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back),
                    color: Colors.blue,
                    iconSize: 30,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              movie['title'] ?? 'العنوان غير متوفر',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              movie['release_date'] ?? 'التاريخ غير متوفر',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie['overview'] ?? 'الوصف غير متوفر',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("هذا الفيلم يعتبر من افلام "),
                  Text(
                    movie['genre_ids'].toString() ?? 'لا يوجد نوع',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            Text(
              movie['original_language'] ?? 'اللغة غير متوفرة',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
