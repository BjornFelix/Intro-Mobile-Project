import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class ShowLocation extends StatefulWidget {
  const ShowLocation({Key? key, required this.lat, required this.long})
      : super(key: key);

  final double lat;
  final double long;
  @override
  _ShowLocationState createState() => _ShowLocationState();
}

class _ShowLocationState extends State<ShowLocation> {
  GoogleMapController? _controller;

  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    getAddressFromLatLong( widget.lat, widget.long).then((value) => Text(value));
    _markers.add(Marker(
        markerId: const MarkerId('Location'),
        position: LatLng(widget.lat, widget.long)));
    return Scaffold(
        appBar: AppBar(
          title: const Text("Map"),
        ),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 2,
              child: GoogleMap(
                zoomControlsEnabled: false,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(48.8561, 2.2930),
                  zoom: 12.0,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                },
                markers: _markers,
              ),
            ),

          ],
        ));
  }
}

Future<String> getAddressFromLatLong(double lat,double long )async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat,long);
    Placemark place = placemarks[0];
   return '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

  }