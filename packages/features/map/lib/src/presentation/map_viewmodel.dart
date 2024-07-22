import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

import '../domain/entities/location_info.dart';
import '../domain/usecases/get_location_usecase.dart';
import 'dictionary.dart';
import 'states/button_state.dart';

class MapViewModel {
  final GetLocationUseCase _getLocationUseCase;

  MapViewModel(this._getLocationUseCase);

  final _locationData = ValueNotifier<LocationInfo?>(null);
  final _buttonState = ValueNotifier<ButtonState>(ButtonLoadingState());

  ValueListenable<LocationInfo?> get locationData => _locationData;

  ValueListenable<ButtonState> get buttonState => _buttonState;

  void init() {
    _buttonState.setValue(
      ButtonSuccessState(
        text: MapDictionary.buttonSuccessText,
        onPressed: getLocation,
      ),
    );
  }

  Future<void> getLocation() async {
    _buttonState.setValue(ButtonLoadingState());

    final result = await _getLocationUseCase();

    result.fold(
      (failure) => _buttonState.setValue(
        ButtonErrorState(
          text: MapDictionary.buttonErrorText,
          tryAgain: getLocation,
        ),
      ),
      (data) {
        _locationData.setValue(data);
        _buttonState.setValue(
          ButtonSuccessState(
            text: MapDictionary.buttonSuccessText,
            onPressed: getLocation,
          ),
        );
      },
    );
  }
}
