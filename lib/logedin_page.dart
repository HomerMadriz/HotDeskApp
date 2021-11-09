// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, await_only_futures

import 'package:flutter/material.dart';
import 'package:hot_desk_app/login_page.dart';
import 'package:hot_desk_app/profile_page.dart';
import 'package:hot_desk_app/providers/booking_provider.dart';
import 'package:hot_desk_app/providers/user_provider.dart';
import 'package:hot_desk_app/reservations_page.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'booking_page.dart';

class LogedinPage extends StatefulWidget {
  final userInfo;
  const LogedinPage({Key? key, @required this.userInfo}) : super(key: key);

  @override
  State<LogedinPage> createState() => _LogedinPageState();
}

class _LogedinPageState extends State<LogedinPage> {
  static const int totalDesks = 20;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Future<String> getLastReservation(userID, bookingProvider) async {
    await bookingProvider.getUserBookings(userID);
    // Sort 'active' reservations
    List bookings = bookingProvider.getBookings;

    bookings = bookings.map((document) => document.data()).toList();
    bookings.removeWhere((booking) => booking.status != 'Active');
    bookings.sort((a, b) {
      return a.date.compareTo(b.date);
    });
    if (bookings.isEmpty) {
      return 'You don\'t have upcoming reservations';
    }
    String lastReservation =
        '${bookings[0].desk} - ${DateFormat("dd/MM/yyyy").format(bookings[0].date)}'; // US format
    return lastReservation;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
        builder: (context, bookingProvider, child) {
      return Scaffold(
          endDrawer: Drawer(
            child: ListView(
              padding: EdgeInsets.only(top: 50.0),
              children: [
                ListTile(
                  onTap: () async {
                    String lastReservation = await getLastReservation(
                        widget.userInfo.id, bookingProvider);
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(
                            userInfo: widget.userInfo,
                            lastReservation: lastReservation),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(
                      widget.userInfo.profilePicture,
                    ),
                  ),
                  title: Text(
                    'View profile',
                    style: TextStyle(fontFamily: 'Barlow-Regular'),
                  ),
                ),
                ListTile(
                  onTap: () {
                    bookingProvider.getUserBookings(widget.userInfo.id);
                    var reservations = bookingProvider.getBookings!
                        .map((document) => document.data())
                        .toList();
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ReservationsPage(
                            reservations: reservations,
                            userInfo: widget.userInfo),
                      ),
                    );
                  },
                  title: Text(
                    'View reservations',
                    style: TextStyle(fontFamily: 'Barlow-Regular'),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  title: Text(
                    'Log out',
                    style: TextStyle(fontFamily: 'Barlow-Regular'),
                  ),
                ),
              ],
            ),
          ),
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
                image: AssetImage('assets/images/appBackground.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TableCalendar(
                  firstDay: DateTime
                      .now(), // User can only schedule in range today - 61 (2 months) later
                  lastDay: DateTime.now().add(Duration(days: 61)),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    // Use `selectedDayPredicate` to determine which day is currently selected.
                    // If this returns true, then `day` will be marked as selected.

                    // Using `isSameDay` is recommended to disregard
                    // the time-part of compared DateTime objects.
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      // Call `setState()` when updating the selected day
                      var utc6SelectedDay = selectedDay.add(
                        Duration(hours: 6),
                      ); // Add 6 hours to match UTC-6
                      //print('UTC-6 Date: $utc6SelectedDay'); // DBUG
                      bookingProvider.getBookingsByStatusAndDate(
                        'Active',
                        utc6SelectedDay,
                      );
                      /*print(
                          'Total matches: ${bookingProvider.getBookings!.length}'); // DBUG*/
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    }
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      // Call `setState()` when updating calendar format
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    // No need to call `setState()` here
                    _focusedDay = focusedDay;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(100, 255, 255, 255),
                      ),
                      child: Text(
                        'Available desks: ${totalDesks - bookingProvider.getBookings!.length}',
                        style: TextStyle(
                          fontFamily: 'Barlow-Light',
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            totalDesks - bookingProvider.getBookings!.length ==
                                    0
                                ? MaterialStateProperty.all(
                                    Color.fromARGB(100, 255, 105, 167))
                                : MaterialStateProperty.all(
                                    Color.fromARGB(255, 255, 105, 167),
                                  ),
                      ),
                      onPressed: totalDesks -
                                      bookingProvider.getBookings!.length ==
                                  0 &&
                              _selectedDay != null
                          ? null
                          : () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => BookingPage(
                                        availableDesks: totalDesks -
                                            bookingProvider.getBookings!.length,
                                        date: _selectedDay!,
                                        bookings: bookingProvider.getBookings,
                                        userInfo: widget.userInfo)),
                              );
                            },
                      child: Padding(
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
          ));
    });
  }
}
