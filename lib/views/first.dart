import 'package:flutter/material.dart';

import 'package:movi/views/home_movi.dart';
import 'package:movi/views/language_giner.dart';
import 'package:movi/views/test2.dart';

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
        ),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: TabBarView(
                children: [
                  // BlocProvider(
                  // create: (context) {
                  //   final cubit = HomeCubit();
                  //   cubit.getHomeData();
                  //   return cubit;
                  // },
                  //  child:
                  HomeBasic(),
                  // ),
                  // BlocProvider(
                  //   create: (context) {
                  //     final cubit = CategoryCubit();
                  //     cubit.getCategoryData();
                  //     return cubit;
                  //   },
                  // child:
                  LanguageGiner(),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
