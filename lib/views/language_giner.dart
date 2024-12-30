import 'package:flutter/material.dart';
import 'package:movi/views/category_details.dart';

class LanguageGiner extends StatefulWidget {
  const LanguageGiner({super.key});

  @override
  _LanguageGinerState createState() => _LanguageGinerState();
}

class _LanguageGinerState extends State<LanguageGiner> {
  String? selectedLanguage;
  int? selectedGenre;
  Map<String, String> languages = {
    'ar': "العربية",
    'en': "الإنجليزية",
    'fr': "الفرنسية",
  };

  Map<int, String> genres = {
    28: "الأكشن",
    10749: "الرومنسي",
    35: "الكوميديا",
    18: "الدراما",
    80: "الجريمة",
    27: "الرعب",
    878: "الخيال العلمي",
    10752: "الحروب",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  // Text(
                  //   'اختر اللغة: ',
                  //   style: TextStyle(fontSize: 18),
                  // ),
                  // Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      value: selectedLanguage,
                      hint: Text('اختر اللغة'),
                      items: languages.keys.map((langCode) {
                        return DropdownMenuItem<String>(
                          value: langCode,
                          child: Text(languages[langCode]!),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedLanguage = value;
                        });
                      },
                    ),
                  ),
                  Spacer(),
                  Text(
                    '  : اختر اللغة ',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // اختر النوع
              Text(
                '  :  اختر نوع الفيلم ',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: genres.length,
                  itemBuilder: (context, index) {
                    int genreId = genres.keys.elementAt(index);
                    String genreName = genres[genreId]!;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedGenre = genreId;
                        });

                        // تحميل الأفلام مباشرة عند اختيار النوع
                        if (selectedLanguage != null && selectedGenre != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MoviesPage(
                                selectedLanguage: selectedLanguage!,
                                selectedGenre: selectedGenre!,
                              ),
                            ),
                          );
                        } else {
                          // إذا لم يتم اختيار اللغة أو النوع
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('يرجى اختيار اللغة والنوع')),
                          );
                        }
                      },
                      child: Card(
                        color: selectedGenre == genreId
                            ? Colors.blue
                            : Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            genreName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: selectedGenre == genreId
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
