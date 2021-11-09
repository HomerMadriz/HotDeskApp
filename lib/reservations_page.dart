// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hot_desk_app/models/booking.dart';
import 'package:hot_desk_app/reservation_page.dart';
import 'package:intl/intl.dart';

class ReservationsPage extends StatefulWidget {
  final reservations;
  final userInfo;
  const ReservationsPage(
      {Key? key, @required this.reservations, @required this.userInfo})
      : super(key: key);

  @override
  State<ReservationsPage> createState() => _ReservationsPageState();
}

class _ReservationsPageState extends State<ReservationsPage> {
  final Map<String, Color> _statusColors = {
    'Active': Colors.lightGreen,
    'Completed': Colors.grey,
    'Cancelled': Colors.red.shade700
  };

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
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.reservations.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: _statusColors[widget.reservations[index].status],
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(widget.reservations[index].desk!),
                      ),
                      title: Text(
                        'Reservation date: ${DateFormat('dd/MM/yyyy').format(widget.reservations[index].date!)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(widget.reservations[index].status!),
                      trailing: widget.reservations[index].status! == 'Active'
                          ? IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ReservationPage(
                                        date: widget.reservations[index].date,
                                        desk: widget.reservations[index].desk,
                                        displayReturnArrow: true,
                                        docId: widget.reservations[index].id,
                                        userInfo: widget.userInfo),
                                  ),
                                );
                              },
                              icon: Icon(Icons.manage_search_rounded),
                            )
                          : null,
                    ),
                  );
                },
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
