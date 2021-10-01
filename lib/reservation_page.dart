// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hot_desk_app/logedin_page.dart';

class ReservationPage extends StatelessWidget {
  const ReservationPage({Key? key}) : super(key: key);

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
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/appBackground.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    height: 200,
                    image: NetworkImage(
                        'https://www.kaspersky.es/content/es-es/images/repository/isc/2020/9910/a-guide-to-qr-codes-and-how-to-scan-qr-codes-2.png'),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Date: 10/01/2021',
                  style:
                      TextStyle(fontFamily: 'Barlow-Regular', fontSize: 20.0),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Desk: A35',
                  style:
                      TextStyle(fontFamily: 'Barlow-Regular', fontSize: 20.0),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Name: John Connor',
                  style:
                      TextStyle(fontFamily: 'Barlow-Regular', fontSize: 20.0),
                ),
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.green,
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
                      'New reservation',
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
            SizedBox(
              height: 5.0,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.red,
                ),
              ),
              onPressed: () {},
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Cancel reservation',
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
    );
    ;
  }
}
