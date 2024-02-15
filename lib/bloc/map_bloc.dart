import 'package:bloc/bloc.dart';
import 'package:location/location.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

part 'map_event.dart';
part 'map_state.dart';

class YandexMapBloc extends Bloc<YandexMapEvent, YadexMapState> {
  final Location location = Location();
  YandexMapBloc() : super(MapInitialState());
  Stream<YadexMapState> _yandexMapCurrentLocationToState() async* {
    try {
      LocationData locationData=await location.getLocation();
      Point myLocation = Point(latitude: locationData.latitude ?? 0, longitude: locationData.longitude ?? 0);
      yield YandexMapLodState.YandexMapLodState(myLocation);
    } catch (e) {
      yield YandexMapErrorState("Error getting location: $e");
    }}
  @override
  Stream<YadexMapState> mapEventToState(YandexMapEvent event)async* {
    if (event is CurrentLocationEvent) {
      yield* _yandexMapCurrentLocationToState();
    }}
}
