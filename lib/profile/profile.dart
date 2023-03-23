import 'package:flutter/material.dart';


import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notepad/profile/callMethod.dart';
import 'package:notepad/profile/const.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Method method = Method();


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                backgroundColor: Color(0xffffA8B2D1),
                backgroundImage: AssetImage("images/rahul.png"),
                //radius: 100,
                maxRadius: 100,
              ),
              Text(
                "Md.Rahul Reza",
                style: myStyle(18, Color(0xffffA8B2D1), FontWeight.bold),
              ),Text(
                "Flutter App Developer",
                style: myStyle(14, Color(0xffffA8B2D1), FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      icon: FaIcon(FontAwesomeIcons.github),
                      color: Color(0xffffA8B2D1),
                      iconSize: 24.0,
                      onPressed: () {
                        method.launchURL(
                            "https://github.com/Rahulreza");
                      }),
                  IconButton(
                      icon: FaIcon(FontAwesomeIcons.linkedin),
                      color: Color(0xffffA8B2D1),
                      iconSize: 24.0,
                      onPressed: () {
                        method.launchURL(
                            "http://www.linkedin.com/in/rahul-reza");
                      }),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}