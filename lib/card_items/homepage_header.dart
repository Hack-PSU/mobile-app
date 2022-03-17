import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/default_text.dart';

class HomepageHeader extends StatelessWidget {
  const HomepageHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: 487 / 560,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          alignment: FractionalOffset.topCenter,
                          image: AssetImage('assets/images/background.jpg'),
                        )
                    ),
                  ),
              ),
          ),
          SvgPicture.asset('assets/images/mountain2.svg',
           width: MediaQuery.of(context).size.width,
          ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: double.infinity,
                  height: 0,
                  color: Colors.black,
                  child: Text("Hello!")
                ),
              ),
            ),
          Column(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DefaultText("\n2 Hours left!", textLevel: TextLevel.h4, color: Colors.white, fontSize: 40,)
            ],
          )
          ],
        ),
      );

Column(
children: [
  Stack(
    alignment: Alignment.center,
    children: [
      Image(
        image: const AssetImage('assets/images/background.jpg'),
      ),
      Column(
        children: [
          Row(children: [
            Container(height: 400, width: 2000, color: Colors.blue),
          ]),
          Row(children: [
            SvgPicture.asset('assets/images/mountain2.svg',
                fit: BoxFit.fitHeight),
          ])
        ],
      ),
      Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Container(
            height: 500,
            width: 500,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              color: Colors.white12,
              image: DecorationImage(
                image: AssetImage('assets/images/Logo.png'),
              ),
            ),
          ),
        ),
      )
    ],
  ),
],
);
  }
}
