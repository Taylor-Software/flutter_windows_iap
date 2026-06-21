/// Metadata for a single Microsoft Store product.
class WinIapProduct {
  /// Creates a product from Store-provided metadata.
  const WinIapProduct({
    required this.skuId,
    required this.title,
    required this.description,
    required this.formattedPrice,
    required this.currencyCode,
  });

  /// Store SKU identifier (the in-app product ID set in Partner Center).
  final String skuId;

  /// Localised product title.
  final String title;

  /// Localised product description.
  final String description;

  /// Localised price string as returned by the Store (e.g. "$0.99").
  final String formattedPrice;

  /// ISO 4217 currency code (e.g. "USD").
  final String currencyCode;

  /// Builds a [WinIapProduct] from the platform channel's map payload.
  factory WinIapProduct.fromMap(Map<Object?, Object?> map) {
    return WinIapProduct(
      skuId: map['skuId'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      formattedPrice: map['formattedPrice'] as String,
      currencyCode: map['currencyCode'] as String,
    );
  }
}

/// Outcome of a [FlutterWindowsIap.purchase] call.
enum WinIapPurchaseStatus {
  /// The user completed the purchase and the SKU is now owned.
  succeeded,

  /// The user already owns this SKU (non-consumable re-purchase attempt).
  alreadyPurchased,

  /// The user cancelled the Store dialog.
  userCancelled,

  /// The Store returned an error. See [WinIapPurchaseResult.extendedError].
  failed,
}

/// Result of a [FlutterWindowsIap.purchase] attempt for a single SKU.
class WinIapPurchaseResult {
  /// Creates a purchase result.
  const WinIapPurchaseResult({
    required this.skuId,
    required this.status,
    this.extendedError,
  });

  /// Store SKU identifier the purchase was attempted for.
  final String skuId;

  /// Outcome of the purchase attempt.
  final WinIapPurchaseStatus status;

  /// HRESULT error code from `StoreContext.RequestPurchaseAsync`, if [status]
  /// is [WinIapPurchaseStatus.failed].
  final int? extendedError;

  /// Builds a [WinIapPurchaseResult] from the platform channel's map payload.
  factory WinIapPurchaseResult.fromMap(Map<Object?, Object?> map) {
    final statusStr = map['status'] as String;
    final status = switch (statusStr) {
      'succeeded' => WinIapPurchaseStatus.succeeded,
      'alreadyPurchased' => WinIapPurchaseStatus.alreadyPurchased,
      'userCancelled' => WinIapPurchaseStatus.userCancelled,
      _ => WinIapPurchaseStatus.failed,
    };
    return WinIapPurchaseResult(
      skuId: map['skuId'] as String,
      status: status,
      extendedError: map['extendedError'] as int?,
    );
  }
}
