import 'package:flutter/material.dart';
import 'package:logicarts/app/models/locations_model.dart';

// ignore: must_be_immutable
class LocationsListWidget extends StatelessWidget {
  List<Location> locationsData;
  final Function(int index) onTap;
  LocationsListWidget(
      {super.key, required this.onTap, required this.locationsData});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
                child: InkWell(
              onTap: () {
                onTap(index);
              },
              child: Text(
                '${locationsData[index].name}',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            )),
          );
        },
        itemCount: locationsData.length);
  }
}
