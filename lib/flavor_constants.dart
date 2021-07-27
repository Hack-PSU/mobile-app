import 'package:flutter/foundation.dart';

import './secrets.dart';

enum Flavor {
  DEV,
  PROD,
}

class Config {
  static Flavor appFlavor;

  static String get baseUrl {
    return getConstantByFlavor(
      prodConst: 'https://api.hackpsu.org/v2',
      devConst: 'http://staging.hackpsu18.appspot.com/v2',
    );
  }

  static String get gitHubClientId {
    return getConstantByFlavor(
      prodConst: Secrets.gitHubClientIdProd,
      devConst: Secrets.gitHubClientIdDev,
    );
  }

  static String get gitHubClientSecret {
    return getConstantByFlavor(
      prodConst: Secrets.gitHubClientSecretProd,
      devConst: Secrets.gitHubClientSecretDev,
    );
  }

  static String get gitHubCallbackUrl {
    return getConstantByFlavor(
      prodConst: Secrets.gitHubCallbackUrlProd,
      devConst: Secrets.gitHubCallbackUrlDev,
    );
  }

  static String getConstantByFlavor(
      {@required String prodConst, @required String devConst}) {
    switch (appFlavor) {
      case Flavor.DEV:
        return devConst;
      case Flavor.PROD:
      default:
        return prodConst;
    }
  }
}
