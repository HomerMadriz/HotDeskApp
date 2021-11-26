// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, await_only_futures

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hot_desk_app/logedin_page.dart';
import 'package:hot_desk_app/models/user.dart' as user_model;
import 'package:hot_desk_app/providers/google_sign_in.dart';
import 'package:hot_desk_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          print(snapshot.data);
          //String snapshotString = snapshot.data!
          //.toString();
          // snapshotString.substring(snapshotString.indexOf('uid'));
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            User user = snapshot.data as User;
            // user_model.User newUser = user_model.User();
            String firstName = user.displayName!.split(' ')[0];
            String lastName = user.displayName!.split(' ')[1];
            user_model.User newUser = user_model.User(
              email: user.email,
              firstName: firstName,
              lastName: lastName,
              profilePicture: user.photoURL,
              id: user.uid,
            );
            return LogedinPage(
              userInfo: newUser,
            );
          } else {
            return buildLogin(context);
          }
        },
      ),
    );
  }

  Widget buildLogin(context) {
    return Container(
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
            child: Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 255, 105, 167),
                        ),
                      ),
                      onPressed: () async {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.googleLogin();
                        //  TODO: Authenticate user via Google
                        // Get user after authenticating
                        // var userInfo = await userProvider.getUserById(
                        //     'WwP59B2DJ1yQdZMLm9n3'); // TODO: Get user ID, currently hardcoded
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         LogedinPage(userInfo: userInfo),
                        //   ),
                        // );
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
