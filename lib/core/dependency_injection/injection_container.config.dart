// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_flutter/hive_flutter.dart' as _i986;
import 'package:injectable/injectable.dart' as _i526;
import 'package:subsciption_manager/core/dependency_injection/module/database_module.dart'
    as _i721;
import 'package:subsciption_manager/modules/subscription/data/models/subscription_group_model.dart'
    as _i5;
import 'package:subsciption_manager/modules/subscription/data/repository/isubscription_repository.dart'
    as _i284;
import 'package:subsciption_manager/modules/subscription/data/repository/subscription_repository.dart'
    as _i614;
import 'package:subsciption_manager/modules/subscription/presentation/bloc/subscription_bloc.dart'
    as _i379;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final databaseModule = _$DatabaseModule();
    await gh.factoryAsync<_i986.Box<_i5.SubscriptionGroupModel>>(
      () => databaseModule.subsGroupBox,
      instanceName: 'subscription_group',
      preResolve: true,
    );
    gh.factory<_i284.ISubscriptionRepository>(() =>
        _i614.SubscriptionRepository(gh<_i986.Box<_i5.SubscriptionGroupModel>>(
            instanceName: 'subscription_group')));
    gh.factory<_i379.SubscriptionBloc>(
        () => _i379.SubscriptionBloc(gh<_i284.ISubscriptionRepository>()));
    return this;
  }
}

class _$DatabaseModule extends _i721.DatabaseModule {}
