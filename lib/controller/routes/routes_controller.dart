import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:educube1/network/post_requests.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../utils/prefrence_manager.dart';
import '../../view/widgets/markerWidget.dart';
import '../profile/profile_controller.dart';

class RoutesController extends GetxController {
  var routeLat = 0.0.obs;
  var routeLng = 0.0.obs;
  Rx<LatLng> mBusinessLocation = const LatLng(0.0, 0.0).obs;
  Completer<GoogleMapController> mapControllerCompleter = Completer();
  var userId = Rx<String?>(null);
  var currentYear = Rx<String?>(null);
  var isLoading = false.obs;

  List<LatLng> polylineCoordinates = [];
  GoogleMapController? googleMapController;

  Set<Polyline> polylines = {};

  @override
  void onInit() {
    getRoutes();
    getUserDetails();
    // TODO: implement onInit
    super.onInit();
  }

  final RxList<Marker> markers = RxList([]);




  getUserDetails() {
    userId.value = PreferenceManager.user?.uId;
    currentYear.value = PreferenceManager.user?.currentAcademicYear;
  }

  void onMapCreated(GoogleMapController? controller) {
    googleMapController = controller;
    getRoutes();
  }
  double stringToDouble(String? value){
    try{
      if(value == null ) return 0;
      return double.parse(value);
    }catch(e){
      return 0;
    }
  }

  getRoutes() async {
    Map<String, dynamic> requestBody = {
      "user_id": userId.value,
      "academic_year": currentYear.value,
    };
    final profileCtrl = ProfileController.find;
    final userImage = profileCtrl.userProfile.value?.imagePath.toString() ?? '';
    final schoolImage = profileCtrl.footerContent.value?.clientLogo.toString() ?? '';

    try {
      isLoading.value = true;
      var response = await PostRequests.getRoutes(requestBody);
      if (response != null) {
        List<Marker> list = [];
        list.add( Marker(
          markerId: const MarkerId('0'),
          position: LatLng(
              stringToDouble(response.routeResponse!.objuser!.genLatitude),
              stringToDouble(response.routeResponse!.objuser!.genLongitude)
          ),
          icon: await getCustomMarkerIcon(userImage),
        ));

        list.add( Marker(
          markerId: const MarkerId('1'),
          position: LatLng(
              stringToDouble(response.routeResponse!.objschool!.genLatitude),
              stringToDouble(response.routeResponse!.objschool!.genLongitude)
          ),
          icon: await getCustomMarkerIcon(schoolImage),
        ));

        markers.assignAll(list);
        markers.refresh();
        // getDistanceMatrix(30.707600, 76.715126,30.731344, 76.775383);
        getDistanceMatrix(
          response.routeResponse!.objuser!.genLatitude.toString(),
          response.routeResponse!.objuser!.genLongitude.toString(),
          response.routeResponse!.objschool!.genLatitude.toString(),
          response.routeResponse!.objschool!.genLongitude.toString(),
        );
        routeLat.value = double.parse(
            response.routeResponse!.objuser!.genLatitude.toString());
        routeLng.value = double.parse(
            response.routeResponse!.objuser!.genLongitude.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }

  void getDistanceMatrix(
      String lat, String lng, String lat1, String lng1) async {
    try {
      var url =
          'https://maps.googleapis.com/maps/api/directions/json?destination=$lat,$lng&origin=$lat1,$lng1&key=AIzaSyBTgjMWeFMxL5oe-KFnKts3YGBZJlEC6eM';
      var response = await http.get(Uri.parse(url));
      print(response.body);
      print("${url}??url");

      var data = json.decode(response.body);
      List<LatLng> points = [];

      //  if (data['status'] == 'OK') {
      var routes = data['routes'];
      for (var route in routes) {
        var overviewPolyline = route['overview_polyline'];
        var pointsEncoded = overviewPolyline['points'];
        points = _decodePoly(pointsEncoded);
      }



      polylineCoordinates = points;
      final dest = LatLng(double.parse(lat),double.parse(lng));
      final org = LatLng(double.parse(lat1),double.parse(lng1));
      _addPolyline(org, dest);
      //  }
    } catch (e) {
      print(e);
    }
  }

  void _addPolyline(LatLng org,LatLng dest) {
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 3,
    );
    print(">>>>${polylineCoordinates}");
    polylines.add(polyline);
    update();


    // LatLng midpoint = calculateMidpoint(org, dest);

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(
      LatLngBounds(
        southwest: LatLng(min(org.latitude, dest.latitude), min(org.longitude, dest.longitude)),
        northeast: LatLng(max(org.latitude, dest.latitude), max(org.longitude, dest.longitude)),
      ),
      50, // Padding
    );
    googleMapController?.animateCamera(cameraUpdate);
  }

  LatLng calculateMidpoint(LatLng origin, LatLng destination) {
    double lat1 = origin.latitude * pi / 180;
    double lon1 = origin.longitude * pi / 180;
    double lat2 = destination.latitude * pi / 180;
    double lon2 = destination.longitude * pi / 180;

    double bx = cos(lat2) * cos(lon2 - lon1);
    double by = cos(lat2) * sin(lon2 - lon1);

    double lat3 = atan2(sin(lat1) + sin(lat2), sqrt((cos(lat1) + bx) * (cos(lat1) + bx) + by * by));
    double lon3 = lon1 + atan2(by, cos(lat1) + bx);

    return LatLng(lat3 * 180 / pi, lon3 * 180 / pi);
  }

  List<LatLng> _decodePoly(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;
    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;
      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      LatLng p = LatLng(lat / 1E5, lng / 1E5);
      poly.add(p);
    }
    return poly;
  }
}
