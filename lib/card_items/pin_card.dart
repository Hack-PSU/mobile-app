import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../models/registration.dart';

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
                  barrierLabel: MaterialLocalizations.of(context)
                      .modalBarrierDismissLabel,
                  barrierColor: Colors.black45,
                  transitionDuration: const Duration(milliseconds: 200),
                  pageBuilder: (BuildContext buildContext, animation,
                      secondaryAnimation) {
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
            child: Text(
              "Your Pin: ${(_data.last.pin - _data.last.basePin).toString()}",
            ));
      } on StateError catch (e) {
        return const Text(
          "No Registration PIN because no registration data was found",
        );
      } catch (e) {
        return const Text(
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
