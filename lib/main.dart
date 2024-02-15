import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'bloc/map_bloc.dart';

void main(){
  runApp(YayndexMap());
}

class YayndexMap extends StatefulWidget {
  const YayndexMap({Key? key});

  @override
  State<YayndexMap> createState() => _YayndexMapState();
}

class _YayndexMapState extends State<YayndexMap> {
  YandexMapController? yandexMapController;
  late YandexMapBloc _mapBloc;
  @override
  void initState() {
    _mapBloc.add(CurrentLocationEvent());
    _mapBloc = YandexMapBloc( );
    super.initState();
  }
  @override
  void dispose() {
    _mapBloc.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<YandexMapBloc, YadexMapState>(
      builder: (context, state) {
        if (state is MapInitialState) {
          return const CircularProgressIndicator();
        } else if (state is YandexMapLodState) {
          return buildMap(state.myLocation);
        } else if (state is YandexMapErrorState) {
          return Text("Error: ${state.errorMessage}");
        } else {
          return Container();
        }
      },
    );
  }
  Widget buildMap(Point myLocation) {
    return Scaffold(
      body: YandexMap(
        mapObjects: [
          CircleMapObject(mapId: const MapObjectId('my_location'),
            circle: Circle(
                center: myLocation ?? const Point(latitude: 0, longitude: 0),
                radius: 5),
          ),
          const PolygonMapObject(
            strokeColor: Colors.red,
            strokeWidth: 20,
            mapId:MapObjectId('polygon'),
            polygon: Polygon(
              outerRing: LinearRing(points: [
                Point(latitude: 56.34295, longitude: 74.62829),
                Point(latitude: 70.12669, longitude: 98.97399),
                Point(latitude: 56.04956, longitude: 125.07751),
              ]),
              innerRings: [
                LinearRing(points: [
                  Point(latitude: 57.34295, longitude: 78.62829),
                  Point(latitude: 69.12669, longitude: 98.97399),
                  Point(latitude: 57.04956, longitude: 121.07751),
                ])
              ],
            ),),],
        onMapCreated: (controller) {
          yandexMapController = controller;
          setState(() {});
        },
      ),
    );}
}
