import 'package:equatable/equatable.dart';

class ResponseClass extends Equatable {
  final String? adress;
  const ResponseClass({required this.adress});

  @override
  List<Object?> get props => [adress];
}
