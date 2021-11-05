import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hot_desk_app/models/booking.dart';

class BookingProvider with ChangeNotifier {
  // Referencia a la colección en Firebase
  final _bookingRef =
      FirebaseFirestore.instance.collection('Bookings').withConverter(
            fromFirestore: (snapshot, _) => Booking.fromJson(snapshot.data()!),
            toFirestore: (booking, _) => booking.toJson(),
          );

  Booking? _booking;
  Booking? get getBooking => _booking;

  // QueryDocumentSnapshot contiene objetos los tipo Booking que regresa el query
  List<QueryDocumentSnapshot<Booking>>? _bookings = [];
  List<QueryDocumentSnapshot<Booking>>? get getBookings => _bookings;

  void getAllBookings() async {
    _bookings = await _requestBookings();
    notifyListeners();
  }

  void getBookingsById(String id) async {
    _booking = await _requestBooking(id);
    notifyListeners();
  }

  void getBookingsByStatusAndDate(String status, DateTime date) async {
    _bookings = await _requestBookingsByDate(date, status);
    notifyListeners();
  }

  void getUserBookings(String userId) async {
    _bookings = await _requestBookingsByUserId(userId);
    notifyListeners();
  }

  void getUserBookingsByDate(String userId, DateTime date) async {
    _bookings = await _requestBookingsByUserIdAndDate(userId, date);
    notifyListeners();
  }

  Future<void> addNewBooking(Booking newBooking) async {
    await _bookingRef.add(newBooking);
  }

  /// @param updateFields: Es un mapa donde se indica el nombre del campo a
  /// modificar y el valor. Ex: { 'status' : 'Active' }
  Future<void> updateBooking(
      String bookingId, Map<String, String> updateFields) async {
    _bookingRef
        .doc(bookingId)
        .update(updateFields)
        .then((value) => print('Booking updated'))
        .catchError((error) => print("Failed to update booking: $error"));
  }

  Future<List<QueryDocumentSnapshot<Booking>>?> _requestBookings() async {
    try {
      return await _bookingRef.get().then((value) => value.docs);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Booking?> _requestBooking(String id) async {
    try {
      return await _bookingRef.doc(id).get().then((value) => value.data()!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<QueryDocumentSnapshot<Booking>>?> _requestBookingsByUserId(
    String userId,
  ) async {
    try {
      return await _bookingRef
          .where('user_id', isEqualTo: userId)
          .get()
          .then((value) => value.docs);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<QueryDocumentSnapshot<Booking>>?> _requestBookingsByDate(
    DateTime date,
    String status,
  ) async {
    var firestoreTimestamp = Timestamp.fromDate(date);
    //print('Timestamp: $firestoreTimestamp'); // DBUG
    try {
      return await _bookingRef
          .where('date', isEqualTo: firestoreTimestamp)
          .where('status', isEqualTo: status)
          .get()
          .then((value) => value.docs);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<QueryDocumentSnapshot<Booking>>?> _requestBookingsByUserIdAndDate(
    String userId,
    DateTime date,
  ) async {
    var firestoreTimestamp = date.toString().split(" ")[0].toString();

    try {
      return await _bookingRef
          .where('user_id', isEqualTo: userId)
          .where('date', isGreaterThanOrEqualTo: firestoreTimestamp)
          .get()
          .then((value) => value.docs);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
