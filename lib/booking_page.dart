// ignore_for_file: prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hot_desk_app/models/booking.dart';
import 'package:hot_desk_app/providers/booking_provider.dart';
import 'package:hot_desk_app/reservation_page.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookingPage extends StatefulWidget {
  final DateTime? date;
  final availableDesks;
  final bookings;
  BookingPage(
      {Key? key,
      @required this.date,
      @required this.availableDesks,
      @required this.bookings})
      : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateFormat formatter = DateFormat.yMMMMd(
      'en_US'); // For future refference: https://api.flutter.dev/flutter/intl/DateFormat-class.html
  DateTime selectedDate = DateTime.now();
  int _tableSelected = -1;

  bool deskIsOccupied(deskIndex, bookings) {
    //print('len: ${bookings.length}'); // DBUG
    for (var i = 0; i < bookings.length; i++) {
      if (bookings[i].get('desk') == 'Table ${deskIndex + 1}') {
        return true;
      }
      //print('BookingInfo: ${bookings[i].get("desk")}'); // DBUG
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 255, 105, 167),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
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
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/appBackground.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Consumer<BookingProvider>(
              builder: (context, bookingProvider, child) {
            return Container(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Selected Day: ${formatter.format(widget.date!)}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Barlow-Light',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white30,
                      child: GridView.count(
                        crossAxisCount: 4,
                        childAspectRatio: 1.0,
                        padding: const EdgeInsets.all(1.0),
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        children: List<Widget>.generate(20, (index) {
                          return GridTile(
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    print(_tableSelected); // DBUG
                                    if (!deskIsOccupied(
                                        index, widget.bookings)) {
                                      setState(() {
                                        _tableSelected = index;
                                        print(_tableSelected); // DBUG
                                      });
                                    }
                                  },
                                  icon: Icon(Icons.event_seat),
                                  iconSize: 40,
                                  color: deskIsOccupied(index, widget.bookings)
                                      ? Colors.red
                                      : _tableSelected == index
                                          ? Colors.blue
                                          : Colors.green,
                                ),
                                Text('Table ${index + 1}'),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(100, 255, 255, 255),
                    ),
                    child: Text(
                      'Available desks: ${widget.availableDesks}',
                      style: const TextStyle(
                        fontFamily: 'Barlow-Light',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: _tableSelected == -1
                              ? MaterialStateProperty.all(
                                  Color.fromARGB(100, 255, 105, 167))
                              : MaterialStateProperty.all(
                                  Color.fromARGB(255, 255, 105, 167),
                                ),
                        ),
                        onPressed: _tableSelected == -1
                            ? null
                            : () {
                                // Create new reservation
                                Booking reservation = Booking(
                                  id: "",
                                  user_id: "",
                                  desk: 'Table ${_tableSelected + 1}',
                                  date: widget.date!
                                      .add(Duration(hours: 6)), // UTC-6
                                  status: 'Active',
                                );
                                bookingProvider.addNewBooking(reservation);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ReservationPage(
                                      date: widget.date,
                                      desk: _tableSelected + 1,
                                    ),
                                  ),
                                );
                              },
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Schedule',
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
                ],
              ),
            );
          })),
    );
  }
}
