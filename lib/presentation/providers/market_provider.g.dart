// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$marketNotifierHash() => r'efac8c46037e62e8485cc49486c7fce9fe5eee48';

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
String _$inventoryNotifierHash() => r'd7afccbf148243f7ef67facaddf932bf86d6d019';

/// Envanter provider'ı
///
/// Copied from [InventoryNotifier].
@ProviderFor(InventoryNotifier)
final inventoryNotifierProvider =
    AutoDisposeNotifierProvider<
      InventoryNotifier,
      List<InventoryItem>
    >.internal(
      InventoryNotifier.new,
      name: r'inventoryNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$inventoryNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$InventoryNotifier = AutoDisposeNotifier<List<InventoryItem>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
