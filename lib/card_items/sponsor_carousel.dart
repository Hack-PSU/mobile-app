import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../widgets/default_text.dart';

const ECHO_AR_SVG_URL =
    "https://firebasestorage.googleapis.com/v0/b/hackpsu18.appspot.com/o/sponsorship-logos%2FEchoAR-day.svg?alt=media";
const EECS_SVG_URL =
    "https://firebasestorage.googleapis.com/v0/b/hackpsu18.appspot.com/o/sponsorship-logos%2FEECS-day.png?alt=media";
const ICDS_SVG_URL =
    "https://firebasestorage.googleapis.com/v0/b/hackpsu18.appspot.com/o/sponsorship-logos%2FICDS-day.svg?alt=media";
const MICROSOFT_SVG_URL =
    "https://firebasestorage.googleapis.com/v0/b/hackpsu18.appspot.com/o/sponsorship-logos%2FMicrosoft_original.svg?alt=media";
const NITTANY_AI_SVG_URL =
    "https://firebasestorage.googleapis.com/v0/b/hackpsu18.appspot.com/o/sponsorship-logos%2Fnittanyai-day.svg?alt=media";
const CELONIS_SVG_URL =
    "https://firebasestorage.googleapis.com/v0/b/hackpsu18.appspot.com/o/sponsorship-logos%2FCelonis.png?alt=media";
const MT_TECH_SVG_URL =
    "https://firebasestorage.googleapis.com/v0/b/hackpsu18.appspot.com/o/sponsorship-logos%2FM%26T_Tech.png?alt=media";
const PSU_EC_SVG_URL =
    "https://firebasestorage.googleapis.com/v0/b/hackpsu18.appspot.com/o/sponsorship-logos%2FPSU_E%26C.svg?alt=media";
const BAKER_HUGHES_SVG_URL =
    "https://firebasestorage.googleapis.com/v0/b/hackpsu18.appspot.com/o/sponsorship-logos%2FBaker-Hughes.png?alt=media";
const PWC_SVG_URL =
    "https://firebasestorage.googleapis.com/v0/b/hackpsu18.appspot.com/o/sponsorship-logos%2FPricewaterhouseCoopers.svg?alt=media";
const PSU_GO_SVG_URL =
    "https://firebasestorage.googleapis.com/v0/b/hackpsu18.appspot.com/o/sponsorship-logos%2FPSU_GO_SVG.png?alt=media";

const ECHO_AR_URL = "https://www.echoar.xyz/";
const EECS_URL = "https://www.eecs.psu.edu/";
const ICDS_URL = "https://www.icds.psu.edu/";
const MICROSOFT_URL = "https://www.microsoft.com/";
const NITTANY_AI_URL = "https://nittanyai.psu.edu/";
const PWC_URL = "https://www.pwc.com/";
const MT_TECH_URL = "https://www3.mtb.com/techhub";
const BAKER_HUGHES_URL = "https://www.bakerhughes.com/";
const PSU_EC_URL = "https://oec.psu.edu/";
const CELONIS_URL = "https://www.celonis.com/";
const PSU_GO_URL = "https://mobile.psu.edu/";

class SponsorCarousel extends StatelessWidget {
  const SponsorCarousel({
    Key? key,
    this.sponsors,
  }) : super(key: key);

  final List<Map<String, String>>? sponsors;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultText(
            "Our Sponsors",
            textLevel: TextLevel.h2,
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 10.0),
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              enlargeCenterPage: true,
            ),
            // items: [
            //   [NITTANY_AI_SVG_URL, NITTANY_AI_URL],
            //   [MT_TECH_SVG_URL, MT_TECH_URL],
            //   [CELONIS_SVG_URL, CELONIS_URL],
            //   [PSU_EC_SVG_URL, PSU_EC_URL],
            //   [EECS_SVG_URL, EECS_URL],
            //   [ICDS_SVG_URL, ICDS_URL],
            //   [PWC_SVG_URL, PWC_URL],
            //   [ECHO_AR_SVG_URL, ECHO_AR_URL],
            // ]
            items: sponsors!.map(
              (i) {
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () async {
                        if (!await launchUrlString(i["url"]!)) {
                          throw Exception("Could not launch ${i["url"]}");
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            if (i["image"]!.contains(".png"))
                              Image.network(
                                i["image"]!,
                                width: MediaQuery.of(context).size.width * 0.7,
                              ),
                            if (i["image"]!.contains(".svg"))
                              SvgPicture.network(
                                i["image"]!,
                                width: MediaQuery.of(context).size.width * 0.7,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ).toList(),
          )
        ],
      ),
    );
  }
}
