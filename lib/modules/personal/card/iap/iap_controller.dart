import 'dart:async';

import 'package:futurekids/data/providers/iap_provider.dart';
import 'package:futurekids/modules/personal/card/card_controller.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../../Utils/color_palette.dart';
import '../../../../utils/custom_theme.dart';
import '../../../../utils/loading_dialog.dart';
import '../../../../widgets/k_button.dart';

class IAPController extends GetxController {
  final listProducts = <ProductDetails>[].obs;
  StreamSubscription<dynamic>? _subscription;
  LoadingDialog? _dialog;

  void _fetchListProduct() async {
    final _provider = IAPProvider();
    final _result = await _provider.getListProduct().catchError((err) {
      Notify.error(err);
    });

    if (_result != null) {
      Set<String> setProduct = {};
      for (var item in _result) {
        setProduct.add(item);
      }
      final bool available = await InAppPurchase.instance.isAvailable();

      if (!available) {
        // The store cannot be reached or accessed. Update the UI accordingly.
        Notify.error('The store cannot be reached or accessed');
      } else {
        final ProductDetailsResponse response =
            await InAppPurchase.instance.queryProductDetails(setProduct);
        if (response.notFoundIDs.isNotEmpty) {
          // Handle the error.
        }
        listProducts.value = response.productDetails;
      }
    }
  }

  void _purchaseCard(dynamic code) async {
    _dialog = LoadingDialog();
    _dialog?.show();
    final _provider = IAPProvider();
    final _result = await _provider.purchaseCard(code: code).catchError((err) {
      _dialog?.error(message: err, callback: () => _dialog?.dismiss());
    });

    if (_result != null && _result) {
      Get.find<CardController>().fetchListCard();

      _dialog?.succeed(
        message: 'Bạn đã thanh toán khoá học thành công!',
        callback: () => _dialog?.dismiss(),
      );
    }
  }

  void _buyProduct(ProductDetails productDetails) {
    final purchaseParam = PurchaseParam(productDetails: productDetails);
    InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
  }

  void showConfirm(int index) {
    final _dialog = LoadingDialog();
    _dialog.custom(
      loadingWidget: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 344,
            padding:
                const EdgeInsets.only(top: 60, bottom: 16, left: 32, right: 32),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Hãy chắc chắn gói đang chọn là chính xác',
                  textAlign: TextAlign.center,
                  style: CustomTheme.semiBold(16).copyWith(
                    color: kNeutral2Color,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Tiếp tục trả tiền trực tiếp cho gói bạn chọn. Các gói đã thanh toán không thể được trả lại tiền mặt',
                  textAlign: TextAlign.center,
                  style: CustomTheme.medium(14).copyWith(color: kNeutral2Color),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(
                        child: KButton(
                      onTap: () => _dialog.dismiss(),
                      title: 'Huỷ',
                      style: CustomTheme.semiBold(16)
                          .copyWith(color: Colors.white),
                      width: double.infinity,
                      backgroundColor: BackgroundColor.disable,
                    )),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: KButton(
                      onTap: () {
                        _dialog.dismiss();
                        _buyProduct(listProducts[index]);
                      },
                      title: 'Tiếp Tục',
                      style: CustomTheme.semiBold(16)
                          .copyWith(color: Colors.white),
                      width: double.infinity,
                      backgroundColor: BackgroundColor.accent,
                    ))
                  ],
                )
              ],
            ),
          ),
          Positioned(
              top: -80,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/fubo_succeed.gif',
                width: 118.18,
                height: 131.13,
              )),
        ],
      ),
    );
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    for (var purchaseDetails in purchaseDetailsList) {
      printError(info: purchaseDetails.status.toString());
      if (purchaseDetails.status == PurchaseStatus.pending) {
        _dialog = LoadingDialog();
        _dialog?.show();
      } else {
        _dialog?.dismiss();
        if (purchaseDetails.status == PurchaseStatus.error) {
          _dialog = LoadingDialog();
          _dialog?.show();
          _dialog?.error(
              message: purchaseDetails.error!.message,
              callback: () => _dialog?.dismiss());
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          _purchaseCard(purchaseDetails.productID);
        }
        if (purchaseDetails.pendingCompletePurchase) {
          InAppPurchase.instance.completePurchase(purchaseDetails);
        }
      }
    }
  }

  @override
  void onInit() {
    final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription?.cancel();
    }, onError: (error) {
      // handle error here.
    });

    _fetchListProduct();

    super.onInit();
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
