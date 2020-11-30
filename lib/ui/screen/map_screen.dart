import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/ui/widget/gradient_btn.dart';

class MapScreen extends StatefulWidget {
  final LatLng userLocation;
  final List<int> buttonColors;

  MapScreen(this.userLocation, this.buttonColors);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng result;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: widget.userLocation,
            zoom: 14.4746,
          ),
          markers: Set<Marker>.of(
            <Marker>[
              Marker(
                  markerId: MarkerId('Marker'),
                  position: widget.userLocation,
                  draggable: true,
                  icon: BitmapDescriptor.defaultMarker,
                  onDragEnd: (value) {
                    result = value;
                  })
            ],
          ),
          myLocationButtonEnabled: false,
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: GradientButton(AppLocalization.of(context).translate("ok"),
                  () {
                Navigator.of(context)
                    .pop(result == null ? widget.userLocation : result);
              }, widget.buttonColors),
            ),
          ),
        )
      ],
    );
  }
}
