// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$marketNotifierHash() => r'329c6f4b6f166ab697ddbefb26c6f0c13f1f3aed';

/// See also [MarketNotifier].
@ProviderFor(MarketNotifier)
final marketNotifierProvider =
    AutoDisposeNotifierProvider<MarketNotifier, List<Product>>.internal(
      MarketNotifier.new,
      name: r'marketNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$marketNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MarketNotifier = AutoDisposeNotifier<List<Product>>;
String _$inventoryNotifierHash() => r'd9b3c5babaa6a7d5fdc08fbdc5536fb7d2d73589';

/// Envanter provider'ı
///
/// Copied from [InventoryNotifier].
@ProviderFor(InventoryNotifier)
final inventoryNotifierProvider =
    NotifierProvider<InventoryNotifier, List<InventoryItem>>.internal(
      InventoryNotifier.new,
      name: r'inventoryNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$inventoryNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$InventoryNotifier = Notifier<List<InventoryItem>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
