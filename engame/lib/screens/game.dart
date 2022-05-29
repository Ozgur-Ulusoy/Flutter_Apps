import 'dart:async';
import 'dart:math';

import 'package:engame/provider/provider.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:engame/bigdata.dart';
import 'package:engame/consts.dart';
import 'package:engame/screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class GamePage extends StatefulWidget {
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static String soru = "soru";
  static String buton0_text = "buton 0";
  static String buton1_text = "buton 1";
  static String buton2_text = "buton 2";
  static String buton3_text = "buton 3";

  static bool btn0 = false;
  static bool btn1 = false;
  static bool btn2 = false;
  static bool btn3 = false;

  static int point = 0;
  static int true_answer = 0;
  static int false_answer = 0;

  static String previousAnswer = "-";
  static String dorumu = "beyaz";
  static String previousAnswer2 = "-";
  static String oyundili = "eng";
  static int arkaplan = 1;
  Timer? timer;
  Random rnd = Random();
  int max_puan = 0;
  static bool ses = true;
  int time = 1210;

  void resle() {
    Provider.of<MyProvider>(context, listen: false).resle();
    point = 0;
    true_answer = 0;
    false_answer = 0;
    btn0 = false;
    btn1 = false;
    btn2 = false;
    btn3 = false;
    previousAnswer = "-";
    previousAnswer2 = "-";
    dorumu = "beyaz";
  }

  void startTimer() {
    time = 1210; //!1210
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      Provider.of<MyProvider>(context, listen: false).azalt();
      // setState(() {
      //   if (time > 0) {
      //     time--;
      //   }
      if (time <= 0) {
        setState(() async {
          int randomtext = rnd.nextInt(5);
          timer.cancel();
          if (max_puan < point) {
            max_puan = point;
            saveDataPuan();
          }

          // Get.to(const ScorePage());
          Get.defaultDialog(
            barrierDismissible: false,
            title: point < 6000
                ? endScreenText[randomtext]
                : endScreenText[randomtext + 5],
            titleStyle: cBaslik2,
            middleTextStyle: cYazi2,
            backgroundColor: Colors.grey[350],
            middleText: max_puan > point
                ? "Puanınız = $point \n En İyi Puanınız = $max_puan"
                : "Yeni Rekor ! \n En iyi puanınız = $point",
            cancel: IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Get.offAll(const EngameHomePage());
                resle();
              },
            ),
            confirm: IconButton(
              onPressed: () {
                // Get.back();
                // Get.back();
                // Get.to(GamePage());
                // resle();
                // oyun();
                Get.back();
                setState(() {
                  resle();
                  startTimer();
                  oyun();
                });
              },
              icon: const Icon(Icons.restart_alt),
            ),
          );
          //   });
          // }
        });
      }
    });
  }

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getInt("maxpuan") == null) {
        prefs.setInt("maxpuan", 0);
      }
      max_puan = prefs.getInt("maxpuan")!;

      if (prefs.getBool("ses") == null) {
        prefs.setBool("ses", true);
      }
      ses = prefs.getBool("ses")!;

      if (prefs.getString("oyundili") == null) {
        prefs.setString("oyundili", "eng");
      }
      oyundili = prefs.getString("oyundili")!;

      if (prefs.getInt("arkaplan") == null) {
        prefs.setInt("arkaplan", 1);
      }
      arkaplan = prefs.getInt("arkaplan")!;
    });
  }

  saveDataPuan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("maxpuan", point);
  }

  saveDataSes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("ses", ses);
  }

  var data = Get.arguments;

  @override
  void initState() {
    resle(); // !
    startTimer();
    _loadData();
    // oyundili == "tr" ? oyun(a: 1) : oyun(a: 2);
    oyun(a: data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    time = Provider.of<MyProvider>(context).time;

    return WillPopScope(
      onWillPop: () async {
        Get.offAll(const EngameHomePage());
        // resle();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(children: [
            Container(
              height: Get.height,
              color: arkaplan == 2
                  ? const Color.fromARGB(255, 18, 209, 184)
                  : (arkaplan == 3
                      ? const Color.fromARGB(255, 255, 127, 42)
                      : arkaplan == 4
                          ? const Color.fromARGB(255, 29, 0, 0)
                          : null),
              decoration: arkaplan == 1
                  ? const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/bk.jpg"),
                          fit: BoxFit.fill),
                    )
                  : null,
            ),
            Column(
              children: [
                SizedBox(
                  height: Get.height * 0.025,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.av_timer,
                            size: 35,
                          ),
                          iconColor: Colors.brown,
                          title: Text(
                            "${time ~/ 10}",
                            style: cGameYazi2,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.check,
                            size: 35,
                          ),
                          iconColor: Colors.green,
                          title: Text(
                            "$true_answer",
                            style: cGameYazi2,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.cancel,
                            size: 35,
                          ),
                          iconColor: Colors.red,
                          title: Text(
                            "$false_answer",
                            style: cGameYazi2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.3 * Get.width),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.star,
                        size: 35,
                      ),
                      iconColor: Colors.yellowAccent,
                      title: Text(
                        "$point",
                        style: cGameYazi2,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text(
                  soru,
                  style: arkaplan == 3 ? cGameSoru3 : cGameSoru1,
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                SoruButon(buton0_text, btn0),
                SoruButon(buton1_text, btn1),
                SoruButon(buton2_text, btn2),
                SoruButon(buton3_text, btn3),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text("Önceki Sorunun Cevabı",
                    style: arkaplan == 2 ? cOnceki2 : cGameBuyukYaziBosBuyuk),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  previousAnswer,
                  style: dorumu == "beyaz"
                      ? cGameBuyukYaziBos
                      : (dorumu == "dogru"
                          ? cGameBuyukYaziDogru
                          : cGameBuyukYaziYanlis),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.05,
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.offAll(const EngameHomePage());
                          },
                          icon: const Icon(
                            Icons.keyboard_backspace,
                            color: Color.fromARGB(255, 252, 18, 2),
                            size: 45,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        const Text(
                          "Geri Dön",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )
                      ],
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    SizedBox(
                      width: Get.width * 0.05,
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}

void oyun({String a = ""}) {
  Random rnd = Random();
  int rstglSoruNum = rnd.nextInt(5000);
  int rstglDogruButon = rnd.nextInt(4);
  if (a != "") {
    _GamePageState.soru =
        a == "eng" ? eng_kelime[rstglSoruNum] : tr_kelime[rstglSoruNum];
    _GamePageState.buton0_text = a == "eng"
        ? tr_kelime[rnd.nextInt(5000)]
        : eng_kelime[rnd.nextInt(5000)];
    _GamePageState.buton1_text = a == "eng"
        ? tr_kelime[rnd.nextInt(5000)]
        : eng_kelime[rnd.nextInt(5000)];
    _GamePageState.buton2_text = a == "eng"
        ? tr_kelime[rnd.nextInt(5000)]
        : eng_kelime[rnd.nextInt(5000)];
    _GamePageState.buton3_text = a == "eng"
        ? tr_kelime[rnd.nextInt(5000)]
        : eng_kelime[rnd.nextInt(5000)];
    String cevap =
        a == "eng" ? tr_kelime[rstglSoruNum] : eng_kelime[rstglSoruNum];
    _GamePageState.previousAnswer2 = cevap;

    switch (rstglDogruButon) {
      case 0:
        _GamePageState.btn0 = true;
        _GamePageState.buton0_text = cevap;
        break;
      case 1:
        _GamePageState.btn1 = true;
        _GamePageState.buton1_text = cevap;
        break;
      case 2:
        _GamePageState.btn2 = true;
        _GamePageState.buton2_text = cevap;
        break;
      case 3:
        _GamePageState.btn3 = true;
        _GamePageState.buton3_text = cevap;
        break;
      default:
    }
  }

  if (a == "") {
    _GamePageState.soru = _GamePageState.oyundili == "eng"
        ? eng_kelime[rstglSoruNum]
        : tr_kelime[rstglSoruNum];
    _GamePageState.buton0_text = _GamePageState.oyundili == "eng"
        ? tr_kelime[rnd.nextInt(5000)]
        : eng_kelime[rnd.nextInt(5000)];
    _GamePageState.buton1_text = _GamePageState.oyundili == "eng"
        ? tr_kelime[rnd.nextInt(5000)]
        : eng_kelime[rnd.nextInt(5000)];
    _GamePageState.buton2_text = _GamePageState.oyundili == "eng"
        ? tr_kelime[rnd.nextInt(5000)]
        : eng_kelime[rnd.nextInt(5000)];
    _GamePageState.buton3_text = _GamePageState.oyundili == "eng"
        ? tr_kelime[rnd.nextInt(5000)]
        : eng_kelime[rnd.nextInt(5000)];
    String cevap = _GamePageState.oyundili == "eng"
        ? tr_kelime[rstglSoruNum]
        : eng_kelime[rstglSoruNum];
    _GamePageState.previousAnswer2 = cevap;

    switch (rstglDogruButon) {
      case 0:
        _GamePageState.btn0 = true;
        _GamePageState.buton0_text = cevap;
        break;
      case 1:
        _GamePageState.btn1 = true;
        _GamePageState.buton1_text = cevap;
        break;
      case 2:
        _GamePageState.btn2 = true;
        _GamePageState.buton2_text = cevap;
        break;
      case 3:
        _GamePageState.btn3 = true;
        _GamePageState.buton3_text = cevap;
        break;
      default:
    }
  }
}

void playAudio(String adres) async {
  AssetsAudioPlayer ast = AssetsAudioPlayer();
  ast.open(Audio(adres));
}

Widget SoruButon(String text, bool istrue) {
  return Padding(
    padding: EdgeInsets.all(0.03 * Get.width),
    child: GlassContainer(
      borderRadius: BorderRadius.circular(30),
      height: Get.height * 0.07,
      width: Get.height * 0.8,
      gradient: LinearGradient(
        colors: [
          const Color.fromARGB(255, 163, 45, 184).withOpacity(0.20),
          const Color.fromARGB(255, 8, 127, 224).withOpacity(0.10)
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderGradient: LinearGradient(
        colors: [
          const Color.fromARGB(255, 197, 54, 54).withOpacity(0.5),
          const Color.fromARGB(255, 154, 219, 192).withOpacity(0.3),
          const Color.fromARGB(255, 189, 89, 150).withOpacity(0.3),
          const Color.fromARGB(255, 18, 160, 226).withOpacity(0.5)
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: const [0.0, 0.39, 0.40, 1.0],
      ),
      blur: 0.5,
      borderWidth: 1.5,
      elevation: 1.0,
      isFrostedGlass: true,
      shadowColor: Colors.black.withOpacity(0.20),
      alignment: Alignment.center,
      frostedOpacity: 0,
      child: InkWell(
        onTap: () {
          if (istrue) {
            _GamePageState.true_answer += 1;
            _GamePageState.point += 200;
            _GamePageState.btn0 = false;
            _GamePageState.btn1 = false;
            _GamePageState.btn2 = false;
            _GamePageState.btn3 = false;
            _GamePageState.dorumu = "dogru";
            if (_GamePageState.ses == true) {
              playAudio("assets/sounds/correct-sound-effect.mp3");
            }
          } else {
            _GamePageState.false_answer += 1;
            _GamePageState.point -= 100;
            _GamePageState.btn0 = false;
            _GamePageState.btn1 = false;
            _GamePageState.btn2 = false;
            _GamePageState.btn3 = false;
            _GamePageState.dorumu = "yanlis";
            if (_GamePageState.ses == true) {
              playAudio("assets/sounds/wrong-answer-sound-effect-hd.mp3");
            }
          }
          _GamePageState.previousAnswer = _GamePageState.previousAnswer2;
          oyun();
        },
        child: Ink(
          height: Get.height * 0.06,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    text,
                    style: cGameYazi,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
