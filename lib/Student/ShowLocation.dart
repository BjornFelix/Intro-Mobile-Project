import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ShowLocation extends StatefulWidget {
  const ShowLocation({Key? key, required this.lat, required this.long})
      : super(key: key);

  final double lat;
  final double long;

  @override
  _ShowLocationState createState() => _ShowLocationState();
}

class _ShowLocationState extends State<ShowLocation> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Map"),
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
                )],
            ),
          ],
        ));
  }
}
