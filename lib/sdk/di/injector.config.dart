// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sembast/sembast.dart' as _i9;

import '../../credential/data/credential_repository_impl.dart' as _i46;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i28;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i41;
import '../../credential/data/mappers/claim_mapper.dart' as _i40;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i6;
import '../../credential/data/mappers/credential_request_mapper.dart' as _i8;
import '../../credential/data/mappers/filter_mapper.dart' as _i10;
import '../../credential/data/mappers/filters_mapper.dart' as _i11;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i13;
import '../../credential/data/mappers/rhs_node_mapper.dart' as _i45;
import '../../credential/data/mappers/rhs_node_type_mapper.dart' as _i30;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i48;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i74;
import '../../credential/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i49;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i50;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i51;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i56;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i57;
import '../../iden3comm/data/data_sources/proof_scope_data_source.dart' as _i25;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i29;
import '../../iden3comm/data/mappers/iden3_message_mapper.dart' as _i42;
import '../../iden3comm/data/mappers/iden3_message_type_mapper.dart' as _i15;
import '../../iden3comm/data/mappers/proof_response_mapper.dart' as _i24;
import '../../iden3comm/data/mappers/schema_info_mapper.dart' as _i33;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i52;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i62;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i73;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i68;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i71;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i17;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i18;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i43;
import '../../identity/data/data_sources/storage_key_value_data_source.dart'
    as _i44;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i34;
import '../../identity/data/mappers/auth_request_mapper.dart' as _i3;
import '../../identity/data/mappers/auth_response_mapper.dart' as _i4;
import '../../identity/data/mappers/hex_mapper.dart' as _i12;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i16;
import '../../identity/data/mappers/private_key_mapper.dart' as _i23;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i53;
import '../../identity/data/repositories/smt_memory_storage_repository_impl.dart'
    as _i31;
import '../../identity/domain/repositories/identity_repository.dart' as _i63;
import '../../identity/domain/repositories/smt_storage_repository.dart' as _i21;
import '../../identity/domain/use_cases/create_identity_use_case.dart' as _i67;
import '../../identity/domain/use_cases/get_current_identifier_use_case.dart'
    as _i69;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i70;
import '../../identity/domain/use_cases/remove_current_identity_use_case.dart'
    as _i65;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i66;
import '../../identity/libs/bjj/bjj.dart' as _i5;
import '../../identity/libs/iden3core/iden3core.dart' as _i14;
import '../../identity/libs/smt/hash.dart' as _i32;
import '../../identity/libs/smt/merkletree.dart' as _i20;
import '../../identity/libs/smt/node.dart' as _i22;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i39;
import '../../proof_generation/data/data_sources/local_files_data_source.dart'
    as _i19;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i27;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i36;
import '../../proof_generation/data/repositories/proof_repository_impl.dart'
    as _i47;
import '../../proof_generation/domain/repositories/proof_repository.dart'
    as _i54;
import '../../proof_generation/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i58;
import '../../proof_generation/domain/use_cases/generate_proof_use_case.dart'
    as _i59;
import '../../proof_generation/domain/use_cases/get_atomic_query_inputs_use_case.dart'
    as _i60;
import '../../proof_generation/domain/use_cases/get_witness_use_case.dart'
    as _i61;
