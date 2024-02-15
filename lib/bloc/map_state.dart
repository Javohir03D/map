part of 'map_bloc.dart';

abstract class YadexMapState {}

class MapInitialState extends YadexMapState {}

class YandexMapLodState extends YadexMapState {
  final Point myLocation;
  YandexMapLodState.YandexMapLodState(this.myLocation);
}
class YandexMapErrorState extends YadexMapState {
  final String errorMessage;
  YandexMapErrorState(this.errorMessage);
}