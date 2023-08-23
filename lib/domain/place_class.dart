import 'dart:io';

import 'package:uuid/uuid.dart';
import 'package:equatable/equatable.dart';

const uuid = Uuid();

class Place extends Equatable {
  final String id;
  final String title;
  final File image;

  Place({required this.title, required this.image}) : id = uuid.v4();

  @override
  List<Object?> get props => [id, title, image];
}
