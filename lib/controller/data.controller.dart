import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:raftlabassignment/model/DataCollection.dart';

class FetchData extends GetxController {
  DateTime now = DateTime.now();
  var hr = "".obs;
  var minut = "".obs;
  // ignore: non_constant_identifier_names
  var AmPm = "".obs;
  var formate = "".obs;
  var datas = <String, dynamic>{}.obs;
  var connectivity = "".obs;
  var webIndex = 0.obs;
  var currentWebLink = "https://www.adoptapet.com/public/apis/pet_list".obs;
  var isDataFetch = false.obs;
  var icon = Icons.wifi_off_rounded.obs;
  List get entries {
    return [...datas['entries']];
  }

  var isoffline = false.obs;
  updateConnectionState(status) {
    connectivity.value = status;
  }

  updateDataFetchStatus() {
    isDataFetch.value = !isDataFetch.value;
  }

  previousWebLink() {
    if (webIndex > 0) {
      webIndex--;
      currentWebLink.value = entries[webIndex.value]['Link'];
    }
  }

  nextWebLink() {
    if (webIndex < datas['count']) {
      webIndex++;
      currentWebLink.value = entries[webIndex.value]['Link'];
    } else {
      webIndex.value = 0;
    }
  }

  List get entriesList {
    return [...datas['entries']];
  }

  @override
  void onInit() {
    super.onInit();
    updateMinut();
    updteHour();
    updateteFormate();
    updateDate();
    checkConnnection();
    fetch_data();
  }

  updateDatas(data) {
    datas.value = data;
  }

  updteHour() {
    hr.value = DateFormat('hh').format(DateTime.now());
    update();
  }

  updateMinut() {
    minut.value = DateFormat('mm').format(DateTime.now());
    update();
  }

  updateteFormate() {
    AmPm.value = DateFormat('a').format(DateTime.now());
  }

  updateDate() {
    formate.value = DateFormat('EEE d MMM').format(DateTime.now());
  }

  checkConnnection() {
    // ignore: unused_local_variable
    StreamSubscription? connection;

    connection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isoffline.value = true;
        icon.value = Icons.wifi_off_rounded;
        updateConnectionState("No internet connection");
      } else if (result == ConnectivityResult.mobile) {
        isoffline.value = false;
        icon.value = Icons.network_cell_rounded;
        updateConnectionState("Connected with mobile data");
      } else if (result == ConnectivityResult.wifi) {
        isoffline.value = false;
        icon.value = Icons.wifi_rounded;
        updateConnectionState("Connected with wifi data");
      } else if (result == ConnectivityResult.ethernet) {
        isoffline.value = false;
        icon.value = Icons.wifi_rounded;
        updateConnectionState("Connected with ethernet ");
      } else if (result == ConnectivityResult.bluetooth) {
        isoffline.value = false;
        icon.value = Icons.bluetooth_rounded;
        updateConnectionState("Connected with other");
      }
    });
  }

  // ignore: non_constant_identifier_names
  fetch_data() async {
    var client = http.Client();
    var url = "https://api.publicapis.org/entries";
    try {
      var res = await client.get(Uri.parse(url));

      if (res.statusCode == 200) {
        var result = jsonDecode(res.body);

        return DataCollection.fromJson(result);
      } else {
        return;
      }
    } catch (error) {
      // ignore: avoid_print
      print(error.toString());
    }
  }
}
