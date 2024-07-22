import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'map_viewmodel.dart';

import 'widgets/button_map_widget.dart';
import 'widgets/map_component_widget.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final MapViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = SL.I<MapViewModel>();
    viewModel.init();
  }

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          MapComponentWidget(locationData: viewModel.locationData),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 24,
              ),
              child: ButtonMapWidget(buttonState: viewModel.buttonState),
            ),
          ),
        ],
      );
}
