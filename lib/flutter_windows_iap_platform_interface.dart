import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_windows_iap_method_channel.dart';
import 'src/models.dart';

/// The interface that platform implementations of `flutter_windows_iap` must
/// implement.
///
/// Platform implementations should extend this class rather than implement it
/// as `flutter_windows_iap` does not consider newly added methods to be
/// breaking changes. Extending this class (using `extends`) ensures that the
/// subclass will get the default implementation, while platform
/// implementations that `implements` this interface will be broken by newly
/// added [FlutterWindowsIapPlatform] methods.
abstract class FlutterWindowsIapPlatform extends PlatformInterface {
  /// Constructs a [FlutterWindowsIapPlatform].
  FlutterWindowsIapPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterWindowsIapPlatform _instance = MethodChannelFlutterWindowsIap();

  /// The default instance of [FlutterWindowsIapPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterWindowsIap].
  static FlutterWindowsIapPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterWindowsIapPlatform] when
  /// they register themselves.
  static set instance(FlutterWindowsIapPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Fetches Store product metadata for the given [skuIds].
  Future<List<WinIapProduct>> queryProducts(List<String> skuIds) {
    throw UnimplementedError('queryProducts() has not been implemented.');
  }

  /// Initiates a Store purchase for [skuId].
  Future<WinIapPurchaseResult> purchase(String skuId) {
    throw UnimplementedError('purchase() has not been implemented.');
  }

  /// Returns the SKU IDs the current Microsoft account already owns.
  Future<List<String>> restorePurchases() {
    throw UnimplementedError('restorePurchases() has not been implemented.');
  }
}
