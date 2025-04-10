// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_group_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubscriptionGroupModelAdapter
    extends TypeAdapter<SubscriptionGroupModel> {
  @override
  final int typeId = 0;

  @override
  SubscriptionGroupModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubscriptionGroupModel(
      fields[0] as String,
      (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, SubscriptionGroupModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.subscriptions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubscriptionGroupModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
