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

  final String apiKey = AppConstants.moviApiKey; // قم بإضافة مفتاح API الخاص بك من TMDB

  @override
  void initState() {
    super.initState();
    slct = srch; // في البداية، لا توجد بيانات للبحث
  }

  // دالة للبحث عن الأفلام عبر API
  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      setState(() {
        srch = [];
        slct = [];
      });
      return;
    }

    // URL Encoding للنص المدخل ليتم معالجته بشكل صحيح
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
            "name": movie["title"], // اسم الفيلم
          };
        }).toList();
        slct = srch;
      });
    } else {
      throw Exception('فشل في تحميل الأفلام');
    }
  }

  // تعديل دالة choose لتصفية النتائج بناءً على الحرف الأول فقط
  void choose(String letter) {
    List<Map<String, dynamic>> result = [];
    if (letter.isEmpty) {
      result = srch; // إذا كان النص فارغًا، نعرض جميع النتائج
    } else {
      result = srch
          .where((movie) => movie["name"]
              .toLowerCase()
              .startsWith(letter.toLowerCase())) // استخدام startsWith
          .toList();
    }

    setState(() {
      slct = result; // تحديث النتائج المعروضة
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40),
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
                  height: 60,
                  width: 345,
                  color: Colors.blue[100],
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: "بحث عن الأفلام",
                      suffixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      searchMovies(value); // عند تغيير النص، نقوم بالبحث عن الأفلام
                      choose(value); // نقوم بتصفية النتائج بناءً على الحرف الأول
                    },
                    textDirection: TextDirection.rtl,  // تحديد اتجاه النص
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: slct.length, // عرض النتائج المفلترة
              itemBuilder: (context, index) => Card(
                key: ValueKey(slct[index]["id"]),
                child: ListTile(
                  leading: Icon(Icons.movie),
                  title: Text(
                    slct[index]["name"],
                    textDirection: TextDirection.rtl,  // تحديد اتجاه النص لعرض العربية بشكل صحيح
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
