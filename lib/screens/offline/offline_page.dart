import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../common/bloc/user/user_bloc.dart';
import '../../styles/theme_colors.dart';
import '../../widgets/custom_icons.dart';
import '../../widgets/default_text.dart';
import '../../widgets/screen/screen.dart';

class OfflinePage extends StatelessWidget {
  const OfflinePage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context).state;
    return Screen(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    CustomIcons.signalOff,
                    color: ThemeColors.StadiumOrange,
                    size: 60.0,
                  ),
                  const SizedBox(height: 50.0),
                  DefaultText(
                    "Your connection is lost",
                    textLevel: TextLevel.h4,
                    color: ThemeColors.StadiumOrange,
                    weight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ],
              ),
              if (userBloc.userId != "") ...[
                const SizedBox(height: 30.0),
                Center(
                  child: DefaultText(
                    "Use the QR Code below to check into events",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
                // const SizedBox(height: 8.0),
                QrImage(
                  data: "HACKPSU_${userBloc.userId}",
                  size: 300.0,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
