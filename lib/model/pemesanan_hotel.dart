import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'pemesanan_hotel.g.dart';

@HiveType(typeId: 0)
class Pesanan extends HiveObject {
  @HiveField(0)
  final int? idPemesanan;

  @HiveField(1)
  final String? namaHotel;

  @HiveField(2)
  final String? kamarHotel;

  @HiveField(3)
  final String? tipeKamar;

  @HiveField(4)
  final TimeOfDay? waktuCheckIn;

  @HiveField(5)
  final TimeOfDay? waktuCheckOut;

  @HiveField(6)
  final DateTime? hariCheckIn;

  @HiveField(7)
  final DateTime? hariCheckOut;

  @HiveField(8)
  final num? price;

  Pesanan({
    this.idPemesanan,
    this.namaHotel,
    this.kamarHotel,
    this.tipeKamar,
    this.waktuCheckIn,
    this.waktuCheckOut,
    this.hariCheckIn,
    this.hariCheckOut,
    this.price,
  });
}
