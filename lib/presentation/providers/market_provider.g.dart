// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$marketNotifierHash() => r'41b71eb03dbf9ede97576e36f5ea265c6d3a79af';

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
String _$inventoryNotifierHash() => r'389188fed8d1aa4a100d012b06c7608e1b8a3b82';

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
