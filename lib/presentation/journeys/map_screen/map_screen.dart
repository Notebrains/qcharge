import 'dart:async';
import 'dart:math' show cos, sqrt, asin;

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/EtBorderProgressBar.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/cached_net_img_radius.dart';
import 'package:qcharge_flutter/presentation/widgets/show_snack_bar.dart';
import 'package:qcharge_flutter/presentation/widgets/text_field_map_address.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_ic_row.dart';

class MapScreen extends StatefulWidget {
  
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  CameraPosition _initialLocation = CameraPosition(
      target: LatLng(
        13.736717,
        100.523186,
      ),
      zoom: 8);
  late GoogleMapController mapController;

  late Position _currentPosition;
  String _currentAddress = '';
  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();
  final startAddressFocusNode = FocusNode();
  final destinationAddressFocusNode = FocusNode();

  //String _startAddress = 'Barjora, Bankura, West bengal, India';
  //String _destinationAddress = 'Bigbazar, City center, Durgapur, West Bengal, India';
  String _startAddress = '';
  String _destinationAddress = '';
  String _placeDistance = '0.00';
  bool isCurrentLocFetched = false;

  Set<Marker> markers = {};
  late Circle circle = Circle(circleId: CircleId('qCharge'));
  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // Method for retrieving the current location
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium,
      forceAndroidLocationManager: true,
      timeLimit: Duration(seconds: 20),
    ).then((Position position) async {
      setState(() {
        isCurrentLocFetched = true;
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
              zoom: 15.0,
            ),
          ),
        );
      });
      await _getAddress();
    }).catchError((error) {
      print('---- Error 0: $error');
      isCurrentLocFetched = false;
      if (error is TimeoutException) {
        Geolocator.getLastKnownPosition(forceAndroidLocationManager: true,).then((position) async {
          //getting last known position
          print('---- Loc 2: $position');

          setState(() {
            isCurrentLocFetched = true;
            _currentPosition = position!;
            print('Last curr POS: $_currentPosition');
            mapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
                  zoom: 15.0,
                ),
              ),
            );
          });
          await _getAddress();
        }).catchError((error) {
          //handle the exception
          print('----Error 1: $error');
          showSnackBar(context, 'Current location not found!');
          setState(() {
            isCurrentLocFetched =true;
          });
        });
      } else {
        //handle the exception
        print('---- Error 2: $error');
        if (error is LocationServiceDisabledException) {
          showSnackBar(context, 'Please enable location on the device');
        } else showSnackBar(context, 'Current location not found!');

        setState(() {
          isCurrentLocFetched =true;
        });
      }
    });
  }

  // Method for retrieving the address
  _getAddress() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(_currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];

      setState(() {
        _currentAddress = "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
        startAddressController.text = _currentAddress;
        _startAddress = _currentAddress;

        print('----_currentAddress : $_currentAddress');
      });
    } catch (e) {
      print(e);
    }
  }

  // Method for calculating the distance between two places
  Future<bool> _calculateDistance() async {
    try {
      // Retrieving placemarks from addresses
      List<Location> startPlacemark = await locationFromAddress(_startAddress);
      List<Location> destinationPlacemark = await locationFromAddress(_destinationAddress);

      // Use the retrieved coordinates of the current position,
      // instead of the address if the start position is user's
      // current position, as it results in better accuracy.
      double startLatitude = _startAddress == _currentAddress ? _currentPosition.latitude : startPlacemark[0].latitude;

      double startLongitude = _startAddress == _currentAddress ? _currentPosition.longitude : startPlacemark[0].longitude;

      double destinationLatitude = destinationPlacemark[0].latitude;
      double destinationLongitude = destinationPlacemark[0].longitude;

      String startCoordinatesString = '($startLatitude, $startLongitude)';
      String destinationCoordinatesString = '($destinationLatitude, $destinationLongitude)';

      // Start Location Marker
      Marker startMarker = Marker(
        markerId: MarkerId(startCoordinatesString),
        position: LatLng(startLatitude, startLongitude),
        infoWindow: InfoWindow(
          title: 'Current Location $startCoordinatesString',
          snippet: _startAddress,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Destination Location Marker
      Marker destinationMarker = Marker(
        markerId: MarkerId(destinationCoordinatesString),
        position: LatLng(destinationLatitude, destinationLongitude),
        infoWindow: InfoWindow(
          title: 'Destination $destinationCoordinatesString',
          snippet: _destinationAddress,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Adding the markers to the list
      markers.add(startMarker);
      markers.add(destinationMarker);

      circle = Circle(
        circleId: CircleId("car"),
        radius: 25,
        zIndex: 1,
        strokeColor: Colors.greenAccent.shade400,
        center: LatLng(destinationLatitude, destinationLongitude),
        fillColor: Colors.blue.withAlpha(70),
      );

      print(
        'START COORDINATES: ($startLatitude, $startLongitude)',
      );
      print(
        'DESTINATION COORDINATES: ($destinationLatitude, $destinationLongitude)',
      );

      // Calculating to check that the position relative
      // to the frame, and pan & zoom the camera accordingly.
      double miny = (startLatitude <= destinationLatitude) ? startLatitude : destinationLatitude;
      double minx = (startLongitude <= destinationLongitude) ? startLongitude : destinationLongitude;
      double maxy = (startLatitude <= destinationLatitude) ? destinationLatitude : startLatitude;
      double maxx = (startLongitude <= destinationLongitude) ? destinationLongitude : startLongitude;

      double southWestLatitude = miny;
      double southWestLongitude = minx;

      double northEastLatitude = maxy;
      double northEastLongitude = maxx;

      // Accommodate the two locations within the
      // camera view of the map
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          100.0,
        ),
      );

      // Calculating the distance between the start and the end positions
      // with a straight path, without considering any route
      // double distanceInMeters = await Geolocator.bearingBetween(
      //   startLatitude,
      //   startLongitude,
      //   destinationLatitude,
      //   destinationLongitude,
      // );

      await _createPolylines(startLatitude, startLongitude, destinationLatitude, destinationLongitude);

      double totalDistance = 0.0;

      // Calculating the total distance by adding the distance
      // between small segments
      for (int i = 0; i < polylineCoordinates.length - 1; i++) {
        totalDistance += _coordinateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude,
        );
      }

      setState(() {
        _placeDistance = totalDistance.toStringAsFixed(2);
        print('DISTANCE: $_placeDistance km');
      });

      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  // Formula for calculating distance between two coordinates
  // https://stackoverflow.com/a/54138876/11910277
  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  // Create the polylines for showing the route between two places
  _createPolylines(
      double startLatitude,
      double startLongitude,
      double destinationLatitude,
      double destinationLongitude,
      ) async {
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyAJyzOhJBr-3I0aErGmue98rhhuYZTLR6s', // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId('tlt_driver_poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 5,
    );
    polylines[id] = polyline;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    _startAddress = 'Barjora, Bankura, West bengal, India';
    startAddressController.text = 'Barjora, Bankura, West bengal, India';
    destinationAddressController.text = 'Bigbazar, City center, Durgapur, West Bengal, India';
    _destinationAddress = 'Bigbazar, City center, Durgapur, West Bengal, India';


    return Scaffold(
      key: _scaffoldKey,
      appBar: appBarHome(context),
      drawer: NavigationDrawer(),
      body: Stack(
        children: <Widget>[
          // Map View
          GoogleMap(
            markers: Set<Marker>.from(markers),
            circles: Set.of((circle != null) ? [circle] : []),
            initialCameraPosition: _initialLocation,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            polylines: Set<Polyline>.of(polylines.values),
            onMapCreated: (GoogleMapController controller) {
              //controller.setMapStyle(Utils.mapStyles); // map theme
              _controllerGoogleMap.complete(controller);
              mapController = controller;

              // Getting user loc and address after map loaded
              _getCurrentLocation();
            },
          ),

          Container(
            alignment: Alignment.center,
            height: 115,
            color: Colors.black,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.all(12),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: AppColor.grey,
                                borderRadius: BorderRadius.circular(3.0),
                              ),

                              child: Image.asset('assets/icons/pngs/map__type_1.png'),
                            ),

                          ),

                          Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: Txt(
                                    txt: TranslationConstants.type1Ac.t(context),
                                    txtColor: Colors.white,
                                    txtSize: 12,
                                    fontWeight: FontWeight.bold,
                                    padding: 0,
                                    onTap: () {},
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: Txt(
                                    txt: Strings.txt_lorem_ipsum_small,
                                    txtColor: Colors.white,
                                    txtSize: 11,
                                    fontWeight: FontWeight.normal,
                                    padding: 0,
                                    onTap: () {

                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.only(left: 12, right: 12),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: AppColor.grey,
                                borderRadius: BorderRadius.circular(3.0),
                              ),

                              child: Image.asset('assets/icons/pngs/map__type_1.png'),
                            ),

                          ),

                          Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: Txt(
                                    txt: TranslationConstants.type2Dc.t(context),
                                    txtColor: Colors.white,
                                    txtSize: 12,
                                    fontWeight: FontWeight.bold,
                                    padding: 0,
                                    onTap: () {},
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: Txt(
                                    txt: Strings.txt_lorem_ipsum_small,
                                    txtColor: Colors.white,
                                    txtSize: 11,
                                    fontWeight: FontWeight.normal,
                                    padding: 0,
                                    onTap: () {

                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only( right: 12),
                  child: FloatingActionButton(
                    heroTag: '1',
                    onPressed: () {
                      //Navigator.of(context).pushNamed(RouteList.add_review);
                    },
                    child: Icon(Icons.search, color:  Colors.white,),
                    backgroundColor: AppColor.grey,
                    tooltip: 'Pressed',
                    elevation: 5,
                    splashColor: Colors.grey,
                  ),
                ),
              ],
            ),
          ),



          // Show the place input fields & button for
          // showing the route

          /*SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  width: width * 0.80,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 8),
                        isCurrentLocFetched
                            ? TextFieldMapAddress(
                            label: 'Start',
                            hint: 'Your current location',
                            prefixIcon: Icon(Icons.looks_one_outlined),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.my_location),
                              onPressed: () {
                                try {
                                  print('----Curr add : $_currentAddress , start add: $_startAddress');
                                  if (_currentAddress.isNotEmpty && _currentAddress != null) {
                                    startAddressController.text = _currentAddress;
                                    _startAddress = _currentAddress;
                                  } else {
                                    setState(() {
                                      isCurrentLocFetched = false;
                                      _getCurrentLocation();
                                    });
                                  }
                                } catch (e) {
                                  print(e);
                                  setState(() {
                                    isCurrentLocFetched = false;
                                    _getCurrentLocation();
                                  });
                                }
                              },
                            ),
                            controller: startAddressController,
                            focusNode: startAddressFocusNode,
                            width: width - 24,
                            locationCallback: (String value) {
                              setState(() {
                                _startAddress = value;
                              });
                            })
                            : EtBorderProgressBar(
                          text: "Getting current location",
                          width: width,
                          onTap: () {
                            setState(() {
                              startAddressController.text = '';
                              isCurrentLocFetched = true;
                            });
                          },
                        ),
                        SizedBox(height: 8),
                        TextFieldMapAddress(
                            label: 'Destination',
                            hint: 'Choose destination',
                            prefixIcon: Icon(Icons.looks_two_outlined),
                            controller: destinationAddressController,
                            focusNode: destinationAddressFocusNode,
                            width: width - 24,
                            locationCallback: (String value) {
                              setState(() {
                                _destinationAddress = value;
                              });
                            }),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.greenAccent,
                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          ),
                          child: Container(
                            width: 215,
                            //padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.pin_drop_outlined,
                                  size: 18,
                                  color: Colors.black87,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text(
                                    _placeDistance != null && _placeDistance != '0.00' ? 'Distance: $_placeDistance' : 'Show Route',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      letterSpacing: 1,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onPressed: (_startAddress != '' && _startAddress != null && _destinationAddress != '')
                              ? () async {
                            print('----1 $_startAddress ----$_destinationAddress');
                            startAddressFocusNode.unfocus();
                            destinationAddressFocusNode.unfocus();
                            setState(() {
                              if (markers.isNotEmpty) markers.clear();
                              if (polylines.isNotEmpty) polylines.clear();
                              if (polylineCoordinates.isNotEmpty) polylineCoordinates.clear();
                              _placeDistance = '5km';
                            });

                            _calculateDistance().then((isCalculated) {
                              if (isCalculated) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Distance Calculated'),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Error Calculating Distance'),
                                  ),
                                );
                              }
                            });
                          }
                              : () {
                            print('----2 $_startAddress ----$_destinationAddress');

                            setState(() {
                              isCurrentLocFetched = false;
                              _getCurrentLocation();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),*/
          // Show current location button
          /*SafeArea(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 120.0),
                child: ClipOval(
                  child: Material(
                    color: Colors.orange[100], // button color
                    child: InkWell(
                      splashColor: Colors.orange, // inkwell color
                      child: SizedBox(
                        width: 45,
                        height: 45,
                        child: Icon(Icons.my_location),
                      ),
                      onTap: () {
                        _getCurrentLocation();
                        mapController.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: LatLng(
                                _currentPosition.latitude,
                                _currentPosition.longitude,
                              ),
                              zoom: 18.0,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),*/


        ],
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 28),
              child: FloatingActionButton(
                heroTag: '2',
                onPressed: () {
                  showBottomSheetUi();
                },
                child: Image.asset('assets/icons/pngs/create_account_filter.png', width: 22,),
                backgroundColor: AppColor.grey,
                tooltip: 'Pressed',
                elevation: 5,
                splashColor: Colors.grey,
              ),
            ),

            FloatingActionButton(
              heroTag: '3',
              onPressed: () {
                //Navigator.of(context).pushNamed(RouteList.add_review);
              },
              child: Icon(Icons.my_location_rounded, color: Colors.white, size: 24,),
              backgroundColor: AppColor.grey,
              tooltip: 'Pressed',
              elevation: 5,
              splashColor: Colors.grey,
            ),
          ],
        ),
      )
    );
  }

  showBottomSheetUi() {
    showModalBottomSheet<void>(
        backgroundColor: Colors.black,
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter state) {
            return Container(
              //height: 800,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),

              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(24),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: AppColor.grey,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Txt(
                              txt: TranslationConstants.availOrUnavail.t(context),
                              txtColor: Colors.white,
                              txtSize: 14,
                              fontWeight: FontWeight.bold,
                              padding: 0,
                              onTap: () {},
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Txt(
                              txt: TranslationConstants.pvtPub.t(context),
                              txtColor: Colors.white,
                              txtSize: 14,
                              fontWeight: FontWeight.normal,
                              padding: 0,
                              onTap: () {

                              },
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Txt(
                              txt: 'AC Type 2, 22 km',
                              txtColor: Colors.white,
                              txtSize: 14,
                              fontWeight: FontWeight.bold,
                              padding: 0,
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ),

                    cachedNetImgWithRadius(Strings.imgUrlMeeting, double.infinity, Sizes.dimen_50.h, 6),

                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(14),
                      margin: const EdgeInsets.only(bottom: 12, top: 12),
                      decoration: BoxDecoration(
                        color: AppColor.grey,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ImgTxtRow(txt: TranslationConstants.loc.t(context), txtColor: Colors.white, txtSize: 16, fontWeight: FontWeight.bold,
                              icon: 'assets/icons/pngs/filter_0016_Layer-3.png', icColor: Colors.white,
                          ),

                          Padding(
                            padding: const EdgeInsets.only( bottom: 24),
                            child: Txt(txt: Strings.txt_lorem_ipsum_big, txtColor: Colors.white, txtSize: 13, fontWeight: FontWeight.normal,
                                padding: 0, onTap: (){}),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}
