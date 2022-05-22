import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class ShowLocation extends StatefulWidget {
  const ShowLocation({Key? key, required this.lat, required this.long})
      : super(key: key);

  final double lat;
  final double long;

  @override
  _ShowLocationState createState() {
    return _ShowLocationState();
  }
}

class _ShowLocationState extends State<ShowLocation> {
  String location = 'Null, Press Button';
  String Address = 'search';


  @override
  Widget build(BuildContext context) {
    GetAddressFromLatLong(widget.lat, widget.long);
    return Scaffold(
        appBar: AppBar(

          title: Text("Map  " + Address),

        ),
        body: FlutterMap(
          options: MapOptions(
            center: LatLng(widget.lat, widget.long),
            zoom: 15.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
              attributionBuilder: (_) {
                return const Text("© OpenStreetMap contributors");
              },
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 40.0,
                  height: 40.0,
                  point: LatLng(widget.lat, widget.long),
                  builder: (ctx) => const FlutterLogo(),
                )
              ],
            ),
          ],
        ));
  }

  Future<void> GetAddressFromLatLong(double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
  }
}
