import 'package:flutter/material.dart';

import 'view/ScreenOne.dart';
import 'view/ScreenThree.dart';
import 'view/screenTwo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RaftLabs',
      theme: ThemeData(
        cardColor: const Color.fromARGB(255, 240, 229, 253),
        primaryColor: const Color.fromARGB(255, 41, 2, 114),
        // primarySwatch: Colors.blue,
        accentColor: const Color.fromARGB(255, 199, 169, 255),
        canvasColor: const Color.fromARGB(255, 255, 255, 255),

        highlightColor: Colors.black26,
        primaryTextTheme: TextTheme(
            bodyText1: TextStyle(
          color: Colors.black45,
          fontSize: 30,
        )),
        appBarTheme: const AppBarTheme(
            backgroundColor:Color.fromARGB(255, 41, 2, 114)),
        // textTheme: const TextTheme(bodyText1: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),
        // bodyText2: TextStyle(color:Colors.black45,fontSize: 20)),
        // bottomAppBarTheme: const BottomAppBarTheme(color:Color.fromARGB(255, 105, 0, 241))
      ),
      home: const MyHOmePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHOmePage extends StatefulWidget {
  const MyHOmePage({super.key});

  @override
  State<MyHOmePage> createState() => _MyHOmePageState();
}

class _MyHOmePageState extends State<MyHOmePage> {
  int pageIndex = 0;

// Screen List---------------------------------
  final pages = [
    const ScreenOne(),
    const ScreenTwo(),
    const ScreenThree(),
  ];



  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: width>568?PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          title: const Text(
            "Raftlabs",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          actions:[
            Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(onPressed: (() {
                setState(() {
                  pageIndex=0;
                });
                
              }),
              style:pageIndex==0? ElevatedButton.styleFrom(side: BorderSide(width: 2,color: Colors.white),elevation: 5,shadowColor: Colors.white,backgroundColor: Theme.of(context).accentColor): ElevatedButton.styleFrom(backgroundColor: Theme.of(context).accentColor), child:const Text("Screen One"),
              
              ),
            ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: ElevatedButton(onPressed: (() {
                setState(() {
                  pageIndex=1;
                });
                
            }), child: Text("Screen Two"),
            style:pageIndex==1? ElevatedButton.styleFrom(side: BorderSide(width: 2,color: Colors.white),elevation: 5,shadowColor: Colors.white,backgroundColor: Theme.of(context).accentColor): ElevatedButton.styleFrom(backgroundColor: Theme.of(context).accentColor),
            
            ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: ElevatedButton(onPressed: (() {
                setState(() {
                  pageIndex=2;
                });
                
            }), child: Text("Screen Three"),
            style:pageIndex==2? ElevatedButton.styleFrom(side: BorderSide(width: 2,color: Colors.white),elevation: 5,shadowColor: Colors.white,backgroundColor: Theme.of(context).accentColor): ElevatedButton.styleFrom(backgroundColor: Theme.of(context).accentColor),
            ),
              )
          ],
        ),
      ): AppBar(
        elevation: 0,
        title: const Text(
          "Raftlabs",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          
        ),
      
      ),
      body: pages[pageIndex],
      bottomNavigationBar:width<567? Container(
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              icon: pageIndex == 0
                  ? const Icon(
                      Icons.home_rounded,
                      color: Colors.white,
                      size: 30,
                    )
                  :  Icon(
                      Icons.home_rounded,
                      color: Theme.of(context).accentColor,
                      size: 30,
                    ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              icon: pageIndex == 1
                  ? const Icon(
                      Icons.network_ping,
                      color: Colors.white,
                      size: 30
                    )
                  : Icon(
                      Icons.network_ping_rounded,
                      color: Theme.of(context).accentColor,
                      size: 30,
                    ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              icon: pageIndex == 2
                  ? const Icon(
                      Icons.web_asset,
                      color: Colors.white,
                      size: 30,
                    )
                  :  Icon(
                      Icons.web_asset,
                      color: Theme.of(context).accentColor,
                      size: 30,
                    ),
            ),
          ],
        ),
      ):Divider(),
    );
  }
}
