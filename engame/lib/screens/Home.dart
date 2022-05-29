import 'package:engame/bigdata.dart';
import 'package:engame/consts.dart';
import 'package:flutter/material.dart';
import 'package:rolling_nav_bar/rolling_nav_bar.dart';

class EngameHomePage extends StatefulWidget {
  const EngameHomePage({Key? key}) : super(key: key);

  @override
  State<EngameHomePage> createState() => _EngameHomePageState();
}

class _EngameHomePageState extends State<EngameHomePage> {
  int activeIndex = 0;
  Widget? bodyWidget = pages[0];
  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: SizedBox(
          height: 0.08 * h,
          child: RollingNavBar.iconData(
            activeIndex: activeIndex,
            onTap: (activeIndex) {
              if (activeIndex == 0) {
                // Get.to(LoginPage());
                setState(() {
                  bodyWidget = pages[activeIndex];
                });
              }
              if (activeIndex == 1) {
                setState(() {
                  bodyWidget = pages[activeIndex];
                });
              }
              if (activeIndex == 2) {
                setState(() {
                  bodyWidget = pages[activeIndex];
                });
              }
              //! index değişiyor burada basıldığı indexteki sayfaya yönlendirme yapılacak
            },
            indicatorColors: const <Color>[
              Colors.green,
              Colors.blue,
              Color.fromARGB(255, 255, 7, 110),
            ],
            iconData: const <IconData>[
              Icons.play_circle,
              Icons.info,
              Icons.settings,
            ],
            iconText: const <Widget>[
              Text('Oyna', style: cMainButonYazi),
              Text('Hakkında', style: cMainButonYazi),
              Text('Ayarlar', style: cMainButonYazi),
            ],
          ),
        ),
        body: bodyWidget,
        backgroundColor: Colors.grey[400],
      ),
    );
  }
}
