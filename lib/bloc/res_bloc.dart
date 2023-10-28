import 'dart:async';
import 'package:flutter_ais_bottombar/connect.dart';

import 'res_event.dart';
import 'res_state.dart';

class ResBloc {
  final _stateController = StreamController<ResState>();
  Stream<ResState> get state => _stateController.stream;

  final _eventController = StreamController<ResEvent>();
  Sink<ResEvent> get eventSink => _eventController.sink;

  ResBloc() {
    _eventController.stream.listen((event) async {
      if (event is FetchPhotosEvent) {
        _stateController.add(ResLoadingState());

        try {
          final photos = await fetchPhotos();
          _stateController.add(ResLoadedState(photos));
        } catch (error) {
          _stateController.add(ResErrorState(error.toString()));
        }
      }
    });
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
