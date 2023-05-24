// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pemesanan_hotel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PesananAdapter extends TypeAdapter<Pesanan> {
  @override
  final int typeId = 157;

  @override
  Pesanan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pesanan(
      idPemesanan: fields[0] as int?,
      namaHotel: fields[1] as String?,
      kamarHotel: fields[2] as String?,
      tipeKamar: fields[3] as String?,
      waktuCheckIn: fields[4] as TimeOfDay?,
      waktuCheckOut: fields[5] as TimeOfDay?,
      hariCheckIn: fields[6] as DateTime?,
      hariCheckOut: fields[7] as DateTime?,
      price: fields[8] as num?,
    );
  }

  @override
  void write(BinaryWriter writer, Pesanan obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.idPemesanan)
      ..writeByte(1)
      ..write(obj.namaHotel)
      ..writeByte(2)
      ..write(obj.kamarHotel)
      ..writeByte(3)
      ..write(obj.tipeKamar)
      ..writeByte(4)
      ..write(obj.waktuCheckIn)
      ..writeByte(5)
      ..write(obj.waktuCheckOut)
      ..writeByte(6)
      ..write(obj.hariCheckIn)
      ..writeByte(7)
      ..write(obj.hariCheckOut)
      ..writeByte(8)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PesananAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
