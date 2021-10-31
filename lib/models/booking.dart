import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  final String? status;
  final String? desk;
  final DateTime? reservationDate;
  final String? bookingId;
  final String? userId;

  const Booking({
    this.bookingId,
    this.userId,
    this.desk,
    this.reservationDate,
    this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        status: json['status'] as String?,
        desk: json['desk'] as String?,
        reservationDate: json['reservationDate'] as DateTime?,
        bookingId: json['bookingId'] as String?,
        userId: json['userId'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'booking_id': bookingId,
        'user_id': userId,
        'status': status,
        'desk': desk,
        'reservationDate': reservationDate,
      };

  @override
  List<Object?> get props {
    return [
      bookingId,
      userId,
      status,
      desk,
      reservationDate,
    ];
  }
}
