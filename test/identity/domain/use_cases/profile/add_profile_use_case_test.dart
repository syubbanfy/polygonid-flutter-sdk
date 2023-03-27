import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/update_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/add_profile_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/create_profiles_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/smt/create_identity_state_use_case.dart';

import '../../../../common/common_mocks.dart';
import '../../../../common/identity_mocks.dart';
import 'add_profile_use_case_test.mocks.dart';

// Data
var exception = Exception();
var param = AddProfileParam(
  profileNonce: 2,
  privateKey: CommonMocks.privateKey,
);

var existingParam = AddProfileParam(
  profileNonce: CommonMocks.nonce,
  privateKey: CommonMocks.privateKey,
);

var negativeParam = AddProfileParam(
  profileNonce: CommonMocks.negativeNonce,
  privateKey: CommonMocks.privateKey,
);

var genesisParam = AddProfileParam(
  profileNonce: CommonMocks.genesisNonce,
  privateKey: CommonMocks.privateKey,
);

// Dependencies
MockGetIdentityUseCase getIdentityUseCase = MockGetIdentityUseCase();
MockUpdateIdentityUseCase updateIdentityUseCase = MockUpdateIdentityUseCase();
MockCreateProfilesUseCase createProfilesUseCase = MockCreateProfilesUseCase();
MockCreateIdentityStateUseCase createIdentityStateUseCase =
    MockCreateIdentityStateUseCase();
MockGetCurrentEnvDidIdentifierUseCase getCurrentEnvDidIdentifierUseCase =
    MockGetCurrentEnvDidIdentifierUseCase();

// Tested instance
AddProfileUseCase useCase = AddProfileUseCase(
  getIdentityUseCase,
  updateIdentityUseCase,
  getCurrentEnvDidIdentifierUseCase,
  createProfilesUseCase,
  createIdentityStateUseCase,
);

@GenerateMocks([
  GetIdentityUseCase,
  UpdateIdentityUseCase,
  GetCurrentEnvDidIdentifierUseCase,
  CreateProfilesUseCase,
  CreateIdentityStateUseCase,
])
void main() {
  setUp(() {
    reset(getIdentityUseCase);
    reset(updateIdentityUseCase);
    reset(createProfilesUseCase);
    reset(createIdentityStateUseCase);
    reset(getCurrentEnvDidIdentifierUseCase);

    // Given
    when(getCurrentEnvDidIdentifierUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.did));
    when(getIdentityUseCase.execute(param: anyNamed('param'))).thenAnswer(
        (realInvocation) => Future.value(IdentityMocks.privateIdentity));
    when(createProfilesUseCase.execute(param: anyNamed('param'))).thenAnswer(
        (realInvocation) => Future.value(
            {param.profileNonce: CommonMocks.did + "${param.profileNonce}"}));
    when(createIdentityStateUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value());
    when(updateIdentityUseCase.execute(param: anyNamed('param'))).thenAnswer(
        (realInvocation) => Future.value(IdentityMocks.privateIdentity));
  });

  test(
    'Given a param, when I call execute, then I expect the process to complete',
    () async {
      // When
      await expectLater(useCase.execute(param: param), completes);

      // Then
      expect(
          verify(getCurrentEnvDidIdentifierUseCase.execute(
                  param: captureAnyNamed('param')))
              .captured
              .first
              .privateKey,
          param.privateKey);

      var getIdentityCapture =
          verify(getIdentityUseCase.execute(param: captureAnyNamed('param')))
              .captured
              .first;
      expect(getIdentityCapture.genesisDid, CommonMocks.did);

      var capturedUpdate =
          verify(updateIdentityUseCase.execute(param: captureAnyNamed('param')))
              .captured
              .first;
      expect(capturedUpdate.privateKey, CommonMocks.privateKey);
      expect(capturedUpdate.profiles.first, 0);
    },
  );

  test(
      "Given a param and with an associated profile, when I call execute, then I expect an ProfileAlreadyExistsException to be thrown",
      () async {
    // Given
    when(getIdentityUseCase.execute(param: anyNamed('param'))).thenAnswer(
        (realInvocation) => Future.value(IdentityMocks.privateIdentity));

    // When
    await useCase.execute(param: existingParam).catchError((error) {
      expect(error, isA<ProfileAlreadyExistsException>());
      expect(error.genesisDid, IdentityMocks.identity.did);
      expect(error.profileNonce,
          existingParam.profileNonce); //IdentityMocks.identity.profiles);
    });

    // Then
    var captureGetIdentity =
        verify(getIdentityUseCase.execute(param: captureAnyNamed('param')))
            .captured
            .first;
    expect(captureGetIdentity.genesisDid, CommonMocks.did);
    expect(captureGetIdentity.privateKey, CommonMocks.privateKey);

    verifyNever(updateIdentityUseCase.execute(param: captureAnyNamed('param')));
  });

  test(
      "Given a param and with an negative profile nonce, when I call execute, then I expect an InvalidProfileException to be thrown",
      () async {
    // Given

    // When
    await useCase
        .execute(param: negativeParam)
        .then((_) => null)
        .catchError((error) {
      expect(error, isA<InvalidProfileException>());
      expect(error.error, IdentityMocks.profileNegativeError);
      expect(error.profileNonce,
          negativeParam.profileNonce); //IdentityMocks.identity.profiles);
    });

    // Then
    verifyNever(getIdentityUseCase.execute(param: captureAnyNamed('param')));

    verifyNever(updateIdentityUseCase.execute(param: captureAnyNamed('param')));
  });

  test(
      "Given a param and with an profile nonce of 0, when I call execute, then I expect an InvalidProfileException to be thrown",
      () async {
    // Given

    // When
    await useCase
        .execute(param: genesisParam)
        .then((_) => null)
        .catchError((error) {
      expect(error, isA<InvalidProfileException>());
      expect(error.error, IdentityMocks.profileGenesisError);
      expect(error.profileNonce,
          genesisParam.profileNonce); //IdentityMocks.identity.profiles);
    });

    // Then
    verifyNever(getIdentityUseCase.execute(param: captureAnyNamed('param')));

    verifyNever(updateIdentityUseCase.execute(param: captureAnyNamed('param')));
  });

  test(
      "Given a param, when I call execute and an error occurred, then I expect an exception to be thrown",
      () async {
    // Given
    when(getIdentityUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.error(exception));

    // When
    await expectLater(useCase.execute(param: param), throwsA(exception));

    // Then
    var captureGetIdentity =
        verify(getIdentityUseCase.execute(param: captureAnyNamed('param')))
            .captured
            .first;
    expect(captureGetIdentity.genesisDid, CommonMocks.did);
    expect(captureGetIdentity.privateKey, CommonMocks.privateKey);

    verifyNever(updateIdentityUseCase.execute(param: captureAnyNamed('param')));
  });
}
