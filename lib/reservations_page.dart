// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hot_desk_app/reservation_page.dart';

class ReservationsPage extends StatelessWidget {
  const ReservationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 255, 105, 167),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Hot Desk App',
          style: TextStyle(
            fontFamily: 'Barlow-Regular',
            // ignore: todo
            // TODO: Create a theme
            color: Color.fromARGB(255, 255, 105, 167),
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                    builder: (context) => ReservationPage(),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'View reservation',
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
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/appBackground.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
