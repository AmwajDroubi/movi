//*_*
import 'package:flutter/material.dart';
import 'package:movi/views/home_movi.dart';
import 'package:movi/views/language_giner.dart';
import 'package:movi/widget/search.dart';

class SecondPAge extends StatefulWidget {
  const SecondPAge({
    Key? key,
  }) : super(key: key);

  @override
  State<SecondPAge> createState() => _SecondPAge();
}

class _SecondPAge extends State<SecondPAge> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: "Home"),
              Tab(text: "Category"),
            ],
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SearchPage(),
                  ),
                );
              },
              icon: Icon(Icons.search)),
        ),
        body: const Column(
          children: [
            Expanded(
              flex: 3,
              child: TabBarView(
                children: [
                  HomeBasic(),
                  LanguageGiner(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
