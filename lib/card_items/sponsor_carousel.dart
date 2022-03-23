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

const ECHO_AR_URL = "https://www.echoar.xyz/";
const EECS_URL = "https://www.eecs.psu.edu/";
const HVC_URL = "https://www.linkedin.com/company/happy-valley-communications/";
const ICDS_URL = "https://www.icds.psu.edu/";
const LION_LAUNCHPAD_URL = "https://lionlaunchpad.psu.edu/";
const MICROSOFT_URL = "https://www.microsoft.com/";
const NITTANY_AI_URL = "https://nittanyai.psu.edu/";

class SponsorCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          scrollDirection: Axis.horizontal,
        ),
        items: [
          [ECHO_AR_SVG, ECHO_AR_URL],
          [EECS_SVG, EECS_URL],
          [HVC_SVG, HVC_URL],
          [ICDS_SVG, ICDS_URL],
          [LION_LAUNCHPAD_SVG, LION_LAUNCHPAD_URL],
          [MICROSOFT_SVG, MICROSOFT_URL],
          [NITTANY_AI_SVG, NITTANY_AI_URL]
        ].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return InkWell(
                  onTap: () async {
                    if (!await launch(i[1])) {
                      throw 'Could not launch $i[1]';
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
                          )),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(
                            i[0],
                            width: MediaQuery.of(context).size.width * 0.70,
                          )
                        ],
                      )));
            },
          );
        }).toList(),
      )
    ]));
  }
}
