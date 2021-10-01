// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hot_desk_app/logedin_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/appBackground.png',
                ), // Credits to https://dribbble.com/shots/6618829-Abstract-Background-for-Mobile-Instagram
                fit: BoxFit.cover)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 100.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hot Desk App',
                    style: TextStyle(
                      fontFamily: 'Barlow-Black',
                      color: Color.fromARGB(255, 255, 105, 167),
                      fontSize: 50.0,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'The best desk booking app.',
                  style: TextStyle(
                    color: Color.fromARGB(255, 204, 204, 204),
                    fontFamily: 'Barlow-Light',
                    fontSize: 25.0,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    height: 200,
                    image: NetworkImage(
                        'https://www.pngmart.com/files/7/Computer-Desk-Transparent-PNG.png'),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 100.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 255, 105, 167),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LogedinPage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Barlow-Regular',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
