import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomepageHeader extends StatelessWidget {
  const HomepageHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SvgPicture.asset('assets/images/mountain.svg',
                fit: BoxFit.fitWidth),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                height: 500,
                width: 500,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/images/Logo.png'),
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
