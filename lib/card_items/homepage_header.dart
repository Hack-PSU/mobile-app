import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../styles/theme_colors.dart';
import '../widgets/default_text.dart';
import 'countdown_timer_card.dart';

class HomepageHeader extends StatelessWidget {
  const HomepageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        AspectRatio(
          aspectRatio: 487 / 560,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                alignment: FractionalOffset.topCenter,
                image: AssetImage('assets/images/background.jpg'),
              ),
            ),
          ),
        ),
        SvgPicture.asset(
          'assets/images/mountain2.svg',
          width: MediaQuery.of(context).size.width,
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CountdownTimerCard(),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await launchUrlString(
                            "http://devpost.hackpsu.org",
                          );
                          // Respond to button press
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: ThemeColors.StadiumOrange,
                            ),
                            Container(
                              width: 10,
                            ),
                            DefaultText(
                              "SUBMIT",
                              textLevel: TextLevel.button,
                              color: ThemeColors.StadiumOrange,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await launchUrlString(
                            "http://discord.hackpsu.org",
                          );
                          // Respond to button press
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xFF6A85B9),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.discord),
                            Container(
                              width: 10,
                            ),
                            DefaultText(
                              "DISCORD",
                              textLevel: TextLevel.button,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
