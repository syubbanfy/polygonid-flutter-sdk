import 'package:polygonid_flutter_sdk/domain/credential/entities/claim_entity.dart';

import '../../common/domain_logger.dart';
import '../../common/use_case.dart';
import '../../identity/repositories/credential_repository.dart';

class UpdateClaimParam {
  final String id;
  final String? issuer;
  final String? identifier;
  final ClaimState? state;
  final String? expiration;
  final String? type;
  final Map<String, dynamic>? data;

  UpdateClaimParam(this.id,
      [this.issuer,
      this.identifier,
      this.state,
      this.expiration,
      this.type,
      this.data]);
}

class UpdateClaimUseCase extends FutureUseCase<UpdateClaimParam, ClaimEntity> {
  final CredentialRepository _credentialRepository;

  UpdateClaimUseCase(this._credentialRepository);

  @override
  Future<ClaimEntity> execute({required UpdateClaimParam param}) async {
    /// Get the [ClaimEntity] associated with the [param.id]
    /// If found, we update the info with the [param]
    /// then update in storage
    return _credentialRepository
        .getClaim(id: param.id)
        .then((claim) => ClaimEntity(
            id: param.id,
            issuer: param.issuer ?? claim.issuer,
            identifier: param.identifier ?? claim.identifier,
            state: param.state ?? claim.state,
            type: param.type ?? claim.type,
            data: param.data ?? claim.data))
        .then((updated) => _credentialRepository.updateClaim(claim: updated))
        .then((claim) {
      logger().i(
          "[UpdateClaimUseCase] Claim with id ${param.id} has been updated: $claim");
      return claim;
    }).catchError((error) {
      logger().e("[UpdateClaimUseCase] Error: $error");
      throw error;
    });
  }
}
