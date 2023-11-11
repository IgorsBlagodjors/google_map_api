import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map_api/presentation/bloc/places_list_cubit.dart';
import 'package:google_map_api/presentation/bloc/places_list_state.dart';
import 'package:google_map_api/presentation/screens/add_place_screen.dart';
import 'package:google_map_api/widgets/places_list_view.dart';

class PlacesListScreen extends StatefulWidget {
  const PlacesListScreen({super.key});

  @override
  State<PlacesListScreen> createState() => _PlacesListScreenState();
  static Widget withCubit() => BlocProvider(
        create: (context) => PlacesListCubit(
          context.read(),
        ),
        child: const PlacesListScreen(),
      );
}

class _PlacesListScreenState extends State<PlacesListScreen> {
  late final PlacesListCubit _cubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cubit.getPlace();
  }

  @override
  void initState() {
    _cubit = BlocProvider.of<PlacesListCubit>(context);
    _cubit.getPlace();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlacesListCubit, PlacesListState>(
      builder: (context, state) {
        Widget child;
        if (state.isError) {
          child = const Center(
            child: Text('Failure error'),
          );
        } else {
          final data = state.items;
          child = PlacesList(
            places: data,
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Your places'),
            actions: [
              IconButton(
                onPressed: () async {
                  final result = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddPlaceScreen.withCubit(),
                    ),
                  );
                  if (result == true) {
                    _cubit.getPlace();
                  }
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: child,
          ),
        );
      },
    );
  }
}
