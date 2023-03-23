import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../common/api/sponsorship/sponsor_model.dart';
import 'default_text.dart';

class SponsorCarousel extends StatelessWidget {
  const SponsorCarousel({
    Key? key,
    required this.sponsors,
  }) : super(key: key);

  final List<Sponsor> sponsors;

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
            items: sponsors.map(
              (i) {
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () async {
                        if (!await launchUrlString(i.link ?? "")) {
                          throw Exception("Could not launch ${i.link}");
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
                            if (i.logo.contains(".png"))
                              Image.network(
                                i.logo,
                                width: MediaQuery.of(context).size.width * 0.7,
                              ),
                            if (i.logo.contains(".svg"))
                              SvgPicture.network(
                                i.logo,
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
