import 'package:equatable/equatable.dart';

class Reservation extends Equatable {
  final String? status;
  final String? desk;
  final DateTime? reservationDate;

  const Reservation({
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
        'status': status,
        'desk': desk,
        'reservationDate': reservationDate,
      };

  @override
  List<Object?> get props {
    return [
      status,
      desk,
      reservationDate,
    ];
  }
}
