import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/user/user_bloc.dart';
import '../widgets/default_text.dart';

class UserPinCard extends StatelessWidget {
  const UserPinCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<UserBloc>(context);
    if (bloc.state.pin.isNotEmpty) {
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
              return QRScreen();
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), color: Colors.white),
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0),
          width: MediaQuery.of(context).size.width * 0.95,
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    "My PIN",
                    textLevel: TextLevel.h4,
                  ),
                  Container(height: 10.0),
                  DefaultText(
                    bloc.state.pin,
                    textLevel: TextLevel.h1,
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * .54)),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 2),
                    color: Colors.white),
                child: QrImage(
                  data: "HACKPSU_${bloc.state.pin}",
                  version: 3,
                  size: 60,
                ),
              )
            ],
          ),
        ),
      );
    }
    return _RegisterCard();
  }
}

class _RegisterCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: Colors.white),
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      width: MediaQuery.of(context).size.width * 0.95,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Column(
            children: [
              DefaultText(
                "My PIN",
                textLevel: TextLevel.h4,
              ),
              Container(
                  padding: const EdgeInsets.only(top: 5.0, left: 15.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      const url = 'https://app.hackpsu.org/register';

                      if (await canLaunch(url)) {
                        await launch(
                          url,
                          forceWebView: true,
                          enableJavaScript: true,
                          enableDomStorage: true,
                        );
                      } else {
                        throw Exception('Could not launch $url');
                      }
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
                  )),
            ],
          ),
          Container(width: 40.0),
          Flexible(
            child: DefaultText(
              "Please register to participate at the event.",
            ),
          ),
          Container(width: 15.0),
        ],
      ),
    );
  }
}

class QRScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserBloc>();
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
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
              data: "HACKPSU_${bloc.state.pin}",
              version: 3,
            ),
          ],
        ),
      ),
    );
  }
}
