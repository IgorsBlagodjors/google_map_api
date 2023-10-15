import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place extends Equatable {
  final String id;
  final String title;
  final File image;
  final String adress;

  Place({required this.title, required this.image, required this.adress})
      : id = uuid.v4();

  @override
  List<Object?> get props => [id, title, image, adress];
}
