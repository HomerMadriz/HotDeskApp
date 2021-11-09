// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hot_desk_app/logedin_page.dart';
import 'package:hot_desk_app/providers/booking_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReservationPage extends StatelessWidget {
  final date;
  final desk;
  final docId;
  final displayReturnArrow;
  final userInfo;
  // TODO: Pending until authentication is implemented
  const ReservationPage(
      {Key? key,
      @required this.date,
      @required this.desk,
      @required this.docId,
      @required this.displayReturnArrow,
      @required this.userInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat("dd/MM/yyyy");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            displayReturnArrow ? true : false, // Dismiss return arrow
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
          child: Consumer<BookingProvider>(
            builder: (context, bookingProvider, child) {
              return Column(
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
                        'Date: ${formatter.format(date)}',
                        style: TextStyle(
                            fontFamily: 'Barlow-Regular', fontSize: 20.0),
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
                        'Desk: $desk',
                        style: TextStyle(
                            fontFamily: 'Barlow-Regular', fontSize: 20.0),
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
                        'Name: ${userInfo.firstName} ${userInfo.lastName}',
                        style: TextStyle(
                            fontFamily: 'Barlow-Regular', fontSize: 20.0),
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
                          minimumSize:
                              MaterialStateProperty.all(Size(250.0, 50.0)),
                          backgroundColor: MaterialStateProperty.all(
                            Colors.green,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LogedinPage(
                                userInfo: userInfo,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            displayReturnArrow
                                ? 'Edit reservation'
                                : 'New reservation',
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
                      minimumSize: MaterialStateProperty.all(Size(250.0, 50.0)),
                      backgroundColor: MaterialStateProperty.all(
                        Colors.red,
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text(
                                  'Are you sure you want to cancel the reservation?',
                                  style:
                                      TextStyle(fontFamily: 'Barlow-Regular'),
                                ),
                                content: Text(
                                  'The reservation will be marked as cancelled',
                                  style:
                                      TextStyle(fontFamily: 'Barlow-Regular'),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, 'Cancel');
                                    },
                                    child: Text(
                                      'No',
                                      style: TextStyle(
                                          fontFamily: 'Barlow-Regular'),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Mark the reservation as cancelled at firestore database
                                      bookingProvider.updateBooking(
                                          docId, {'status': 'Cancelled'});
                                      // Show notification
                                      final snackBar = SnackBar(
                                        content: const Text(
                                            'Reservation has been cancelled'),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      Navigator.pop(context, 'OK');
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => LogedinPage(
                                                    userInfo: userInfo,
                                                  )));
                                    },
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(
                                          fontFamily: 'Barlow-Regular'),
                                    ),
                                  ),
                                ],
                              ));
                    },
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
              );
            },
          )),
    );
    ;
  }
}
