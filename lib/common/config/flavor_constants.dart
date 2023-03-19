import '../../secrets.dart';

enum Flavor {
  DEV,
  PROD,
}

class Config {
  static Flavor appFlavor = Flavor.DEV;

  static String get fcmUrl =>
      'https://us-central1-hackpsu18.cloudfunctions.net';

  static String get baseUrl {
    return getConstantByFlavor(
      prodConst: 'https://api.hackpsu.org/v2',
      devConst: 'https://apiv3-staging-apgi25sgea-uc.a.run.app',
    );
  }

  // static String get wsUrl => 'https://ws.hackpsu.org';
  static String get wsUrl =>
      'https://apiv3-staging-apgi25sgea-uc.a.run.app/socket';

  static String get storageBucket {
    return getConstantByFlavor(
      prodConst: "gs://hackpsu18.appspot.com",
      devConst: "gs://hackpsu18.appspot.com",
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

  static String getConstantByFlavor({
    required String prodConst,
    required String devConst,
  }) {
    switch (appFlavor) {
      case Flavor.DEV:
        return devConst;
      case Flavor.PROD:
        return prodConst;
    }
  }
}
