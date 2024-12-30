//*_*

import 'package:flutter/material.dart';
import 'package:movi/views/first.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcom To Pop Movies App",
            style: TextStyle(
                fontSize: screenWidth * .075,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontFamily: "PlayfairDisplay",
                fontStyle: FontStyle.italic),
          ),
          SizedBox(
            height: screenHeight * .01,
          ),
          Container(
              height: screenHeight * .4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset("assets/image/pop.jpg",
                    fit: BoxFit.fill, width: screenWidth * .9),
              )),
          Text(
            " Pop Movies",
            style: TextStyle(
                fontSize: screenWidth * .15,
                color: Colors.blue,
                fontFamily: "Trirong",
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: screenHeight * .08,
          ),
          Container(
            height: screenHeight * .09,
            color: Colors.blue[200],
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SecondPAge()));
                },
                child: Text(
                  "Click to continue",
                  style: TextStyle(
                      fontSize: screenWidth * .06,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontFamily: "PlayfairDisplay"),
                )),
          )
        ],
      )),
    );
  }
}
