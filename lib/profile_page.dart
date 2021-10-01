// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
              margin: EdgeInsets.only(top: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 120.0,
                    backgroundColor: Color.fromARGB(255, 255, 105, 167),
                    child: CircleAvatar(
                      radius: 115.0,
                      backgroundImage: NetworkImage(
                        'https://randomuser.me/api/portraits/men/71.jpg',
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Center(
                    child: Text(
                      'First name',
                      style: TextStyle(
                        fontFamily: 'Barlow-Bold',
                      ),
                    ),
                  ),
                  subtitle: Center(
                    child: Text(
                      'Dummy first name',
                      style: TextStyle(
                        fontFamily: 'Barlow-Light',
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Center(
                    child: Text(
                      'Last name',
                      style: TextStyle(
                        fontFamily: 'Barlow-Bold',
                      ),
                    ),
                  ),
                  subtitle: Center(
                    child: Text(
                      'Dummy last name',
                      style: TextStyle(
                        fontFamily: 'Barlow-Light',
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Center(
                    child: Text(
                      'Email',
                      style: TextStyle(
                        fontFamily: 'Barlow-Bold',
                      ),
                    ),
                  ),
                  subtitle: Center(
                    child: Text(
                      'dummyemail@gmail.com',
                      style: TextStyle(
                        fontFamily: 'Barlow-Light',
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Center(
                    child: Text(
                      'Last reservation',
                      style: TextStyle(
                        fontFamily: 'Barlow-Bold',
                      ),
                    ),
                  ),
                  subtitle: Center(
                    child: Text(
                      'Mesa A35 - 25/09/2021',
                      style: TextStyle(
                        fontFamily: 'Barlow-Light',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
