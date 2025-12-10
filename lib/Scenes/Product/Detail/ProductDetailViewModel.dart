import 'package:ofm_demo/Scenes/Product/Detail/Model/ProductModel.dart';
import 'package:ofm_demo/Sources/CacheManager.dart';
import 'package:ofm_demo/Sources/Network/Network.dart';
import 'package:rx_notifier/rx_notifier.dart';

class ProductDetailViewModel {
  // MARK: - Properties
  final String path;
  RxNotifier<ProductModel?> _productModel = RxNotifier(null);
  RxNotifier<ProductSKU?> _selectedSKU = RxNotifier(null);

  RxNotifier<ProductModel?> get productModel => _productModel;
  RxNotifier<ProductSKU?> get selectedSKU => _selectedSKU;

  Function? shouldShowError;
  Function(bool)? shouldShowLoading;

  ProductDetailViewModel({required this.path});

  // MARK: - Methods
  setSKU(ProductSKU sku) {
    _selectedSKU.value = sku;
    print('Selected SKU: ${sku.toString()}');
  }

  setSelectedSize(SizeModel size) {
    for (var s in selectedSKU.value?.sizes ?? []) {
      s.selected = s == size;
    }
    // ignore: invalid_use_of_protected_member
    // _selectedSKU.notifyListeners();
    print('Selected size: ${_selectedSKU.value.toString()}');
  }

  // MARK: Services
  fetch() async {
    shouldShowLoading?.call(true);
    final network = Network();
    final result =
        await network.get(path, headers: {'Content-Type': 'application/json'});

    final cacheKey = 'product_$path';
    final product = ProductModel.fromJson(result.bodyResponse);

    if (product.productSKU.isEmpty) {
      shouldShowError!();
      return;
    }

    CacheManager.instance.set(cacheKey, product);
    _productModel.value = product;
    _selectedSKU.value = product.productSKU.first;
    shouldShowLoading?.call(false);
  }
}
