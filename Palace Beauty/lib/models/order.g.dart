// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderAdapter extends TypeAdapter<Order> {
  @override
  final int typeId = 0;

  @override
  Order read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Order(
      id: fields[0] as String,
      serviceName: fields[1] as String,
      serviceCategory: fields[2] as String,
      price: fields[3] as String,
      duration: fields[4] as String,
      bookingDate: fields[5] as DateTime,
      bookingTime: fields[6] as String,
      customerName: fields[7] as String,
      customerPhone: fields[8] as String,
      status: fields[9] as String,
      paymentMethod: fields[10] as String,
      createdAt: fields[11] as DateTime,
      notes: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Order obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.serviceName)
      ..writeByte(2)
      ..write(obj.serviceCategory)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.duration)
      ..writeByte(5)
      ..write(obj.bookingDate)
      ..writeByte(6)
      ..write(obj.bookingTime)
      ..writeByte(7)
      ..write(obj.customerName)
      ..writeByte(8)
      ..write(obj.customerPhone)
      ..writeByte(9)
      ..write(obj.status)
      ..writeByte(10)
      ..write(obj.paymentMethod)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
