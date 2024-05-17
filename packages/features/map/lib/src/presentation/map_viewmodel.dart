import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

import '../domain/entities/location_info.dart';
import '../domain/usecases/get_location_usecase.dart';
import 'states/button_state.dart';

class MapViewModel {
  final GetLocationUseCase _getLocationUseCase;

  MapViewModel(this._getLocationUseCase);

  final _locationData = ValueNotifier<LocationInfo?>(null);
  final _buttonState = ValueNotifier<ButtonState>(ButtonSuccessState());

  ValueListenable<LocationInfo?> get locationData => _locationData;

  ValueListenable<ButtonState> get buttonState => _buttonState;

  Future<void> getLocation() async {
    _buttonState.setValue(ButtonLoadingState());

    final result = await _getLocationUseCase();

    result.fold(
      (failure) => _buttonState.setValue(ButtonErrorState()),
      (data) {
        _locationData.setValue(data);
        _buttonState.setValue(ButtonSuccessState());
      },
    );
  }
}
