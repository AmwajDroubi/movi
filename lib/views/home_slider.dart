

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movi/block/home_cubit/home_movi_cubit.dart';
// import 'package:movi/block/home_cubit/home_movi_state.dart';
// import 'package:movi/model/top_headline_model.dart';

// class HomeCarouselSlider extends StatefulWidget {
//   const HomeCarouselSlider({super.key});



//   @override
//   State<StatefulWidget> createState() {
//     return _HomeCarouselSliderState();
//   }
// }

// class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
//   final List<String> images = [
//     'https://images.unsplash.com/photo-1586882829491-b81178aa622e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
//     'https://images.unsplash.com/photo-1586871608370-4adee64d1794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2862&q=80',
//     'https://images.unsplash.com/photo-1586901533048-0e856dff2c0d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
//     'https://images.unsplash.com/photo-1586902279476-3244d8d18285?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
//     'https://images.unsplash.com/photo-1586943101559-4cdcf86a6f87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1556&q=80',
//     'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
//     'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
//   ];

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       images.forEach((imageUrl) {
//         precacheImage(NetworkImage(imageUrl), context);
//       });
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final homeCubit = BlocProvider.of<HomeCubit>(context);

//     return Scaffold(
//       body: BlocBuilder<HomeCubit, HomeState>(
//         bloc: homeCubit,
//         buildWhen: (previous, current) =>
//             current is HomeCarouselLoading ||
//             current is HomeCarouselLoaded ||
//             current is HomeCarouselError,
//         builder: (context, state) {
//           if (state is HomeCarouselLoaded) {
//             return Container(
//               child: CarouselSlider.builder(
//                 itemCount: images.length,
//                 options: CarouselOptions(
//                   autoPlay: true,
//                   aspectRatio: 2.0,
//                   enlargeCenterPage: true,
//                 ),
//                 itemBuilder: (context, index, realIdx) {
//                   return Container(
//                     child: Center(
//                         child: Image.network(images[index],
//                             fit: BoxFit.cover, width: 1000)),
//                   );
//                 },
//               ),
//             );
//           } else if (state is HomeCarouselLoading) {
//             return const Center(
//               child: CircularProgressIndicator.adaptive(),
//             );
//           } else if (state is HomeCarouselError) {
//             return Center(
//               child: Text(state.message),
//             );
//           } else {
//             return Container(
//               color: Colors.black,
//             );
//           }
//         },
//       ),
//     );
//   }
// }
