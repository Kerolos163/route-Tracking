import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:route_tracking/core/utils/location_service.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late CameraPosition initialCameraPosition;
  late LocationService locationService;
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(target: LatLng(0, 0), zoom: 0);
    locationService = LocationService();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomControlsEnabled: false,
      initialCameraPosition: initialCameraPosition,
      markers: markers,
      onMapCreated: (controller) {
        googleMapController = controller;
        updateCurrentLocation();
      },
    );
  }

  void updateCurrentLocation() async {
    try {
      var locationData = await locationService.getLocation();
      LatLng currentPosition =
          LatLng(locationData.latitude!, locationData.longitude!);
      CameraPosition newCameraPosition =
          CameraPosition(target: currentPosition, zoom: 16);
      googleMapController
          .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
      Marker marker = Marker(
        markerId: const MarkerId("My Location"),
        position: currentPosition,
      );
      markers.add(marker);
      setState(() {});
    } on LocationServiceException catch (exception) {
    } on LocationPermissionException catch (exception) {
    } catch (exception) {}
  }
}
