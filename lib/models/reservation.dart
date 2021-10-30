import 'package:equatable/equatable.dart';

class Reservation extends Equatable {
  final String? status;
  final String? desk;
  final DateTime? reservationDate;
  final String? booking_id;
  final String? user_id;

  const Reservation({
    this.booking_id,
    this.user_id,
    this.desk,
    this.reservationDate,
    this.status,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        status: json['status'] as String?,
        desk: json['desk'] as String?,
        reservationDate: json['reservationDate'] as DateTime?,
      );

  Map<String, dynamic> toJson() => {
        'booking_id': booking_id,
        'user_id': user_id,
        'status': status,
        'desk': desk,
        'reservationDate': reservationDate,
      };

  @override
  List<Object?> get props {
    return [
      booking_id,
      user_id,
      status,
      desk,
      reservationDate,
    ];
  }
}
