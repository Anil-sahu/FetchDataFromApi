import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raftlabassignment/controller/data.controller.dart';


class ScreenTwo extends StatefulWidget {
  const ScreenTwo({super.key});

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  FetchData fetchData = Get.put(FetchData());

  var greet = "";
  greeting() {
    var formate = fetchData.AmPm;
    var hr = fetchData.hr;
    var minut = fetchData.minut;

    switch (formate.value) {
      case 'AM':
        greet = "Good Morning";
        break;
      case 'PM':
        if (int.parse(hr.value) < 12 && int.parse(hr.value) < 5) {
          greet = "Good After Noon";
        } else {
          greet = "Good Evening";
        }
        break;
      default:
        greet = "Hey!..";
    }

    // greeting();
  }

  @override
  void initState() {
    
    greeting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  greet,
                  style: TextStyle(
                      // ignore: deprecated_member_use
                      color: Theme.of(context).accentColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                Text("RaftLab !",
                    style: TextStyle(
                        // ignore: deprecated_member_use
                        color: Theme.of(context).accentColor,
                        fontSize: 40,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(() {
                        return Text(
                          "${fetchData.hr.value} :",
                          style: const TextStyle(fontSize: 25, color: Colors.white),
                        );
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(() {
                        return Text(
                          fetchData.minut.toString(),
                          style: const TextStyle(fontSize: 25, color: Colors.white),
                        );
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(() {
                        return Text(
                          fetchData.AmPm.value,
                          style: const TextStyle(fontSize: 30, color: Colors.white),
                        );
                      }),
                    ),
                  ],
                ),
                Obx(() {
                  return Text(
                    fetchData.formate.value,
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  );
                }),
              ],
            ),
            const Divider(),
            Column(
              children: [
                Obx(
                  () => Icon(
                    fetchData.icon.value,
                    size: 80,
                    // ignore: deprecated_member_use
                    color: Theme.of(context).accentColor,
                  ),
                ),
                Obx(
                  () => Text(
                    fetchData.connectivity.value,
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
