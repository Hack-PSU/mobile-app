import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/default_text.dart';

const ECHO_AR_SVG = "assets/images/sponsors/EchoAR-day.svg";
const EECS_SVG = "assets/images/sponsors/EECS-day.svg";
const HVC_SVG = "assets/images/sponsors/HVC.svg";
const ICDS_SVG = "assets/images/sponsors/ICDS-day.svg";
const LION_LAUNCHPAD_SVG = "assets/images/sponsors/Lion-Launchpad.svg";
const MICROSOFT_SVG = "assets/images/sponsors/Microsoft_original.svg";
const NITTANY_AI_SVG = "assets/images/sponsors/nittanyai-day.svg";

const ECHO_AR_SVG_URL =
    "https://firebasestorage.googleapis.com/v0/b/hackpsu18.appspot.com/o/sponsorship-logos%2FEchoAR-day.svg?alt=media";
const EECS_SVG_URL =
    "https://firebasestorage.googleapis.com/v0/b/hackpsu18.appspot.com/o/sponsorship-logos%2FEECS-day.png?alt=media";
const HVC_SVG_URL =
    "https://firebasestorage.googleapis.com/v0/b/hackpsu18.appspot.com/o/sponsorship-logos%2FHVC.svg?alt=media";
const ICDS_SVG_URL =
    "https://firebasestorage.googleapis.com/v0/b/hackpsu18.appspot.com/o/sponsorship-logos%2FICDS-day.svg?alt=media";
const LION_LAUNCHPAD_SVG_URL =
    "https://firebasestorage.googleapis.com/v0/b/hackpsu18.appspot.com/o/sponsorship-logos%2FLion-Launchpad.svg?alt=media";
const MICROSOFT_SVG_URL =
    "https://firebasestorage.googleapis.com/v0/b/hackpsu18.appspot.com/o/sponsorship-logos%2FMicrosoft_original.svg?alt=media";
const NITTANY_AI_SVG_URL =
    "https://firebasestorage.googleapis.com/v0/b/hackpsu18.appspot.com/o/sponsorship-logos%2Fnittanyai-day.svg?alt=media";

const ECHO_AR_URL = "https://www.echoar.xyz/";
const EECS_URL = "https://www.eecs.psu.edu/";
const HVC_URL = "https://www.linkedin.com/company/happy-valley-communications/";
const ICDS_URL = "https://www.icds.psu.edu/";
const LION_LAUNCHPAD_URL = "https://lionlaunchpad.psu.edu/";
const MICROSOFT_URL = "https://www.microsoft.com/";
const NITTANY_AI_URL = "https://nittanyai.psu.edu/";

class SponsorCarousel extends StatelessWidget {
  const SponsorCarousel({Key key}) : super(key: key);

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
            items: [
              [ECHO_AR_SVG_URL, ECHO_AR_URL],
              [EECS_SVG_URL, EECS_URL],
              [HVC_SVG_URL, HVC_URL],
              [ICDS_SVG_URL, ICDS_URL],
              [LION_LAUNCHPAD_SVG_URL, LION_LAUNCHPAD_URL],
              [MICROSOFT_SVG_URL, MICROSOFT_URL],
              [NITTANY_AI_SVG_URL, NITTANY_AI_URL]
            ].map(
              (i) {
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () async {
                        if (!await launch(i[1])) {
                          throw Exception("Could not launch $i[1]");
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
                            if (i[0].contains("png"))
                              Image.network(
                                i[0],
                                width: MediaQuery.of(context).size.width * 0.7,
                              ),
                            if (i[0].contains("svg"))
                              SvgPicture.network(
                                i[0],
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
