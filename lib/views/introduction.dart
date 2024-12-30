import 'package:flutter/material.dart';
import 'package:movi/views/first.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcom To Pop Movies App",
            style: TextStyle(
                fontSize: 32,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontFamily: "PlayfairDisplay",
                fontStyle: FontStyle.italic),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
              height: 370,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset("assets/image/pop.jpg",
                    fit: BoxFit.fill, width: 370),
              )),
          Text(
            " Pop Movies",
            style: TextStyle(
                fontSize: 45,
                color: Colors.blue,
                fontFamily: "Trirong",
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 80,
          ),
          Container(
            height: 60,
            // width: 150,
            color: Colors.blue[200],
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SecondPAge()));
                },
                child: Text(
                  "Click to continue",
                  style: TextStyle(
                      fontSize: 24,
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
