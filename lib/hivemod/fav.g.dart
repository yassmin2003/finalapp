// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fav.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteQuoteAdapter extends TypeAdapter<FavoriteQuote> {
  @override
  final int typeId = 1;

  @override
  FavoriteQuote read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteQuote(
      content: fields[0] as String,
      author: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteQuote obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.content)
      ..writeByte(1)
      ..write(obj.author);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteQuoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
