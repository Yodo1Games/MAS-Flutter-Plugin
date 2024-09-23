import 'dart:developer';
import 'dart:io';
//import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:yodo1mas/Yodo1MasNativeAd.dart';
import 'package:yodo1mas/testmasfluttersdktwo.dart';
import 'package:flutter_pptx/flutter_pptx.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    Yodo1MAS.instance.init("JR835c6fza", false,(successful) {

    });
    final presentation = FlutterPowerPoint();

  for (int i = 0; i < titles.length; i++) {
    Slide slide = presentation.addTitleOnlySlide(
      title: titles[i].toTextValue(),
      subtitle: contents[i].toTextValue(),
    );

    slide.background.image = ImageReference(
      //path: 'assets/images/Texture1.jpg',
      path: 'assets/images/' + tem,
      name: templateName,
    );
    sli
  }
    Yodo1MAS.instance.showReportAdDialog();



    //givereward();
    Yodo1MAS.instance.setRewardListener((event, message) {
      switch(event) {
        case Yodo1MAS.AD_EVENT_OPENED:
          print('RewardVideo AD_EVENT_OPENED');
          break;
        case Yodo1MAS.AD_EVENT_ERROR:
          print('RewardVideo AD_EVENT_ERROR' + message);
          break;
        case Yodo1MAS.AD_EVENT_CLOSED:
          print('RewardVideo finally? AD_EVENT_CLOSED');

          givereward();
          break;
        case Yodo1MAS.AD_EVENT_EARNED:
          print("====================================");
          print('RewardVideo AD_EVENT_EARNED');

          break;
      }});

    //Yodo1MAS.instance.showBannerAd();
    initPlatformState();
    //Yodo1MAS.instance.showBannerAd();

  }
  void givereward()
  {


  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    //Yodo1MAS.instance.showBannerAd();
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.


    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Unity Ads Example'),
        ),
        body: const SafeArea(
          child: YodoAdsExample(),
        ),
      ),
    );
  }
}

class YodoAdsExample extends StatefulWidget {
  const YodoAdsExample({Key? key}) : super(key: key);

  @override
  _YodoAdsExampleState createState() => _YodoAdsExampleState();
}

class _YodoAdsExampleState extends State<YodoAdsExample> {
   static bool _showBanner = false;

  @override
  void initState() {
    super.initState();
  }



   bool _pinned = true;
   bool _snap = true;
   bool _floating = true;

// [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
// turn can be placed in a [Scaffold.body].
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[

          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(
                child: Text('Scroll to see the SliverAppBar in effect.'),
              ),
            ),
          ),

          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 60.0,
            elevation: 50,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('SliverAppBar'),
              background: FlutterLogo(),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 300.0,
                  child: Center(
                    child: Yodo1MASNativeAd(
                      size: NativeSize.NativeLarge,
                      backgroundColor: "BLACK",
                      onLoad: (){
                        Yodo1MAS.instance.dismissNativeAd();
                        log("##############################################################\n ##########################");
                        },


                    )

                  ),
                );
              },
              childCount: 1,
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child: Text('$index', textScaleFactor: 5),
                  ),
                );
              },
              childCount: 20,
            ),
          ),

          SliverList(delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Container(
                height: 300,
                child: Center(
                    child:  Yodo1MASBannerAd(
                      size: BannerSize.Banner,
                      onLoad: (){
                        log("Loaded \n \n ");
                        //Yodo1MAS.instance.dismissBannerAd2();
                      },
                      onLoadFailed: (error) {
                        log("fail \n \n \n ");
                        },
                    )
                ),
              );
            },
            childCount: 1,
          ),),



        ],
      ),
      bottomNavigationBar: BottomAppBar(

        child:PreferredSize(
          child: Container(
              height: 150,


        child: Padding(
          padding: const EdgeInsets.all(8),

          child:Column(

            children: <Widget>[
              OverflowBar(
            overflowAlignment: OverflowBarAlignment.center,

            children: <Widget>[

              Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: <Widget>[
                    IconButton(
                        iconSize: 30.0,
                        padding: EdgeInsets.only(left: 28.0),
                        icon: Icon(Icons.search),
                        onPressed: () {}),
                    IconButton(
                      iconSize: 30.0,
                      padding: EdgeInsets.only(left:20.0),
                      icon: Icon(Icons.add),
                      onPressed: () {},
                    ),
                    IconButton(
                      iconSize: 30.0,
                      padding: EdgeInsets.only(right: 28.0),
                      icon: Icon(Icons.alarm),
                      onPressed: () {},
                    ),
                  ]),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('snap'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _snap = val;
                        // Snapping only applies when the app bar is floating.
                        _floating = _floating || _snap;
                      });
                    },
                    value: _snap,
                  ),
                ],
              ),


            ],
          ),
          ])
        ),
      ),
            preferredSize: Size.fromHeight(150.0)),
      ),
    );
  }

}

