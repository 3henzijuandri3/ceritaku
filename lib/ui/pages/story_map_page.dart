import 'dart:async';
import 'package:ceritaku/controllers/list_cerita_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StoryMapPage extends StatefulWidget {
  const StoryMapPage({super.key});

  @override
  State<StoryMapPage> createState() => _StoryMapPageState();
}

class _StoryMapPageState extends State<StoryMapPage> {
  final ceritaMapStateController = Get.put(ListCeritaController());

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition bandung = CameraPosition(
    target: LatLng(-6.901921404090456, 107.61804778753373),
    zoom: 6,
  );

  @override
  void initState() {
    super.initState();
    ceritaMapStateController.fetchListCeritaLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX(
          init: ceritaMapStateController,
          builder: (controller){
            final isLoading = controller.isLoading.value;
            final listCeritaLocationResponse = controller.listCeritaLocationResponse;

            if(isLoading){
              return const Center(child: CircularProgressIndicator());
            }

            if(listCeritaLocationResponse != null){
              final listCeritaLocation = listCeritaLocationResponse.listCerita;

              return GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: bandung,

                markers: listCeritaLocation!.map((cerita) =>
                    Marker(
                        markerId: MarkerId(cerita.id.toString()),
                        position: LatLng(cerita.lat!.toDouble(), cerita.lon!.toDouble()),
                        infoWindow: InfoWindow(
                          title: cerita.name.toString(),
                          snippet: cerita.description
                        ),
                    )).toSet(),

                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },

              );
            }

            return const Center(child: Text('Something Went Wrong :('));

          }),
    );
  }
}


