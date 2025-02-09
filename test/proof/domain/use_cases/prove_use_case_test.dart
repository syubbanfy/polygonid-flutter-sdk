import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/prove_use_case.dart';

import '../../../common/common_mocks.dart';
import '../../../common/proof_mocks.dart';
import 'prove_use_case_test.mocks.dart';

MockProofRepository proofRepository = MockProofRepository();
ProveUseCase useCase = ProveUseCase(proofRepository);

// Data
ProveParam param = ProveParam(CommonMocks.aBytes, ProofMocks.circuitData);

@GenerateMocks([ProofRepository])
void main() {
  setUp(() {
    when(proofRepository.calculateWitness(any, any))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.aBytes));
    when(proofRepository.prove(any, any))
        .thenAnswer((realInvocation) => Future.value(ProofMocks.jwzProof));
  });

  test(
    'Given a param, when I call execute, then I expect a JWZProof to be returned',
    () async {
      // When
      expect(await useCase.execute(param: param), ProofMocks.jwzProof);

      // Then
      var capturedWitness =
          verify(proofRepository.calculateWitness(captureAny, captureAny))
              .captured;
      expect(capturedWitness[0], param.circuitData);
      expect(capturedWitness[1], param.inputs);

      var capturedProve =
          verify(proofRepository.prove(captureAny, captureAny)).captured;
      expect(capturedProve[0], param.circuitData);
      expect(capturedProve[1], CommonMocks.aBytes);
    },
  );

  test(
    'Given a param, when I call execute and an error occurred, then I expect an exception to be thrown',
    () async {
      // Given
      when(proofRepository.calculateWitness(any, any))
          .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

      // When
      await expectLater(
          useCase.execute(param: param), throwsA(CommonMocks.exception));

      // Then
      var capturedWitness =
          verify(proofRepository.calculateWitness(captureAny, captureAny))
              .captured;
      expect(capturedWitness[0], param.circuitData);
      expect(capturedWitness[1], param.inputs);

      verifyNever(proofRepository.prove(captureAny, captureAny));
    },
  );
}
