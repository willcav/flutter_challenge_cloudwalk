import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map/src/presentation/map_viewmodel.dart';

import 'states/button_state.dart';
import 'styles/map_styles.dart';
import 'widgets/button_map_widget.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final MapViewModel viewModel;
  late final GoogleMapController mapController;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    viewModel = SL.I<MapViewModel>();
    viewModel.locationData.addListener(addMapMarker);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void addMapMarker() {
    final location = viewModel.locationData.value;
    if (location != null) {
      setState(() {
        markers.clear();
        markers.add(Marker(
          markerId: const MarkerId('marker1'),
          position: LatLng(
            location.latitude,
            location.longitude,
          ),
          infoWindow: InfoWindow.noText,
        ));
        mapController.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(
              location.latitude,
              location.longitude,
            ),
            12,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GoogleMap(
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
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
            child: viewModel.buttonState.observer(builder: (_, state, __) {
              return switch (state) {
                ButtonSuccessState() => ButtonMapWidget(
                    onPressed: viewModel.getLocation,
                    child: const Text('Go to my location'),
                  ),
                ButtonLoadingState() => const ButtonMapWidget(
                    onPressed: null,
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
                ButtonErrorState() => ButtonMapWidget(
                    onPressed: viewModel.getLocation,
                    child: const Text('Try again'),
                  ),
              };
            }),
          ),
        )
      ],
    );
  }
}
