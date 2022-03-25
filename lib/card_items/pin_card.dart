import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/registration.dart';
import '../widgets/default_text.dart';

class UserPinCard extends StatelessWidget {
  const UserPinCard(
    List<Registration> data, {
    Key key,
  })  : _data = data,
        super(key: key);

  final List<Registration> _data;
  @override
  Widget build(BuildContext context) {
    if (_data != null) {
      _data.sort((a, b) => (a.time).compareTo(b.time));
      try {
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
                                data:
                                    "HACKPSU_${_data.last.pin - _data.last.basePin}",
                                version: 3,
                              )
                            ],
                          )));
                });
          },
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white),
              margin: const EdgeInsets.only(top: 10),
              padding:
                  const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0),
              width: MediaQuery.of(context).size.width * 0.95,
              alignment: Alignment.centerLeft,
              child: Row(children: [
                Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      DefaultText(
                        "My PIN",
                        textLevel: TextLevel.h4,
                      ),
                      Container(height: 10.0),
                      DefaultText(
                        "${(_data.last.pin - _data.last.basePin).toString()}",
                        textLevel: TextLevel.h1,
                      )
                    ])),
                Container(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * .52),
                    child: QrImage(
                      data: "HACKPSU_${_data.last.pin - _data.last.basePin}",
                      version: 3,
                      size: 80,
                    ))
              ])),
        );
      } on StateError catch (e) {
        return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), color: Colors.white),
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            width: MediaQuery.of(context).size.width * 0.95,
            alignment: Alignment.centerLeft,
            child: Row(children: [
              Column(children: [
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
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF6A85B9))),
                      child: DefaultText(
                        "Register",
                        textLevel: TextLevel.body2,
                        color: Colors.white,
                      ),
                    )),
              ]),
              Container(width: 40.0),
              Flexible(
                  child: DefaultText(
                      "Please register to participate at the event.")),
              Container(width: 15.0),
            ]));
      } catch (e) {
        return DefaultText(
          "Error getting PIN",
        );
      }
    }
    return const Text(
      "Error getting PIN",
    );
    // else if (snapshot.hasError) {
    //   return Text('${snapshot.error.toString()}');
    // }
    // return const CircularProgressIndicator();
  }
}
