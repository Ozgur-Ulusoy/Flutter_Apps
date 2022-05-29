import 'package:engame/consts.dart';
import 'package:engame/screens/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  _launchURL() async {
    const String url =
        'https://www.linkedin.com/in/özgür-taylan-ulusoy-15a603222/';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    return Container(
      height: Get.height - Get.height * 0.08,
      color: Colors.blueGrey[200],
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.08,
          ),
          const Text(
            "Hakkında",
            style: cBaslik,
          ),
          SizedBox(
            height: Get.height * 0.008,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 35, top: 5),
            child: Text(
              "ENGAME'in amacı oyun oynarken ingilizce kelime haznenizi geliştirmektir",
              style: cYazi,
            ),
          ),
          SizedBox(
            height: 0.01 * h,
          ),
          SizedBox(
            width: 0.85 * Get.width,
            child: Divider(
              thickness: 1.5,
              height: 15,
              color: Colors.brown[900],
            ),
          ),
          SizedBox(
            height: 0.01 * h,
          ),
          const Text(
            "Geliştirici Hakkında",
            style: cBaslik2,
          ),
          SizedBox(
            height: 0.02 * h,
          ),
          const Text(
            "Linkedln",
            style: cSosyal,
          ),
          SizedBox(
            height: 0.02 * h,
          ),
          GestureDetector(
            onTap: () async {
              _launchURL();
            },
            child: const Card(
              child: ListTile(
                leading: Icon(Icons.account_box),
                iconColor: Colors.blue,
                title: Text(
                  "Özgür Taylan Ulusoy",
                  style: cYazi2,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 0.02 * h,
          ),
          const Text(
            "Email",
            style: cSosyal,
          ),
          SizedBox(
            height: 0.02 * h,
          ),
          GestureDetector(
            onTap: () async {
              String email = "ozgurcoderr@gmail.com";
              String? encodeQueryParameters(Map<String, String> params) {
                return params.entries
                    .map((e) =>
                        '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                    .join('&');
              }

              final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: email,
                  queryParameters: {"subject": "ENGAME_HAKKINDA"});

              launch(emailLaunchUri.toString());
            },
            child: const Card(
              child: ListTile(
                leading: Icon(Icons.email),
                iconColor: Colors.blue,
                title: Text(
                  "ozgurcoderr@gmail.com",
                  style: cYazi3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static bool basladimi = false;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int max_puan = 0;
  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getInt("maxpuan") == null) {
        prefs.setInt("maxpuan", 0);
      }
      max_puan = prefs.getInt("maxpuan")!;
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: Get.height - Get.height * 0.08,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/mainbck.jpg"),
                fit: BoxFit.fill),
          ),
        ),
        //!
        Column(
          children: [
            Container(
              height: Get.height * 0.06,
            ),
            const Center(
              child: Text(
                "ENGAME",
                style: cBaslik3,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GlassContainer(
                borderRadius: BorderRadius.circular(50),
                height: Get.height * 0.05,
                width: Get.width * 0.8,
                borderWidth: 1.2,
                borderGradient: LinearGradient(colors: [
                  const Color.fromARGB(255, 164, 92, 177).withOpacity(0.7),
                  const Color.fromARGB(255, 213, 92, 235).withOpacity(0.7)
                ]),
                blur: 1,
                gradient: LinearGradient(colors: [
                  Colors.white.withOpacity(0.075),
                  Colors.white.withOpacity(0.05)
                ]),
                child: Center(
                  child: Text("Rekor : $max_puan ",
                      style: max_puan >= 11800
                          ? cpuan10
                          : (max_puan >= 10600
                              ? cpuan9
                              : (max_puan >= 9400
                                  ? cpuan8
                                  : (max_puan >= 8200
                                      ? cpuan7
                                      : (max_puan >= 7000
                                          ? cpuan6
                                          : (max_puan >= 5800
                                              ? cpuan5
                                              : (max_puan >= 4600
                                                  ? cpuan4
                                                  : (max_puan >= 3400
                                                      ? cpuan3
                                                      : (max_puan >= 2200
                                                          ? cpuan2
                                                          : (max_puan >= 1000
                                                              ? cpuan1
                                                              : cpuan0)))))))))),
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              GlassContainer(
                borderRadius: BorderRadius.circular(50),
                height: Get.height * 0.05,
                width: Get.width * 0.8,
                borderWidth: 1.2,
                borderGradient: LinearGradient(colors: [
                  const Color.fromARGB(255, 164, 92, 177).withOpacity(0.7),
                  const Color.fromARGB(255, 213, 92, 235).withOpacity(0.7)
                ]),
                blur: 1,
                gradient: LinearGradient(colors: [
                  Colors.white.withOpacity(0.075),
                  Colors.white.withOpacity(0.05)
                ]),
                child: const Center(
                  child: Text(
                    "+5000 Kelime",
                    style: cMainYazi2,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.11,
              )
            ],
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: Get.height * 0.2,
            ),
            Center(
              child: GlassContainer(
                borderRadius: BorderRadius.circular(10),
                height: Get.height * 0.3,
                width: Get.width * 0.8,
                borderWidth: 1.2,
                borderGradient: LinearGradient(colors: [
                  const Color.fromARGB(255, 211, 138, 224).withOpacity(0.7),
                  const Color.fromARGB(255, 193, 89, 214).withOpacity(0.7)
                ]),
                blur: 1,
                gradient: LinearGradient(colors: [
                  Colors.white.withOpacity(0.075),
                  Colors.white.withOpacity(0.075)
                ]),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 80,
                      onPressed: () {
                        // saveDataDil();
                        Get.to(GamePage(),
                            arguments: _SettingsPageState.oyundili);
                      },
                      icon: const Icon(
                        Icons.play_circle_outlined,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Play",
                      style: cBaslik2,
                    )
                  ],
                )),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static String oyundili = "eng";
  static int arkaplan = 0;
  static bool ses = true;
  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getString("oyundili") == null) {
        prefs.setString("oyundili", "eng");
      }
      oyundili = prefs.getString("oyundili")!;

      if (prefs.getInt("arkaplan") == null) {
        prefs.setInt("arkaplan", 1);
      }
      arkaplan = prefs.getInt("arkaplan")!;

      if (prefs.getBool("ses") == null) {
        prefs.setBool("ses", true);
      }
      ses = prefs.getBool("ses")!;
    });
  }

  static saveDataDil() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("oyundili", oyundili);
  }

  static saveDataArkaplan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("arkaplan", arkaplan);
  }

  saveDataSes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("ses", ses);
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: Get.height - Get.height * 0.08,
        width: Get.width,
        color: const Color.fromARGB(255, 73, 66, 75),
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.004,
            ),
            const Text(
              "Ayarlar",
              style: cBaslik,
            ),
            SizedBox(
              height: Get.height * 0.001,
            ),
            const Text(
              "Soru Dili",
              style: cAyarlar,
            ),
            SizedBox(
              height: Get.height * 0.012,
            ),
            GlassContainer(
              borderRadius: BorderRadius.circular(10),
              height: Get.height * 0.18,
              width: Get.width * 0.9,
              borderWidth: 1.5,
              blur: 1,
              gradient: LinearGradient(colors: [
                Colors.white.withOpacity(0.18),
                Colors.white.withOpacity(0.15)
              ]),
              borderGradient: const LinearGradient(colors: [
                Color.fromARGB(255, 235, 63, 157),
                Color.fromARGB(255, 206, 114, 214)
              ]),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              iconSize: 35,
                              onPressed: () {
                                // SharedPreferences prefs = await SharedPreferences.getInstance();
                                setState(() {
                                  oyundili = "tr";
                                  saveDataDil();
                                  // print(oyundili);
                                });
                              },
                              icon: const Image(
                                image: AssetImage("assets/images/Türkçe.png"),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Türkçe",
                              style: oyundili == "tr"
                                  ? cAyarlarSecilmis
                                  : cMainYazi,
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        IconButton(
                          iconSize: 35,
                          onPressed: () {
                            // SharedPreferences prefs = await SharedPreferences.getInstance();
                            setState(() {
                              oyundili = "eng";
                              saveDataDil();
                              // print(_HomePageState.oyundili);
                            });
                          },
                          icon: const Image(
                            image: AssetImage("assets/images/English.png"),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "English",
                          style:
                              oyundili == "eng" ? cAyarlarSecilmis : cMainYazi,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.012,
            ),
            const Text(
              "Arkaplan",
              style: cAyarlar2,
            ),
            SizedBox(
              height: Get.height * 0.012,
            ),
            GlassContainer(
              borderRadius: BorderRadius.circular(10),
              height: Get.height * 0.2,
              width: Get.width * 0.9,
              borderWidth: 1.5,
              blur: 1,
              gradient: LinearGradient(colors: [
                Colors.white.withOpacity(0.18),
                Colors.white.withOpacity(0.15)
              ]),
              borderGradient: const LinearGradient(colors: [
                Color.fromARGB(255, 235, 63, 157),
                Color.fromARGB(255, 206, 114, 214)
              ]),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            IconButton(
                              iconSize: Get.width * 0.15,
                              onPressed: () {
                                setState(() {
                                  arkaplan = 1;
                                  saveDataArkaplan();
                                });
                              },
                              icon: Image(
                                image: const AssetImage(
                                  "assets/images/mainbck.jpg",
                                ),
                                fit: BoxFit.fitWidth,
                                width: Get.width * 0.14,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("1",
                                style: arkaplan == 1
                                    ? cArkaplanSecilmis
                                    : cArkaplanSecilmemis)
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            iconSize: Get.width * 0.15,
                            onPressed: () {
                              setState(() {
                                arkaplan = 2;
                                saveDataArkaplan();
                              });
                            },
                            icon: Container(
                              color: const Color.fromARGB(255, 18, 209, 184),
                              width: Get.width * 0.14,
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        Text("2",
                            style: arkaplan == 2
                                ? cArkaplanSecilmis
                                : cArkaplanSecilmemis)
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            iconSize: Get.width * 0.15,
                            onPressed: () {
                              setState(() {
                                arkaplan = 3;
                                saveDataArkaplan();
                              });
                            },
                            icon: Container(
                              color: const Color.fromARGB(255, 255, 127, 42),
                              width: Get.width * 0.14,
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        Text("3",
                            style: arkaplan == 3
                                ? cArkaplanSecilmis
                                : cArkaplanSecilmemis)
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            iconSize: Get.width * 0.15,
                            onPressed: () {
                              setState(() {
                                arkaplan = 4;
                                saveDataArkaplan();
                              });
                            },
                            icon: Container(
                              color: const Color.fromARGB(255, 29, 0, 0),
                              width: Get.width * 0.14,
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        Text("4",
                            style: arkaplan == 4
                                ? cArkaplanSecilmis
                                : cArkaplanSecilmemis)
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.005,
            ),
            const Text(
              "Ses",
              style: cAyarlar3,
            ),
            SizedBox(
              height: Get.height * 0.005,
            ),
            GlassContainer(
              borderRadius: BorderRadius.circular(10),
              height: Get.height * 0.18,
              width: Get.width * 0.9,
              borderWidth: 1.5,
              blur: 1,
              gradient: LinearGradient(colors: [
                Colors.white.withOpacity(0.18),
                Colors.white.withOpacity(0.15)
              ]),
              borderGradient: const LinearGradient(colors: [
                Color.fromARGB(255, 235, 63, 157),
                Color.fromARGB(255, 206, 114, 214)
              ]),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              iconSize: 35,
                              onPressed: () {
                                setState(() {
                                  ses = false;
                                  saveDataSes();
                                });
                              },
                              icon: const Icon(
                                Icons.volume_off,
                                size: 40,
                              ),
                              color: ses == false ? Colors.red : Colors.white,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Ses Kapalı",
                              style: ses == false ? cKapali : cOlumsuz,
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        IconButton(
                          iconSize: 35,
                          onPressed: () {
                            // SharedPreferences prefs = await SharedPreferences.getInstance();
                            setState(() {
                              ses = true;
                              saveDataSes();
                              // print(_HomePageState.oyundili);
                            });
                          },
                          icon: const Icon(
                            Icons.volume_up,
                            size: 40,
                          ),
                          color: ses == true
                              ? const Color.fromARGB(210, 86, 243, 24)
                              : Colors.white,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Ses Açık", style: ses == true ? cAcik : cOlumsuz,
                          // style:
                          //     oyundili == "eng" ? cAyarlarSecilmis : cMainYazi,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
