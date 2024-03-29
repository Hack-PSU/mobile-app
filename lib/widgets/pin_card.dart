import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../common/bloc/user/user_bloc.dart';
import '../common/bloc/user/user_state.dart';
import 'default_text.dart';

class UserPinCard extends StatelessWidget {
  const UserPinCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      buildWhen: (previous, current) =>
          previous.profile?.registration != current.profile?.registration,
      builder: (context, state) {
        if (state.profile?.registration == null) {
          return const _RegisterCard();
        }
        return InkWell(
          onTap: () {
            showGeneralDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel:
                  MaterialLocalizations.of(context).modalBarrierDismissLabel,
              barrierColor: Colors.black45,
              transitionDuration: const Duration(milliseconds: 200),
              pageBuilder:
                  (BuildContext buildContext, animation, secondaryAnimation) {
                return const QRScreen();
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20.0,
            ),
            width: MediaQuery.of(context).size.width * 0.95,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultText(
                        "My QR Code",
                        textLevel: TextLevel.h3,
                        fontSize: 30.0,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 2),
                    color: Colors.white,
                  ),
                  child: QrImage(
                    data: "HACKPSU_${state.userId}",
                    version: 3,
                    size: 60,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RegisterCard extends StatelessWidget {
  const _RegisterCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      width: MediaQuery.of(context).size.width * 0.95,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 5.0, left: 15.0),
            child: ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pushNamed("/registration");
                // const url = 'https://app.hackpsu.org/register';
                //
                // if (await canLaunchUrlString(url)) {
                //   await launchUrlString(
                //     url,
                //     mode: LaunchMode.inAppWebView,
                //   );
                // } else {
                //   throw Exception('Could not launch $url');
                // }
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
                backgroundColor: MaterialStateProperty.all(
                  const Color(0xFF6A85B9),
                ),
              ),
              child: DefaultText(
                "Register",
                textLevel: TextLevel.body2,
                color: Colors.white,
              ),
            ),
          ),
          Container(width: 40.0),
          Flexible(
            child: DefaultText(
              "Please register to participate at the event.",
              maxLines: 3,
            ),
          ),
          Container(width: 15.0),
        ],
      ),
    );
  }
}

class QRScreen extends StatelessWidget {
  const QRScreen({
    Key? key,
    this.disableGesture = false,
  }) : super(key: key);

  final bool disableGesture;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserBloc>();
    return GestureDetector(
      onTap: () {
        if (disableGesture == false) {
          Navigator.of(context).pop();
        }
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QrImage(
              data: "HACKPSU_${bloc.state.userId}",
              version: 3,
            ),
          ],
        ),
      ),
    );
  }
}