import '../../proof_generation/domain/use_cases/prove_use_case.dart' as _i55;
import '../../proof_generation/libs/prover/prover.dart' as _i26;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i35;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i37;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i38;
import '../credential_wallet.dart' as _i76;
import '../iden3comm.dart' as _i75;
import '../identity_wallet.dart' as _i72;
import '../proof_generation.dart' as _i64;
import 'injector.dart' as _i77; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initSDKGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final networkModule = _$NetworkModule();
  final databaseModule = _$DatabaseModule();
  final repositoriesModule = _$RepositoriesModule();
  gh.factory<_i3.AuthRequestMapper>(() => _i3.AuthRequestMapper());
  gh.factory<_i4.AuthResponseMapper>(() => _i4.AuthResponseMapper());
  gh.factory<_i5.BabyjubjubLib>(() => _i5.BabyjubjubLib());
  gh.factory<_i6.ClaimStateMapper>(() => _i6.ClaimStateMapper());
  gh.factory<_i7.Client>(() => networkModule.client);
  gh.factory<_i8.CredentialRequestMapper>(() => _i8.CredentialRequestMapper());
  gh.lazySingletonAsync<_i9.Database>(() => databaseModule.database());
  gh.factory<_i10.FilterMapper>(() => _i10.FilterMapper());
  gh.factory<_i11.FiltersMapper>(
      () => _i11.FiltersMapper(get<_i10.FilterMapper>()));
  gh.factory<_i12.HexMapper>(() => _i12.HexMapper());
  gh.factory<_i13.IdFilterMapper>(() => _i13.IdFilterMapper());
  gh.factory<_i14.Iden3CoreLib>(() => _i14.Iden3CoreLib());
  gh.factory<_i15.Iden3MessageTypeMapper>(() => _i15.Iden3MessageTypeMapper());
  gh.factory<_i16.IdentityDTOMapper>(() => _i16.IdentityDTOMapper());
  gh.factory<_i17.JWZIsolatesWrapper>(() => _i17.JWZIsolatesWrapper());
  gh.factory<_i18.LibIdentityDataSource>(
      () => _i18.LibIdentityDataSource(get<_i14.Iden3CoreLib>()));
  gh.factory<_i19.LocalFilesDataSource>(() => _i19.LocalFilesDataSource());
  gh.factory<_i20.MerkleTree>(() => _i20.MerkleTree(
      get<_i14.Iden3CoreLib>(), get<_i21.SMTStorageRepository>(), get<int>()));
  gh.factory<_i22.Node>(
      () => _i22.Node(get<_i22.NodeType>(), get<_i14.Iden3CoreLib>()));
  gh.factory<_i23.PrivateKeyMapper>(() => _i23.PrivateKeyMapper());
  gh.factory<_i24.ProofResponseMapper>(() => _i24.ProofResponseMapper());
  gh.factory<_i25.ProofScopeDataSource>(() => _i25.ProofScopeDataSource());
  gh.factory<_i26.ProverLib>(() => _i26.ProverLib());
  gh.factory<_i27.ProverLibWrapper>(() => _i27.ProverLibWrapper());
  gh.factory<_i28.RemoteClaimDataSource>(
      () => _i28.RemoteClaimDataSource(get<_i7.Client>()));
  gh.factory<_i29.RemoteIden3commDataSource>(
      () => _i29.RemoteIden3commDataSource(get<_i7.Client>()));
  gh.factory<_i30.RhsNodeTypeMapper>(() => _i30.RhsNodeTypeMapper());
  gh.factory<_i31.SMTMemoryStorageRepositoryImpl>(() =>
      _i31.SMTMemoryStorageRepositoryImpl(
          get<_i32.Hash>(), get<Map<_i32.Hash, _i22.Node>>()));
  gh.factory<_i33.SchemaInfoMapper>(() => _i33.SchemaInfoMapper());
  gh.factory<_i9.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.identityStore,
      instanceName: 'identityStore');
  gh.factory<_i9.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.claimStore,
      instanceName: 'claimStore');
  gh.factory<_i9.StoreRef<String, dynamic>>(() => databaseModule.keyValueStore,
      instanceName: 'keyValueStore');
  gh.factory<_i34.WalletLibWrapper>(() => _i34.WalletLibWrapper());
  gh.factory<_i35.WitnessAuthLib>(() => _i35.WitnessAuthLib());
  gh.factory<_i36.WitnessIsolatesWrapper>(() => _i36.WitnessIsolatesWrapper());
  gh.factory<_i37.WitnessMtpLib>(() => _i37.WitnessMtpLib());
  gh.factory<_i38.WitnessSigLib>(() => _i38.WitnessSigLib());
  gh.factory<_i39.AtomicQueryInputsWrapper>(
      () => _i39.AtomicQueryInputsWrapper(get<_i14.Iden3CoreLib>()));
  gh.factory<_i40.ClaimMapper>(
      () => _i40.ClaimMapper(get<_i6.ClaimStateMapper>()));
  gh.factory<_i41.ClaimStoreRefWrapper>(() => _i41.ClaimStoreRefWrapper(
      get<_i9.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i42.Iden3MessageMapper>(
      () => _i42.Iden3MessageMapper(get<_i15.Iden3MessageTypeMapper>()));
  gh.factory<_i43.IdentityStoreRefWrapper>(() => _i43.IdentityStoreRefWrapper(
      get<_i9.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i44.KeyValueStoreRefWrapper>(() => _i44.KeyValueStoreRefWrapper(
      get<_i9.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factory<_i27.ProverLibDataSource>(
      () => _i27.ProverLibDataSource(get<_i27.ProverLibWrapper>()));
  gh.factory<_i45.RhsNodeMapper>(
      () => _i45.RhsNodeMapper(get<_i30.RhsNodeTypeMapper>()));
  gh.factoryAsync<_i41.StorageClaimDataSource>(() async =>
      _i41.StorageClaimDataSource(await get.getAsync<_i9.Database>(),
          get<_i41.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i44.StorageKeyValueDataSource>(() async =>
      _i44.StorageKeyValueDataSource(await get.getAsync<_i9.Database>(),
          get<_i44.KeyValueStoreRefWrapper>()));
  gh.factory<_i34.WalletDataSource>(
      () => _i34.WalletDataSource(get<_i34.WalletLibWrapper>()));
  gh.factory<_i36.WitnessDataSource>(
      () => _i36.WitnessDataSource(get<_i36.WitnessIsolatesWrapper>()));
  gh.factory<_i39.AtomicQueryInputsDataSource>(() =>
      _i39.AtomicQueryInputsDataSource(get<_i39.AtomicQueryInputsWrapper>()));
  gh.factoryAsync<_i46.CredentialRepositoryImpl>(() async =>
      _i46.CredentialRepositoryImpl(
          get<_i28.RemoteClaimDataSource>(),
          await get.getAsync<_i41.StorageClaimDataSource>(),
          get<_i8.CredentialRequestMapper>(),
          get<_i40.ClaimMapper>(),
          get<_i11.FiltersMapper>(),
          get<_i13.IdFilterMapper>(),
          get<_i45.RhsNodeMapper>()));
  gh.factory<_i17.JWZDataSource>(() => _i17.JWZDataSource(
      get<_i5.BabyjubjubLib>(),
      get<_i34.WalletDataSource>(),
      get<_i17.JWZIsolatesWrapper>()));
  gh.factory<_i47.ProofRepositoryImpl>(() => _i47.ProofRepositoryImpl(
      get<_i36.WitnessDataSource>(),
      get<_i27.ProverLibDataSource>(),
      get<_i39.AtomicQueryInputsDataSource>(),
      get<_i19.LocalFilesDataSource>()));
  gh.factoryAsync<_i43.StorageIdentityDataSource>(() async =>
      _i43.StorageIdentityDataSource(
          await get.getAsync<_i9.Database>(),
          get<_i43.IdentityStoreRefWrapper>(),
          await get.getAsync<_i44.StorageKeyValueDataSource>()));
  gh.factoryAsync<_i48.CredentialRepository>(() async =>
      repositoriesModule.credentialRepository(
          await get.getAsync<_i46.CredentialRepositoryImpl>()));
  gh.factoryAsync<_i49.FetchIdentityStateUseCase>(() async =>
      _i49.FetchIdentityStateUseCase(
          await get.getAsync<_i48.CredentialRepository>()));
  gh.factoryAsync<_i50.GetClaimsUseCase>(() async =>
      _i50.GetClaimsUseCase(await get.getAsync<_i48.CredentialRepository>()));
  gh.factoryAsync<_i51.GetVocabsUseCase>(() async =>
      _i51.GetVocabsUseCase(await get.getAsync<_i48.CredentialRepository>()));
  gh.factoryAsync<_i52.Iden3commRepositoryImpl>(() async =>
      _i52.Iden3commRepositoryImpl(
          get<_i29.RemoteIden3commDataSource>(),
          get<_i17.JWZDataSource>(),
          get<_i12.HexMapper>(),
          get<_i25.ProofScopeDataSource>(),
          await get.getAsync<_i41.StorageClaimDataSource>(),
          get<_i40.ClaimMapper>(),
          get<_i11.FiltersMapper>(),
          get<_i4.AuthResponseMapper>()));
  gh.factoryAsync<_i53.IdentityRepositoryImpl>(() async =>
      _i53.IdentityRepositoryImpl(
          get<_i34.WalletDataSource>(),
          get<_i18.LibIdentityDataSource>(),
          await get.getAsync<_i43.StorageIdentityDataSource>(),
          await get.getAsync<_i44.StorageKeyValueDataSource>(),
          get<_i12.HexMapper>(),
          get<_i23.PrivateKeyMapper>(),
          get<_i16.IdentityDTOMapper>()));
  gh.factory<_i54.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i47.ProofRepositoryImpl>()));
  gh.factory<_i55.ProveUseCase>(
      () => _i55.ProveUseCase(get<_i54.ProofRepository>()));
  gh.factoryAsync<_i56.RemoveClaimsUseCase>(() async =>
      _i56.RemoveClaimsUseCase(
          await get.getAsync<_i48.CredentialRepository>()));
  gh.factoryAsync<_i57.UpdateClaimUseCase>(() async =>
      _i57.UpdateClaimUseCase(await get.getAsync<_i48.CredentialRepository>()));
  gh.factory<_i58.GenerateNonRevProofUseCase>(
      () => _i58.GenerateNonRevProofUseCase(get<_i54.ProofRepository>()));
  gh.factory<_i59.GenerateProofUseCase>(
      () => _i59.GenerateProofUseCase(get<_i54.ProofRepository>()));
  gh.factory<_i60.GetAtomicQueryInputsUseCase>(
      () => _i60.GetAtomicQueryInputsUseCase(get<_i54.ProofRepository>()));
  gh.factory<_i61.GetWitnessUseCase>(
      () => _i61.GetWitnessUseCase(get<_i54.ProofRepository>()));
  gh.factoryAsync<_i62.Iden3commRepository>(() async => repositoriesModule
      .iden3commRepository(await get.getAsync<_i52.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i63.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i53.IdentityRepositoryImpl>()));
  gh.factory<_i64.ProofGeneration>(() => _i64.ProofGeneration(
      get<_i60.GetAtomicQueryInputsUseCase>(),
      get<_i61.GetWitnessUseCase>(),
      get<_i55.ProveUseCase>()));
  gh.factoryAsync<_i65.RemoveCurrentIdentityUseCase>(() async =>
      _i65.RemoveCurrentIdentityUseCase(
          await get.getAsync<_i63.IdentityRepository>()));
  gh.factoryAsync<_i66.SignMessageUseCase>(() async =>
      _i66.SignMessageUseCase(await get.getAsync<_i63.IdentityRepository>()));
  gh.factoryAsync<_i67.CreateIdentityUseCase>(() async =>
      _i67.CreateIdentityUseCase(
          await get.getAsync<_i63.IdentityRepository>()));
  gh.factoryAsync<_i68.GetAuthTokenUseCase>(() async =>
      _i68.GetAuthTokenUseCase(
          await get.getAsync<_i62.Iden3commRepository>(),
          get<_i54.ProofRepository>(),
          await get.getAsync<_i63.IdentityRepository>()));
  gh.factoryAsync<_i69.GetCurrentIdentifierUseCase>(() async =>
      _i69.GetCurrentIdentifierUseCase(
          await get.getAsync<_i63.IdentityRepository>()));
  gh.factoryAsync<_i70.GetIdentityUseCase>(() async =>
      _i70.GetIdentityUseCase(await get.getAsync<_i63.IdentityRepository>()));
  gh.factoryAsync<_i71.GetProofsUseCase>(() async => _i71.GetProofsUseCase(
      get<_i54.ProofRepository>(),
      await get.getAsync<_i63.IdentityRepository>(),
      await get.getAsync<_i48.CredentialRepository>(),
      get<_i25.ProofScopeDataSource>(),
      get<_i34.WalletDataSource>(),
      get<_i59.GenerateProofUseCase>()));
  gh.factoryAsync<_i72.IdentityWallet>(() async => _i72.IdentityWallet(
      await get.getAsync<_i67.CreateIdentityUseCase>(),
      await get.getAsync<_i70.GetIdentityUseCase>(),
      await get.getAsync<_i66.SignMessageUseCase>(),
      await get.getAsync<_i69.GetCurrentIdentifierUseCase>(),
      await get.getAsync<_i65.RemoveCurrentIdentityUseCase>()));
  gh.factoryAsync<_i73.AuthenticateUseCase>(() async =>
      _i73.AuthenticateUseCase(
          await get.getAsync<_i62.Iden3commRepository>(),
          await get.getAsync<_i71.GetProofsUseCase>(),
          await get.getAsync<_i68.GetAuthTokenUseCase>()));
  gh.factoryAsync<_i74.FetchAndSaveClaimsUseCase>(() async =>
      _i74.FetchAndSaveClaimsUseCase(
          await get.getAsync<_i68.GetAuthTokenUseCase>(),
          await get.getAsync<_i48.CredentialRepository>()));
  gh.factoryAsync<_i75.Iden3comm>(() async => _i75.Iden3comm(
      await get.getAsync<_i51.GetVocabsUseCase>(),
      await get.getAsync<_i73.AuthenticateUseCase>(),
      get<_i3.AuthRequestMapper>()));
  gh.factoryAsync<_i76.CredentialWallet>(() async => _i76.CredentialWallet(
      await get.getAsync<_i74.FetchAndSaveClaimsUseCase>(),
      await get.getAsync<_i50.GetClaimsUseCase>(),
      await get.getAsync<_i56.RemoveClaimsUseCase>(),
      await get.getAsync<_i57.UpdateClaimUseCase>()));
  return get;
}

class _$NetworkModule extends _i77.NetworkModule {}

class _$DatabaseModule extends _i77.DatabaseModule {}

class _$RepositoriesModule extends _i77.RepositoriesModule {}
