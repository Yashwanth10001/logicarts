import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logicarts/app/models/locations_model.dart';
import 'package:logicarts/app/presentation/widgets/locations_list_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  List<Location> locationsData = [];
  final Set<Marker> _markers = {};

  @override
  initState() {
    super.initState();
    for (var location in locations) {
      locationsData.add(Location.fromJson(location));
    }

    locationsData.forEach((data) {
      _markers.add(Marker(
        markerId: MarkerId(
            LatLng(data.coordinates!.latitude!, data.coordinates!.longitude!)
                .toString()),
        position:
            LatLng(data.coordinates!.latitude!, data.coordinates!.longitude!),
        infoWindow: const InfoWindow(
          title: '',
          snippet: '',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    const LatLng center = LatLng(45.521563, -122.677433);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CameraPosition kLake = const CameraPosition(target: center, zoom: 11.0);
          _goToTheLake(kLake);
        },
        child: const Icon(Icons.restore_rounded),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 50),
          SizedBox(
            height: height * 0.45,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: const CameraPosition(
                target: center,
                zoom: 11.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              compassEnabled: true,
              myLocationEnabled: true,
              markers: _markers,
            ),
          ),
          SizedBox(
            height: height * 0.45,
            child: LocationsListWidget(
                locationsData: locationsData,
                onTap: (index) {
                  CameraPosition kLake0 = CameraPosition(
                      // bearing: 192.8334901395799,
                      target: LatLng(
                          locationsData[index].coordinates!.latitude!,
                          locationsData[index].coordinates!.longitude!),
                      // tilt: 59.440717697143555,
                      zoom: 9.151926040649414);
                  _goToTheLake(kLake0);
                }),
          )
        ],
      ),
    );
  }

  Future<void> _goToTheLake(CameraPosition kLake) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(kLake));
  }
}

final locations = [
  {
    "name": "Hauckfurt23",
    "coordinates": {"latitude": 39.2923, "longitude": -146.9607}
  },
  {
    "name": "Schenectady16",
    "coordinates": {"latitude": 2.3379, "longitude": -157.6905}
  },
  {
    "name": "Wainobury34",
    "coordinates": {"latitude": 11.3691, "longitude": 6.8105}
  },
  {
    "name": "East Aricworth33",
    "coordinates": {"latitude": 65.6303, "longitude": 46.5948}
  },
  {
    "name": "Lake Meda15",
    "coordinates": {"latitude": 21.8865, "longitude": -111.1041}
  },
  {
    "name": "Bruenfort67",
    "coordinates": {"latitude": -73.0218, "longitude": -2.0304}
  },
  {
    "name": "Kaileyburgh36",
    "coordinates": {"latitude": -83.0314, "longitude": 118.9057}
  },
  {
    "name": "North Reedshire48",
    "coordinates": {"latitude": -5.754, "longitude": 162.9062}
  },
  {
    "name": "Kassulkestad68",
    "coordinates": {"latitude": 19.3117, "longitude": 19.442}
  },
  {
    "name": "Sonyafort16",
    "coordinates": {"latitude": -22.2875, "longitude": -109.5374}
  }
];
