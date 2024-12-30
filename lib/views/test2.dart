// import 'package:flutter/material.dart';
// import 'package:movi/views/category_details.dart';

// class LanguageGiner extends StatefulWidget {
//   const LanguageGiner({super.key});

//   @override
//   _LanguageGinerState createState() => _LanguageGinerState();
// }

// class _LanguageGinerState extends State<LanguageGiner> {
//   String? selectedLanguage; // لا توجد قيمة بدائية
//   int? selectedGenre; // لا توجد قيمة بدائية

//   Map<String, String> languages = {
//     'ar': "العربية",
//     'en': "الإنجليزية",
//     'fr': "الفرنسية",
//   };

//   Map<int, String> genres = {
//     28: "الأكشن",
//     10749: "الرومنسي",
//     35: "الكوميديا",
//     18: "الدراما",
//     80: "الجريمة",
//     27: "الرعب",
//     878: "الخيال العلمي",
//     10752: "الحروب",
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('اختر اللغة والنوع'),
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SafeArea(
//           child: Column(
//             children: [
//               // اختر اللغة
//               Row(
//                 children: [
//                   Text(
//                     'اختر اللغة: ',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   Spacer(),
//                   DropdownButton<String>(
//                     value: selectedLanguage,
//                     hint: Text('اختر اللغة'),
//                     items: languages.keys.map((langCode) {
//                       return DropdownMenuItem<String>(
//                         value: langCode,
//                         child: Text(languages[langCode]!),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedLanguage = value;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),

//               // اختر النوع
//               Text(
//                 'اختر نوع الفيلم: ',
//                 style: TextStyle(fontSize: 18),
//               ),
//               SizedBox(height: 10),
//               Expanded(
//                 child: GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 1.5,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                   ),
//                   itemCount: genres.length,
//                   itemBuilder: (context, index) {
//                     int genreId = genres.keys.elementAt(index);
//                     String genreName = genres[genreId]!;

//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           selectedGenre = genreId;
//                         });
//                       },
//                       child: Card(
//                         color: selectedGenre == genreId
//                             ? Colors.blue
//                             : Colors.white,
//                         elevation: 5,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Center(
//                           child: Text(
//                             genreName,
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: selectedGenre == genreId
//                                   ? Colors.white
//                                   : Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),

//               // زر للانتقال إلى صفحة عرض الأفلام
//               ElevatedButton(
//                 onPressed: () {
//                   if (selectedLanguage != null && selectedGenre != null) {
//                     // الانتقال إلى صفحة عرض الأفلام عند اختيار اللغة والنوع
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => MoviesPage(
//                           selectedLanguage: selectedLanguage!,
//                           selectedGenre: selectedGenre!,
//                         ),
//                       ),
//                     );
//                   } else {
//                     // إذا لم يتم اختيار اللغة أو النوع، عرض رسالة
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('يرجى اختيار اللغة والنوع')),
//                     );
//                   }
//                 },
//                 child: Text('عرض الأفلام'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:movi/utils/app_constant.dart'; // تأكد من صحة المسار

// // class LanguageGiner extends StatefulWidget {
// //   const LanguageGiner({super.key});

// //   @override
// //   _LanguageGinerState createState() => _LanguageGinerState();
// // }

// // class _LanguageGinerState extends State<LanguageGiner> {
// //   final String apiKey = AppConstants.moviApiKey; // تأكد من أنك تعرف قيمة API Key بشكل صحيح
// //   final String apiUrl = 'https://api.themoviedb.org/3/discover/movie';

// //   List movies = [];
// //   String? selectedLanguage; // لا توجد قيمة بدائية
// //   int? selectedGenre; // لا توجد قيمة بدائية

// //   bool isLoading = false; // لعرض مؤشر التحميل أثناء جلب البيانات

// //   Map<String, String> languages = {
// //     'ar': "العربية",
// //     'en': "الإنجليزية",
// //     'fr': "الفرنسية",
// //   };

// //   Map<int, String> genres = {
// //     28: "الأكشن",
// //     10749: "الرومنسي",
// //     35: "الكوميديا",
// //     18: "الدراما",
// //     80: "الجريمة",
// //     27: "الرعب",
// //     878: "الخيال العلمي",
// //     10752: "الحروب",
// //   };

// //   @override
// //   void initState() {
// //     super.initState();
// //   }

// //   // دالة لجلب الأفلام بناءً على اللغة والنوع المحدد
// //   Future<void> fetchMovies() async {
// //     if (selectedLanguage == null || selectedGenre == null) {
// //       // إذا لم يتم تحديد اللغة أو النوع، لا نقوم بتحميل الأفلام
// //       return;
// //     }

// //     setState(() {
// //       isLoading = true; // تفعيل مؤشر التحميل
// //     });

// //     final url = Uri.parse(
// //       '$apiUrl?api_key=$apiKey&language=$selectedLanguage&with_genres=$selectedGenre&page=1',
// //     );
// //     try {
// //       final response = await http.get(url);

// //       if (response.statusCode == 200) {
// //         final data = json.decode(response.body);
// //         setState(() {
// //           movies = data['results'];
// //         });
// //       } else {
// //         print('فشل في تحميل الأفلام: ${response.statusCode}');
// //         setState(() {
// //           movies = []; // إذا فشل التحميل، اجعل القائمة فارغة
// //         });
// //       }
// //     } catch (e) {
// //       print('حدث خطأ: $e');
// //       setState(() {
// //         movies = []; // في حالة حدوث استثناء، اجعل القائمة فارغة
// //       });
// //     } finally {
// //       setState(() {
// //         isLoading = false; // إيقاف مؤشر التحميل بعد تحميل البيانات
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('اختر اللغة والنوع'),
// //         backgroundColor: Colors.blue,
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(8.0),
// //         child: SafeArea(
// //           child: Column(
// //             children: [
// //               // اختر اللغة
// //               Row(
// //                 children: [
// //                   Text(
// //                     'اختر اللغة: ',
// //                     style: TextStyle(fontSize: 18),
// //                   ),
// //                   Spacer(),
// //                   DropdownButton<String>(
// //                     value: selectedLanguage,
// //                     hint: Text('اختر اللغة'),
// //                     items: languages.keys.map((langCode) {
// //                       return DropdownMenuItem<String>(
// //                         value: langCode,
// //                         child: Text(languages[langCode]!),
// //                       );
// //                     }).toList(),
// //                     onChanged: (value) {
// //                       setState(() {
// //                         selectedLanguage = value;
// //                       });
// //                       fetchMovies(); // تحديث الأفلام بناءً على اللغة المختارة
// //                     },
// //                   ),
// //                 ],
// //               ),
// //               SizedBox(height: 16),

// //               // اختر النوع
// //               Text(
// //                 'اختر نوع الفيلم: ',
// //                 style: TextStyle(fontSize: 18),
// //               ),
// //               SizedBox(height: 10),
// //               Expanded(
// //                 child: GridView.builder(
// //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                     crossAxisCount: 2,
// //                     childAspectRatio: 1.5,
// //                     crossAxisSpacing: 10,
// //                     mainAxisSpacing: 10,
// //                   ),
// //                   itemCount: genres.length,
// //                   itemBuilder: (context, index) {
// //                     int genreId = genres.keys.elementAt(index);
// //                     String genreName = genres[genreId]!;

// //                     return GestureDetector(
// //                       onTap: () {
// //                         setState(() {
// //                           selectedGenre = genreId;
// //                         });
// //                         fetchMovies(); // تحميل الأفلام بناءً على النوع المختار
// //                       },
// //                       child: Card(
// //                         color: selectedGenre == genreId
// //                             ? Colors.blue
// //                             : Colors.white,
// //                         elevation: 5,
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(10),
// //                         ),
// //                         child: Center(
// //                           child: Text(
// //                             genreName,
// //                             textAlign: TextAlign.center,
// //                             style: TextStyle(
// //                               fontSize: 18,
// //                               fontWeight: FontWeight.bold,
// //                               color: selectedGenre == genreId
// //                                   ? Colors.white
// //                                   : Colors.black,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                 ),
// //               ),

// //               // عرض الأفلام بناءً على النوع المحدد
// //               SizedBox(height: 16),
// //               Text('الأفلام:'),
// //               Expanded(
// //                 child: isLoading
// //                     ? Center(child: CircularProgressIndicator()) // عرض مؤشر التحميل عند الجلب
// //                     : (selectedLanguage == null || selectedGenre == null)
// //                         ? Center(child: Text('يرجى اختيار اللغة والنوع'))
// //                         : movies.isEmpty
// //                             ? Center(child: Text('لا توجد أفلام لعرضها')) // إذا كانت القائمة فارغة
// //                             : ListView.builder(
// //                                 itemCount: movies.length,
// //                                 itemBuilder: (context, index) {
// //                                   final movie = movies[index];
// //                                   return Card(
// //                                     margin: EdgeInsets.symmetric(vertical: 8),
// //                                     child: ListTile(
// //                                       leading: movie['poster_path'] != null
// //                                           ? Image.network(
// //                                               'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
// //                                               height: 120,
// //                                               width: 80,
// //                                               fit: BoxFit.cover,
// //                                             )
// //                                           : Icon(Icons.movie),
// //                                       title: Text(
// //                                         movie['title'] ?? 'بدون عنوان',
// //                                         style: TextStyle(fontSize: 18),
// //                                       ),
// //                                       subtitle: Text(
// //                                         movie['overview'] ?? 'لا يوجد وصف',
// //                                         style: TextStyle(fontSize: 14),
// //                                         maxLines: 2,
// //                                         overflow: TextOverflow.ellipsis,
// //                                       ),
// //                                     ),
// //                                   );
// //                                 },
// //                               ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
