import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:archive/archive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/jwz/jwz_proof.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/cancel_download_circuits_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/circuits_files_exist_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/download_circuits_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/generate_proof_use_case.dart';

import 'package:polygonid_flutter_sdk/common/domain/tuples.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/jwz_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/jwz_sd_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/proof/infrastructure/proof_generation_stream_manager.dart';

abstract class PolygonIdSdkProof {
  Future<JWZProofEntity> prove(
      {required String genesisDid,
      required BigInt profileNonce,
      required BigInt claimSubjectProfileNonce,
      required ClaimEntity claim,
      required CircuitDataEntity circuitData,
      required ProofScopeRequest request,
      String? privateKey,
      String? challenge});

  Stream<DownloadInfo> get initCircuitsDownloadAndGetInfoStream;

  Future<bool> isAlreadyDownloadedCircuitsFromServer();

  Stream<String> proofGenerationStepsStream();

  Future<void> cancelDownloadCircuits();
}

@injectable
class Proof implements PolygonIdSdkProof {
  final GenerateProofUseCase generateProofUseCase;
  final DownloadCircuitsUseCase _downloadCircuitsUseCase;
  final CircuitsFilesExistUseCase _circuitsFilesExistUseCase;
  final ProofGenerationStepsStreamManager _proofGenerationStepsStreamManager;
  final CancelDownloadCircuitsUseCase _cancelDownloadCircuitsUseCase;

  Proof(
    this.generateProofUseCase,
    this._downloadCircuitsUseCase,
    this._circuitsFilesExistUseCase,
    this._proofGenerationStepsStreamManager,
    this._cancelDownloadCircuitsUseCase,
  );

  @override
  Future<JWZProofEntity> prove(
      {required String genesisDid,
      required BigInt profileNonce,
      required BigInt claimSubjectProfileNonce,
      required ClaimEntity claim,
      required CircuitDataEntity circuitData,
      required ProofScopeRequest request,
      String? privateKey,
      String? challenge}) {
    return generateProofUseCase.execute(
        param: GenerateProofParam(
            genesisDid,
            profileNonce,
            claimSubjectProfileNonce,
            claim,
            request,
            circuitData,
            privateKey,
            challenge));
  }

  ///
  @override
  Future<bool> isAlreadyDownloadedCircuitsFromServer() async {
    return _circuitsFilesExistUseCase.execute();
  }

  ///
  @override
  Stream<DownloadInfo> get initCircuitsDownloadAndGetInfoStream {
    return _downloadCircuitsUseCase.execute();
  }

  /// Returns a [Stream] of [String] of proof generation steps
  @override
  Stream<String> proofGenerationStepsStream() {
    return _proofGenerationStepsStreamManager.proofGenerationStepsStream;
  }

  /// Cancel the download of circuits
  @override
  Future<void> cancelDownloadCircuits() async {
    return _cancelDownloadCircuitsUseCase.execute();
  }
}
