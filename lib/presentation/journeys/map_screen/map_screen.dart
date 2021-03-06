import 'dart:async';
import 'dart:io';
import 'dart:math' show cos, sqrt, asin;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/common_fun.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/data/models/map_api_res_model.dart';
import 'package:qcharge_flutter/di/get_it.dart';
import 'package:qcharge_flutter/presentation/blocs/home/map_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/home/map_station_details_cubit.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/cached_net_img_radius.dart';
import 'package:qcharge_flutter/presentation/widgets/no_data_found.dart';
import 'package:qcharge_flutter/presentation/widgets/show_snack_bar.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_ic_row.dart';

import 'search_screen.dart';


// Page content: Showing charging station with custom marker on google map.
// User current location is showing when user open this screen.
// Marker also showing details of station details on tap of the station marker. Buttomsheet ui show list of charger. On direction button map show navigation route from current loc to station.

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  //This is initial location of Thailand
  CameraPosition _initialLocation = CameraPosition(
    target: LatLng(
      13.736717,
      100.523186,
    ),
    zoom: 7,
    bearing: 30,
  );
  late GoogleMapController mapController;

  late Position _currentPosition;
  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();
  final startAddressFocusNode = FocusNode();
  final destinationAddressFocusNode = FocusNode();

  bool isCurrentLocFetched = false;
  bool isViewAllAcStation = false;
  bool isViewAllDcStation = false;
  bool isPrivateOn = true;
  bool isPublicOn = true;

  Set<Marker> markers = {};
  late Circle circle = Circle(
    circleId: CircleId('q_charge_circle'),
    radius: 12,
  );
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> acMarkerIdList = [];
  List<String> dcMarkerIdList = [];

  @override
  void initState() {
    super.initState();

    //Init marker list with empty list else show error
    setMarkers([]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBarHome(context),
      drawer: NavigationDrawer(onTap: (){},),
      body: BlocBuilder<MapCubit, MapState>(
        builder: (BuildContext context, state) {
          if (state is MapSuccess) {
            //print('----Map : ${state.model.message}');
            return Stack(
              children: <Widget>[
                GoogleMap(
                  padding: EdgeInsets.only(top: 115, bottom: 70),
                  markers: Set<Marker>.from(markers),
                  circles: Set.of([circle]),
                  initialCameraPosition: _initialLocation,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  mapType: MapType.normal,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  compassEnabled: true,
                  polylines: Set<Polyline>.of(polylines.values),
                  //Set marker and get current location after map created
                  onMapCreated: (GoogleMapController controller) {

                    //controller.setMapStyle(Utils.mapStyles); // map theme
                    _controllerGoogleMap.complete(controller);
                    mapController = controller;

                    setMarkers(state.model.response!);
                    // Getting user loc and address after map loaded
                    _getCurrentLocation();
                  },
                ),

                // This block work as filter. Click on first row show private station and show public station click on other row.
                // Station charging type is not coming from CMS, that is why doing filter on station secure type.
                // On every click refreshing markers
                Container(
                  alignment: Alignment.center,
                  height: 115,
                  color: Colors.black,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isViewAllAcStation ? isViewAllAcStation = false : isViewAllAcStation = true;
                                });
                                updateMarkers(state.model.response!);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isViewAllAcStation ? AppColor.border : Colors.transparent,
                                    width: 0.4,
                                  ),
                                  borderRadius: BorderRadius.circular(3.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin: const EdgeInsets.fromLTRB(12, 5, 12, 5),
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
                                            child: Text(
                                              'AC Type 2',
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                                              maxLines: 1,
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 12),
                                            child: Text(
                                              TranslationConstants.viewAcStation.t(context),
                                              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10, color: Colors.white),
                                              maxLines: 2,
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.grey,
                              focusColor: AppColor.text,
                              onTap: () {
                                setState(() {
                                  isViewAllDcStation ? isViewAllDcStation = false : isViewAllDcStation = true;
                                });

                                updateMarkers(state.model.response!);
                              },
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isViewAllDcStation ? AppColor.border : Colors.transparent,
                                    width: 0.3,
                                  ),
                                  borderRadius: BorderRadius.circular(3.0),
                                ),
                                child: Row(
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
                                        child: Image.asset('assets/icons/pngs/dcConnector.png'),
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
                                            child: Text(
                                              'DC Fast Charge',
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                                              maxLines: 1,
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 12),
                                            child: Text(
                                              TranslationConstants.viewDcStation.t(context),
                                              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10, color: Colors.white),
                                              maxLines: 2,
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12, left: 5),
                        child: FloatingActionButton(
                          heroTag: '17',
                          onPressed: () async {
                            //Navigator.of(context).pushNamed(RouteList.add_review);

                            /* List<String> searchResult = [];
                              for(int i=0; i< state.model.response!.length; i++){
                                searchResult.add(state.model.response![i].stationName!);
                              }

                              showSearch(
                                context: context,
                                delegate: CustomSearchDelegate(searchResult),
                              );*/

                            showSearch(
                              context: context,
                              delegate: CustomSearchDelegate(
                                  locationList: state.model.response!,
                                  onTap: (index) {
                                    //print('----Search on Tap: $index');
                                    moveCameraToLoc(state.model.response!, index);
                                  }),
                            );
                          },
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          backgroundColor: AppColor.grey,
                          tooltip: 'Pressed',
                          elevation: 5,
                          splashColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 100, left: 28, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /*FloatingActionButton(
                          heroTag: '9',
                          onPressed: () async {
                            FilterModel? model = await Navigator.push(context, MaterialPageRoute(builder: (context) => Setting(),),);

                            print('----${model!.isPrivateOn}');

                            isPrivateOn = model.isPrivateOn;
                            isPublicOn = model.isPublicOn;
                            isViewAllAcStation = model.isAcOn;
                            isViewAllDcStation = model.isDcOn;

                            updateMarkers(state.model.response!);
                          },
                          child: Image.asset('assets/icons/pngs/create_account_filter.png', width: 20,),
                          backgroundColor: AppColor.grey,
                          tooltip: 'Current Location',
                          elevation: 5,
                          splashColor: Colors.grey,
                        ),*/

                        FloatingActionButton(
                          heroTag: '3',
                          onPressed: () {
                            _getCurrentLocation();
                          },
                          child: !isCurrentLocFetched
                              ? CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.amber.shade600,
                                )
                              : Icon(
                                  Icons.my_location_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                          backgroundColor: AppColor.grey,
                          tooltip: 'Current Location',
                          elevation: 5,
                          splashColor: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return NoDataFound(
              txt: TranslationConstants.loadingCaps.t(context),
              onRefresh: () {},
            );
          }
        },
      ),
    );
  }

  // Method for retrieving the current location by Geolocator. If no loc found then trying to get last user loc. After getting current loc camera move to that loc
  void _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
      //forceAndroidLocationManager: true,
      timeLimit: Duration(seconds: 20),
    ).then((Position position) async {
      setState(() {
        print('CURRENT POS 1: $position');

        isCurrentLocFetched = true;
        _currentPosition = position;
        print('CURRENT POS 2: $_currentPosition');
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
              zoom: 15.0,
            ),
          ),
        );
      });
      // await _getAddress();
    }).catchError((error) {
      isCurrentLocFetched = false;
      if (error is TimeoutException) {
        Geolocator.getLastKnownPosition().then((position) async {
          setState(() {
            isCurrentLocFetched = true;
            _currentPosition = position!;
            //print('Last curr POS: $_currentPosition');
            mapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
                  zoom: 15.0,
                ),
              ),
            );
          });
        }).catchError((error) {
          showSnackBar(context, 'Current location not found!');
        });
      } else {
        //handle the exception
        print('---- Error 2: $error');
        if (error is LocationServiceDisabledException) {
          edgeAlert(
            context,
            title: 'Location!',
            description: 'Please turn on location on the device',
            gravity: Gravity.top,
          );
        } else
          showSnackBar(context, 'Current location not found!');

        setState(() {
          isCurrentLocFetched = true;
        });
      }
    });
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
    //print('---- startLatitude, startLongitude, destinationLatitude, destinationLongitude: $startLatitude ,  $startLongitude , $destinationLatitude , $destinationLongitude , ');

    try {
      polylineCoordinates.clear();
      polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyDPICnoQ4VQA_3YM9hxVDhipQ76uNKF7_A', // Google Maps API Key
        PointLatLng(startLatitude, startLongitude),
        PointLatLng(destinationLatitude, destinationLongitude),
        travelMode: TravelMode.driving,
      );

      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }

      PolylineId id = PolylineId('q_charge_poly');
      Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.blueGrey.shade700,
        points: polylineCoordinates,
        width: 3,
      );
      polylines[id] = polyline;

      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  void updateMarkers(List<Response> list) {
    markers.clear();
    setMarkers(list);
  }

  void setMarkers(List<Response> response) async {
    //print('---- isViewAllAcStation, isViewAllDcStation: $isViewAllAcStation , $isViewAllDcStation');
    for (int i = 0; i < response.length; i++) {
      if (isViewAllAcStation && response[i].chargerType == 'AC') {
        addMarkers(response, i);
      } else if (isViewAllDcStation && response[i].chargerType == 'DC') {
        addMarkers(response, i);
      } else if (!isViewAllAcStation && !isViewAllDcStation) {
        addMarkers(response, i);
      }
    }
  }

  void addMarkers(List<Response> response, int i) {
    try {
      double markerLat = double.parse(response[i].latitude!);
      double markerLong = double.parse(response[i].longitude!);

      Geolocator.isLocationServiceEnabled().then((isLocationEnabled) => {
                if (isLocationEnabled)
                  {
                    Geolocator.getCurrentPosition().then((curLoc) async {
                      double totalDistance = _coordinateDistance(curLoc.latitude, curLoc.longitude, markerLat, markerLong);
                      //print('----totalDistance : ${totalDistance.toStringAsFixed(2)}');

                      final Uint8List markerIcon = await getBytesFromAsset(response[i].secure == 'Private'
                          ? 'assets/icons/pngs/create_account_layer_1.png'
                          : 'assets/icons/pngs/create_account_layer_2.png',
                          65);

                      markers.add(
                        Marker(
                          markerId: MarkerId("${i + 1}"),
                          position: LatLng(double.parse(response[i].latitude!), double.parse(response[i].longitude!)),
                          //position: LatLng(13.736717 + i, 100.523186 + i),
                          infoWindow: InfoWindow(
                              title: '${response[i].stationName},       ${totalDistance.toStringAsFixed(2)} km',
                              snippet: response[i].address,
                              onTap: () {
                                showBottomSheetUi(response[i].stationId.toString(), markerLat, markerLong, "${totalDistance.toStringAsFixed(2)} km");
                              }),
                          icon: BitmapDescriptor.fromBytes(markerIcon),
                        ),
                      );

                      setState(() {});
                    })
                  },
              });
    } catch (e) {
      print(e);
    }
  }

  void moveCameraToLoc(List<Response> list, int index) {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            double.parse(list[index].latitude!),
            double.parse(list[index].longitude!),
          ),
          zoom: 18.0,
        ),
      ),
    );
  }

  showBottomSheetUi(
    String stationId,
    double destinationLat,
    double destinationLong,
    String totalDistance,
  ) async {
    BlocProvider.of<MapStationDetailsCubit>(context).initiateMapStationDetails(stationId);
    MapStationDetailsCubit mapStationDetailsCubit = getItInstance<MapStationDetailsCubit>();

    showModalBottomSheet<void>(
        backgroundColor: Colors.black,
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
        builder: (BuildContext context) {
          return BlocProvider<MapStationDetailsCubit>(
            create: (context) => mapStationDetailsCubit,
            child: BlocBuilder<MapStationDetailsCubit, MapStationDetailsState>(
                bloc: mapStationDetailsCubit,
                builder: (context, state) {
                  if (state is MapStationDetailsSuccess) {
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
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                gradient: LinearGradient(
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft,
                                    colors: [Color(0xFFEFE07D), Color(0xFFB49839)]),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
                              margin: EdgeInsets.only(bottom: Sizes.dimen_8.h),
                              width: double.infinity,
                              height: 45,
                              child: TextButton(
                                onPressed: () async {
                                  await _createPolylines(
                                    _currentPosition.latitude,
                                    _currentPosition.longitude,
                                    destinationLat,
                                    destinationLong,
                                  );

                                  Navigator.pop(context);
                                },
                                child: Text(
                                  TranslationConstants.direction.t(context).toUpperCase(),
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              width: double.maxFinite,
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: AppColor.grey,
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 24),
                                    child: Image.asset(
                                      'assets/icons/pngs/create_account_map_3.png',
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.contain,
                                      color: AppColor.border,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 12),
                                        child: Txt(
                                          txt: state.stationDetailsApiResModel.response!.stationName!,
                                          txtColor: Colors.white,
                                          txtSize: 12,
                                          fontWeight: FontWeight.normal,
                                          padding: 0,
                                          onTap: () {},
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 12),
                                        child: Txt(
                                          txt: state.stationDetailsApiResModel.response!.address!,
                                          txtColor: Colors.white,
                                          txtSize: 12,
                                          fontWeight: FontWeight.normal,
                                          padding: 0,
                                          onTap: () {},
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 12),
                                        child: Txt(
                                          txt: state.stationDetailsApiResModel.response!.secure!,
                                          txtColor: AppColor.border,
                                          txtSize: 14,
                                          fontWeight: FontWeight.normal,
                                          padding: 0,
                                          onTap: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.stationDetailsApiResModel.response!.chargers!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: double.maxFinite,
                                  padding: const EdgeInsets.all(16),
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
                                        padding: const EdgeInsets.only(right: 12, bottom: 6),
                                        child: Txt(
                                          txt: state.stationDetailsApiResModel.response!.chargers![index].detail!.brand! +
                                              " - " + state.stationDetailsApiResModel.response!.chargers![index].detail!.name!,
                                          txtColor: Colors.white,
                                          txtSize: 14,
                                          fontWeight: FontWeight.normal,
                                          padding: 0,
                                          onTap: () {},
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only( bottom: 12),
                                        child: Divider(
                                          color: Colors.grey,
                                          height: 8,
                                        ),
                                      ),

                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: state.stationDetailsApiResModel.response!.chargers![index].detail!.connector!.length,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, position) {
                                          return Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 24),
                                                    child: Image.asset(
                                                      state.stationDetailsApiResModel.response!.chargers![index].detail!.name!.toLowerCase().contains("dc")?
                                                      'assets/icons/pngs/dcConnector.png':
                                                      'assets/icons/pngs/filter_type_1.png',
                                                      width: 25,
                                                      height: 25,
                                                      fit: BoxFit.contain,
                                                      color: AppColor.border,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(right: 12),
                                                          child: Txt(
                                                            txt: 'Connector ${position + 1}',
                                                            txtColor: Colors.white,
                                                            txtSize: 12,
                                                            fontWeight: FontWeight.normal,
                                                            padding: 0,
                                                            onTap: () {},
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(right: 12),
                                                          child: Txt(
                                                            txt: state.stationDetailsApiResModel.response!.chargers![index].detail!.connector![position].type!,
                                                            txtColor: Colors.white,
                                                            txtSize: 12,
                                                            fontWeight: FontWeight.normal,
                                                            padding: 0,
                                                            onTap: () {},
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 12),
                                                    child: Txt(
                                                      txt: state.stationDetailsApiResModel.response!.chargers![index].detail!.connector![position].status! == "1"
                                                          ? "Available"
                                                          : "Occupied",
                                                      txtColor: state.stationDetailsApiResModel.response!.chargers![index].detail!.connector![position].status! == "1"? Colors.amberAccent : Colors.redAccent,
                                                      txtSize: 12,
                                                      fontWeight: FontWeight.normal,
                                                      padding: 0,
                                                      onTap: () {},
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(top: 12, bottom: 12),
                                                child: Divider(
                                                  color: Colors.grey,
                                                  height: 8,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),                            );
                              },
                            ),



                            cachedNetImgWithRadius(
                                state.stationDetailsApiResModel.response!.image!, double.infinity, Sizes.dimen_50.h, 6),
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
                                  ImgTxtRow(
                                    txt: TranslationConstants.loc.t(context),
                                    txtColor: Colors.white,
                                    txtSize: 16,
                                    fontWeight: FontWeight.bold,
                                    icon: 'assets/icons/pngs/filter_0016_Layer-3.png',
                                    icColor: null,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 24),
                                    child: Txt(
                                      txt: state.stationDetailsApiResModel.response!.description!,
                                      txtColor: Colors.white,
                                      txtSize: 13,
                                      fontWeight: FontWeight.normal,
                                      padding: 0,
                                      onTap: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return LinearProgressIndicator(
                      color: AppColor.border,
                        minHeight: 20,
                    );
                  }
                }),
          );
        });
  }
}
