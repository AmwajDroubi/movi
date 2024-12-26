
// import 'package:favorite_button/favorite_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movi/block/home_cubit/home_movi_cubit.dart';
// import 'package:movi/block/home_cubit/home_movi_state.dart';
// import 'package:movi/model/top_headline_model.dart';
// import 'package:movi/widget/details.dart';

// class AllPopular extends StatefulWidget {
//   const AllPopular({super.key});

//   @override
//   State<AllPopular> createState() => _AllPopularState();
// }

// class _AllPopularState extends State<AllPopular> {
//   @override
//   Widget build(BuildContext context) {
//     final homeCubit = BlocProvider.of<HomeCubit>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "All Popular movies",
//           style: TextStyle(
//               fontSize: 25,
//               fontFamily: "PlayfairDisplay",
//               color: Colors.blue[700]),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//             onPressed: Navigator.of(context).pop, icon: Icon(Icons.arrow_back)),
//       ),
//       body: BlocBuilder<HomeCubit, HomeState>(
//         bloc: homeCubit,
//         buildWhen: (previous, current) =>
//             current is HomeListLoaded ||
//             current is HomeListLoading ||
//             current is HomeListError,
//         builder: (context, state) {
//           if (state is HomeListLoaded) {
//             final movi = state.movies;
//             return ListView.builder(
//               itemCount: movi.length,
//               itemBuilder: (context, index) {
//                 final moviItem = movi[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(4.5),
//                   child: InkWell(
//                     onTap: () {
//                       // الانتقال إلى صفحة التفاصيل وتمرير المعطيات
//                       Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => MovieDetailsPage(
//                           movie: moviItem, // تمرير بيانات الفيلم
//                         ),
//                       ));
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.grey[200],
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Expanded(
//                                   flex: 1,
//                                   child: moviItem["poster_path"] != null
//                                       ? ClipRRect(
//                                           borderRadius: BorderRadius.only(
//                                               bottomLeft: Radius.circular(14),
//                                               topLeft: Radius.circular(14)),
//                                           child: Image.network(
//                                             'https://image.tmdb.org/t/p/w500${moviItem['poster_path']}',
//                                             width: 120,
//                                             height: 130,
//                                             fit: BoxFit.cover,
//                                           ),
//                                         )
//                                       : Icon(Icons.movie),
//                                 ),
//                                 Expanded(
//                                   flex: 3,
//                                   child: Column(
//                                     children: [
//                                       Text(
//                                         moviItem['title'] ??
//                                             'العنوان غير متوفر',
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold),
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(
//                                           moviItem['overview'] ??
//                                               'الملخص غير متوفر',
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.bold),
//                                           maxLines: 2,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Spacer(flex: 1),
                              
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else if (state is HomeListLoading) {
//             return Center(child: CircularProgressIndicator.adaptive());
//           } else if (state is HomeListError) {
//             return Center(child: Text(state.message));
//           } else {
//             return Container(color: Colors.amber);
//           }
//         },
//       ),
//     );
//   }
// }
