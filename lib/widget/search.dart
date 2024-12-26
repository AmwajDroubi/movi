// import 'package:flutter/material.dart';

// class SearchPage extends StatefulWidget {
//   const SearchPage({super.key});

//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   List<Map<String, dynamic>> srch = [
//     {"id": 1, "name": "amwaj"},
//     {"id": 2, "name": "Ronza"},
//     {"id": 3, "name": "Saeed"},
//     {"id": 4, "name": "Mohhamed"},
//     {"id": 5, "name": "Mahar"},
//     {"id": 6, "name": "abd"},
//   ];
//   List<Map<String, dynamic>> slct = [];

//   TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     slct = srch; // في البداية، تكون جميع البيانات معروضة
//   }

//   void choose(String letter) {
//     List<Map<String, dynamic>> result = [];
//     if (letter.isEmpty) {
//       result = srch; // إذا كان النص المدخل فارغًا، نعرض جميع العناصر
//     } else {
//       result = srch
//           .where((user) =>
//               user["name"].toLowerCase().contains(letter.toLowerCase()))
//           .toList(); // تصفية البيانات بناءً على النص المدخل
//     }

//     setState(() {
//       slct = result; // تحديث حالة الصفحة
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(height: 40),
//           TextField(
//             controller:
//                 _searchController, // استخدام الـ controller لإدارة النص المدخل
//             decoration: InputDecoration(
//               labelText: "Search",
//               suffixIcon: Icon(Icons.search),
//             ),
//             onChanged: (value) {
//               choose(value); // استدعاء دالة البحث عند تغيير النص
//             },
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: slct.length, // عرض النتائج التي تم تصفيتها
//               itemBuilder: (context, index) => Card(
//                 key: ValueKey(slct[index]["id"]),
//                 child: ListTile(
//                   leading: Text(slct[index]["id"].toString()),
//                   title: Text(slct[index]["name"]),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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

  final String apiKey =
      AppConstants.moviApiKey; // قم بإضافة مفتاح API الخاص بك من TMDB

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

    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query'));

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
      throw Exception('Failed to load movies');
    }
  }

  void choose(String letter) {
    List<Map<String, dynamic>> result = [];
    if (letter.isEmpty) {
      result = srch; // إذا كان النص المدخل فارغًا، نعرض جميع العناصر
    } else {
      result = srch
          .where((movie) =>
              movie["name"].toLowerCase().contains(letter.toLowerCase()))
          .toList(); // تصفية البيانات بناءً على النص المدخل
    }

    setState(() {
      slct = result; // تحديث حالة الصفحة
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40
          ),
          TextField(
            controller:
                _searchController, // استخدام الـ controller لإدارة النص المدخل
            decoration: InputDecoration(
              labelText: "Search Movies",
              suffixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              searchMovies(value); // استدعاء دالة البحث عند تغيير النص
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: slct.length, // عرض النتائج التي تم تصفيتها
              itemBuilder: (context, index) => Card(
                key: ValueKey(slct[index]["id"]),
                child: ListTile(
                  leading: Icon(Icons.movie), // يمكنك إضافة صورة هنا إذا أردت
                  title: Text(slct[index]["name"]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
