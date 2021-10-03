import 'package:flutter/material.dart';
import 'package:hot_desk_app/reservation_page.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime selectedDate = DateTime.now();
  int availableDesks = 20;
  int _tableSelected = -1;

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
        child: Container(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                      enabled: true, labelText: "Booking date"),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(DateFormat('dd/MM/yyyy').format(selectedDate)),
                      const Icon(Icons.calendar_today_sharp)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
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
                                setState(() {
                                  _tableSelected = index;
                                });
                              },
                              icon: Icon(Icons.event_seat),
                              iconSize: 40,
                              color: _tableSelected == index
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
                height: 50,
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(100, 255, 255, 255),
                ),
                child: Text(
                  'Available desks: $availableDesks',
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
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 255, 105, 167),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ReservationPage(),
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
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
