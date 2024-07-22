import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/entities/location_info.dart';
import '../styles/map_styles.dart';

class MapComponentWidget extends StatefulWidget {
  const MapComponentWidget({
    required this.locationData,
    super.key,
  });

  final ValueListenable<LocationInfo?> locationData;

  @override
  State<MapComponentWidget> createState() => _MapComponentWidgetState();
}

class _MapComponentWidgetState extends State<MapComponentWidget> {
  late final GoogleMapController mapController;
  final markers = <Marker>{};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void addMapMarker(LocationInfo? location) {
    if (location != null) {
      markers.clear();
      markers.add(
        Marker(
          markerId: const MarkerId('marker1'),
          position: LatLng(
            location.latitude,
            location.longitude,
          ),
          infoWindow: InfoWindow.noText,
        ),
      );
      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(
            location.latitude,
            location.longitude,
          ),
          12,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => widget.locationData.observer(
        builder: (_, location, ___) {
          addMapMarker(location);
          return GoogleMap(
            style: MapStyle.silver,
            compassEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            myLocationButtonEnabled: false,
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(-25.5026, -49.2908), // San Francisco coordinates
              zoom: 12,
            ),
            markers: markers,
          );
        },
      );
}
