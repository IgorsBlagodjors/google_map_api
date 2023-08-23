import 'package:flutter/material.dart';
import 'package:google_map_api/domain/place_class.dart';
import 'package:google_map_api/presentation/place_detail_page.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
          backgroundImage: FileImage(places[index].image),
        ),
        title: Text(places[index].title),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PlaceDetailPage(place: places[index]),
            ),
          );
        },
      ),
    );
  }
}
