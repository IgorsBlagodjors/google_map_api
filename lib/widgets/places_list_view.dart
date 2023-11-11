import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map_api/domain/place_class.dart';
import 'package:google_map_api/presentation/bloc/places_list_cubit.dart';
import 'package:google_map_api/presentation/screens/place_detail_page.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (_, index) => Dismissible(
        key: ValueKey(places[index]),
        onDismissed: (_) {
          final deletedPlace = places[index];
          BlocProvider.of<PlacesListCubit>(context)
              .removePlace(places[index].id);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 5),
              content: Text('${deletedPlace.title} DELETED'),
              action: SnackBarAction(
                label: 'UNDO',
                onPressed: () {
                  BlocProvider.of<PlacesListCubit>(context).undo(deletedPlace);
                },
              ),
            ),
          );
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: FileImage(places[index].image),
          ),
          title: Text(places[index].title),
          subtitle: Text(places[index].location.adress),
          onTap: () {
            Navigator.of(_).push(
              MaterialPageRoute(
                builder: (context) => PlaceDetailPage(place: places[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
