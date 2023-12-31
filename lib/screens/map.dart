import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class LiveLocationPage extends StatefulWidget {
  static const String route = '/live_location';

  const LiveLocationPage({super.key});
  // final void Function(double x, double y) currentCord;

  @override
  // ignore: library_private_types_in_public_api
  _LiveLocationPageState createState() => _LiveLocationPageState();
}

class _LiveLocationPageState extends State<LiveLocationPage> {
  LocationData? _currentLocation;
  late final MapController _mapController;

  bool _liveUpdate = false;
  bool _permission = false;

  String? _serviceError = '';

  int interActiveFlags = InteractiveFlag.all;

  final Location _locationService = Location();

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    initLocationService();
  }

  void loading() {
    const snackBar = SnackBar(
      duration: Duration(seconds: 3),
      content: Text('Loading......'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void initLocationService() async {
    await _locationService.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 1000,
    );

    LocationData? location;
    bool serviceEnabled;
    bool serviceRequestResult;

    try {
      serviceEnabled = await _locationService.serviceEnabled();

      if (serviceEnabled) {
        final permission = await _locationService.requestPermission();
        _permission = permission == PermissionStatus.granted;

        if (_permission) {
          location = await _locationService.getLocation();
          _currentLocation = location;
          _locationService.onLocationChanged.listen(
            (LocationData result) async {
              if (mounted) {
                setState(() {
                  _currentLocation = result;

                  // If Live Update is enabled, move map center
                  if (_liveUpdate) {
                    _mapController.move(
                        LatLng(_currentLocation!.latitude!,
                            _currentLocation!.longitude!),
                        _mapController.camera.zoom);
                  }
                });
              }
            },
          );
        }
      } else {
        serviceRequestResult = await _locationService.requestService();
        if (serviceRequestResult) {
          initLocationService();
          return;
        }
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      if (e.code == 'PERMISSION_DENIED') {
        _serviceError = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        _serviceError = e.message;
      }
      location = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    LatLng currentLatLng;

    if (_currentLocation != null) {
      currentLatLng =
          LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);
    } else {
      currentLatLng = const LatLng(0, 0);
    }

    final markers = <Marker>[
      Marker(
        width: 200,
        height: 200,
        point: currentLatLng,
        child: Icon(
          Icons.location_on,
          color: Theme.of(context).colorScheme.tertiary,
          size: 75,
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Your location')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: _serviceError!.isEmpty
                  ? Text(
                      'Your current location is '
                      '(${currentLatLng.latitude}, ${currentLatLng.longitude}).',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge!.color),
                    )
                  : Text(
                      'Error occured while acquiring location. Error Message : '
                      '$_serviceError',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color),
                    ),
            ),
            Flexible(
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter:
                      LatLng(currentLatLng.latitude, currentLatLng.longitude),
                  initialZoom: 16,
                  interactionOptions:
                      InteractionOptions(flags: interActiveFlags),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  MarkerLayer(markers: markers),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Builder(builder: (BuildContext context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(width: 145),
            FloatingActionButton(
              onPressed: () {
                
                setState(() {
                  _liveUpdate = !_liveUpdate;
                  if (_liveUpdate) {
                    interActiveFlags = InteractiveFlag.rotate |
                        InteractiveFlag.pinchZoom |
                        InteractiveFlag.doubleTapZoom |
                        InteractiveFlag.drag;
                  } else {
                    interActiveFlags = InteractiveFlag.all;
                  }
                });
              },
              child: _liveUpdate
                  ? const Icon(Icons.location_on)
                  : const Icon(Icons.location_off),
            ),
          ],
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
