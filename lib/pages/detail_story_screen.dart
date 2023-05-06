import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:storitter/data/result_state.dart';
import 'package:storitter/provider/detail_story_provider.dart';
import 'package:storitter/utils/date_formatter.dart';
import 'package:geocoding/geocoding.dart' as geo;

class DetailStoryScreen extends StatefulWidget {
  final String? id;

  const DetailStoryScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailStoryScreen> createState() => _DetailStoryScreenState();
}

class _DetailStoryScreenState extends State<DetailStoryScreen> {
  late GoogleMapController mapController;
  final Set<Marker> markers = {};

  void defineMarker(LatLng latLng, String street, String address) {
    final marker = Marker(
      markerId: const MarkerId("source"),
      position: latLng,
      onTap: () {
        mapController.animateCamera(
          CameraUpdate.newLatLngZoom(latLng, 18),
        );
      },
      infoWindow: InfoWindow(
        title: street,
        snippet: address,
      ),
    );

    setState(() {
      markers.clear();
      markers.add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailStoryProvider>(
        builder: (context, provider, _) {
          if (provider.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (provider.state == ResultState.hasData) {
            final LatLng latLng =
                LatLng(provider.story.lat, provider.story.lon);

            return NestedScrollView(
              headerSliverBuilder: (context, isScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 300,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                        provider.story.photoUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ];
              },
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          provider.story.name,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.black87, fontSize: 40),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          provider.story.description,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          formatDate(provider.story.createdAt.toString()),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 300,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: latLng,
                            zoom: 18,
                          ),
                          markers: markers,
                          onMapCreated: (controller) async {
                            final info = await geo.placemarkFromCoordinates(
                              latLng.latitude,
                              latLng.longitude,
                            );

                            final place = info.first;
                            final street = place.street!;
                            final address =
                                '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

                            defineMarker(latLng, street, address);

                            setState(() {
                              mapController = controller;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          if (provider.state == ResultState.error ||
              provider.state == ResultState.noData) {
            return Center(
              child: Text(provider.message),
            );
          }

          return const Center(
            child: Text(""),
          );
        },
      ),
    );
  }
}
