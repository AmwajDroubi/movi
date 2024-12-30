//*_*
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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      value: selectedLanguage,
                      hint: const Text('اختر اللغة'),
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
                  const Spacer(),
                  Text(
                    '  : اختر اللغة ',
                    style: TextStyle(
                        fontSize: screenWidth * .047, color: Colors.grey[700]),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * .001),
              Text(
                '  :  اختر نوع الفيلم ',
                style: TextStyle(
                    fontSize: screenWidth * .047, color: Colors.grey[700]),
              ),
              SizedBox(height: screenHeight * .009),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('يرجى اختيار اللغة والنوع')),
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
                              fontSize: screenWidth * .047,
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
