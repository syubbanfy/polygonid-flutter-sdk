import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';

class PolygonIdSdkIdentityDataSource {
  final PolygonIdSdk _polygonIdSdk;

  PolygonIdSdkIdentityDataSource(this._polygonIdSdk);

  ///
  Future<String> createIdentity() {
    return _polygonIdSdk.identity.createIdentity();
  }

  ///
  Future<String?> getIdentifier() {
    return _polygonIdSdk.identity.getCurrentIdentifier();
  }
}