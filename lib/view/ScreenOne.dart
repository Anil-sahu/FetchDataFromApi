// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raftlabassignment/controller/data.controller.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({super.key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  var isgetData = false;
  late Future<dynamic> dataList;

  FetchData fetchData = Get.put(FetchData());
  @override
  void initState() {
     setState(() {
      dataList = fetchData.fetch_data();
    });
    super.initState();
   
  }

  Widget entriesCard(data, width) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.api),
              ),
              Container(
                width: width - 48,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "API :${data['API']}",
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: data['Cors'] == 'no'
                    ? const Icon(
                        Icons.cancel,
                        color: Colors.red,
                      )
                    : const Icon(Icons.check_box, color: Colors.green),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Cors :${data['Cors']}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.category),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Category :${data['Category']}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Description :${data['Description']}",
              style: const TextStyle(
                color: Color.fromARGB(137, 31, 30, 30),
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 20, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.link,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 60,
                  child: InkWell(
                    child: Text(
                      data['Link'],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).primaryColor),
                    ),
                    onTap: () => launchUrl(Uri.parse(data['Link'])),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String search = "";

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: TextField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).accentColor,
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.white24,
            ),
            hintStyle: const TextStyle(color: Colors.white24),
            hintText: "Enter category name...",
            suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.close,
                  color: Colors.white24,
                ))),
        onChanged: (value) {
          setState(() {
            search = value;
          });
        },
        style: const TextStyle(
            color: Color.fromARGB(255, 226, 225, 225),
            fontWeight: FontWeight.bold,
            fontSize: 20),
      )),
      body: fetchData.isDataFetch.value
          ? Center(
              child: FutureBuilder(
                  future: dataList,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      fetchData.updateDatas(snapshot.data!.toJson());
                    }
                    if (fetchData.isoffline.value == true) {
                      return const Center(
                        child: Text("Check you network \n click Fetch Button"),
                      );
                    }
                    if (snapshot.data != null) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: fetchData.datas['count'],
                        itemBuilder: ((context, index) {
                          if (fetchData.datas['entries'][index]['Category']
                              .toLowerCase()
                              .contains(search.toLowerCase())) {
                            return Obx(() => entriesCard(
                                fetchData.datas['entries'][index], width));
                          }
                          return const SizedBox();
                        }),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  })),
            )
          : const Center(
              child: Text(
              "Click on fetch Button",
              style: TextStyle(fontSize: 15),
            )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            fetchData.updateDataFetchStatus();
          });
        },
        label: fetchData.isDataFetch.value
            ? const Text("Hide data")
            : const Text("Fetch Data"),
        isExtended: true,
      ),
    );
  }
}
