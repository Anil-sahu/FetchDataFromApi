// ignore: file_names
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raftlabassignment/controller/data.controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ScreenThree extends StatefulWidget {
  const ScreenThree({super.key});

  @override
  State<ScreenThree> createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {
  FetchData fetchData = Get.put(FetchData());
  var index = 0;
  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
          () => fetchData.datas['count'] != null
              ? Obx(
                  () => WebView(initialUrl: fetchData.currentWebLink.value),
                )
              : const Center(
                  child: Text("Please! First fetch data"),
                ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  fetchData.previousWebLink();
                },
                child: const Icon(Icons.navigate_before),
              ),
              FloatingActionButton.extended(
                onPressed: () {},
                label: Obx(() => fetchData.datas['entries'] != null
                    ? Text(
                        "${fetchData.datas['entries'].length}/${fetchData.webIndex.value}")
                    : const Text("0/0")),
              ),
              FloatingActionButton(
                onPressed: () {
                  fetchData.nextWebLink();
                },
                child: const Icon(Icons.navigate_next),
              )
            ]
          ),
        ));
  }
}
