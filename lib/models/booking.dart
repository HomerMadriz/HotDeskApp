import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  final String? status;
  final String? desk;
  final DateTime? date;
  final String? id;
  final String? user_id;

  const Booking({
    this.id,
    this.user_id,
    this.desk,
    this.date,
    this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        status: json['status'] as String?,
        desk: json['desk'] as String?,
        date: json['date'].toDate() as DateTime?,
        id: json['id'] as String?,
        user_id: json['user_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': user_id,
        'status': status,
        'desk': desk,
        'date': date,
      };

  @override
  List<Object?> get props {
    return [
      id,
      user_id,
      status,
      desk,
      date,
    ];
  }
}
