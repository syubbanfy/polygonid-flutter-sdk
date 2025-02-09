import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/exceptions/credential_exceptions.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claim_revocation_status_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/update_claim_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_credential_repository.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/is_proof_circuit_supported_use_case.dart';

import 'get_proof_requests_use_case.dart';

class GetIden3commClaimsParam {
  final Iden3MessageEntity message;
  final String genesisDid;
  final BigInt profileNonce;
  final String privateKey;

  GetIden3commClaimsParam(
      {required this.message,
      required this.genesisDid,
      required this.profileNonce,
      required this.privateKey});
}

class GetIden3commClaimsUseCase
    extends FutureUseCase<GetIden3commClaimsParam, List<ClaimEntity?>> {
  final Iden3commCredentialRepository _iden3commCredentialRepository;
  final GetClaimsUseCase _getClaimsUseCase;
  final GetClaimRevocationStatusUseCase _getClaimRevocationStatusUseCase;
  final UpdateClaimUseCase _updateClaimUseCase;
  final IsProofCircuitSupportedUseCase _isProofCircuitSupported;
  final GetProofRequestsUseCase _getProofRequestsUseCase;

  GetIden3commClaimsUseCase(
    this._iden3commCredentialRepository,
    this._getClaimsUseCase,
    this._getClaimRevocationStatusUseCase,
    this._updateClaimUseCase,
    this._isProofCircuitSupported,
    this._getProofRequestsUseCase,
  );

  @override
  Future<List<ClaimEntity?>> execute(
      {required GetIden3commClaimsParam param}) async {
    List<ClaimEntity?> claims = [];

    List<ProofRequestEntity> requests =
        await _getProofRequestsUseCase.execute(param: param.message);

    /// We got [ProofRequestEntity], let's find the associated [ClaimEntity]
    for (ProofRequestEntity request in requests) {
      if (await _isProofCircuitSupported.execute(
          param: request.scope.circuitId)) {
        // Claims
        claims.add(
          await _iden3commCredentialRepository
              .getFilters(request: request)
              .then((filters) => _getClaimsUseCase.execute(
                      param: GetClaimsParam(
                    filters: filters,
                    genesisDid: param.genesisDid,
                    profileNonce: param.profileNonce,
                    privateKey: param.privateKey,
                  )))
              .then(
            (claims) async {
              if (claims.isEmpty) {
                return null;
              }
              if (request.scope.query.skipClaimRevocationCheck == null ||
                  request.scope.query.skipClaimRevocationCheck == false) {
                for (int i = 0; i < claims.length; i++) {
                  Map<String, dynamic> revStatus =
                      await _getClaimRevocationStatusUseCase
                          .execute(param: claims[i])
                          .catchError((_) => <String, dynamic>{});

                  /// FIXME: define an entity for revocation and use it in repo impl
                  if (revStatus.isNotEmpty &&
                      revStatus["mtp"] != null &&
                      revStatus["mtp"]["existence"] != null &&
                      revStatus["mtp"]["existence"] == true) {
                    claims[i] = await _updateClaimUseCase.execute(
                        param: UpdateClaimParam(
                            id: claims[i].id,
                            state: ClaimState.revoked,
                            genesisDid: param.genesisDid,
                            privateKey: param.privateKey));
                  }
                }
                return claims
                    .where((claim) => claim.state != ClaimState.revoked)
                    .toList()
                    .first;
              } else {
                return claims.first;
              }
            },
          ),
        );
      }
    }

    /// If we have requests but didn't get any proofs, we throw
    /// as it could be we didn't find any associated [ClaimEntity]
    if (requests.isNotEmpty && claims.isEmpty ||
        claims.length != requests.length) {
      throw CredentialsNotFoundException(requests);
    }

    return claims;
  }
}
