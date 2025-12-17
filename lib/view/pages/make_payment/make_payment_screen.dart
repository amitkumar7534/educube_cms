import 'package:educube1/const/app_colors.dart';
import 'package:educube1/controller/fees/fees_controller.dart';
import 'package:educube1/utils/extensions/extension.dart';
import 'package:educube1/view/widgets/common_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart' as get_ctrl;
import '../../../const/app_images.dart';
import '../../../utils/validations.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_drawer.dart';
import '../../widgets/common_input_field.dart';
import 'cardForm.dart';

final _feeCtrl = get_ctrl.Get.find<FeesController>();

class MakePaymentScreen extends StatelessWidget {
  const MakePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      drawer: CommonDrawer(),
      appBar: CommonAppBar(
        title: 'fees',
      ),
      body: ListView(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 16, top: 8),
                child: GestureDetector(
                    onTap: () {
                      get_ctrl.Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )),
              )),
          // CommonTile(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Preferred Payment Methods',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontSize: 14.fontMultiplier)),
          ),
          CommonCard(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                InkWell(
                  onTap: () => _feeCtrl.doPayment(method: PaymentMethod.upi),
                  child: Row(
                    children: [
                      Image.asset(AppImages.imgGooglePay, height: 16),
                      const SizedBox(width: 4.0),
                      Text(
                        'UPI - Google Pay',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontSize: 12.fontMultiplier),
                      ),
                      const Spacer(),
                      const CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.grey,
                        child: Center(
                            child: Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 12,
                        )),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: AppColors.colorTextPrimary.withOpacity(0.3),
                ),
                InkWell(
                  onTap: () => _feeCtrl.doPayment(method: PaymentMethod.upi),
                  child: Row(
                    children: [
                      Image.asset(AppImages.imgPhonePe, height: 16),
                      const SizedBox(width: 4.0),
                      Text(
                        'UPI - Phone Pay',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontSize: 12.fontMultiplier),
                      ),
                      const Spacer(),
                      const CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.grey,
                        child: Center(
                            child: Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 12,
                        )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text('Cards, UPI & More',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontSize: 14.fontMultiplier)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: InkWell(
              onTap: () => _feeCtrl.doPayment(method: PaymentMethod.card),
              child: Row(
                children: [
                  Image.asset(AppImages.imgCreditCard, height: 26),
                  const SizedBox(width: 8.0),
                  Text('Cards',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 14.fontMultiplier)),
                  const Spacer(),
                  SizedBox(
                    width: 80,
                    child: Stack(
                      children: [
                        _commonPaymentCard(img: AppImages.imgVisa, height: 5),
                        Positioned(
                          left: 22,
                          child: _commonPaymentCard(
                              img: AppImages.imgRuPay, height: 5),
                        ),
                        Positioned(
                            left: 44,
                            child: _commonPaymentCard(
                                img: AppImages.imgMasterCard))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          //-------------------------[card form]--------------------------------
          CardForm(
            cardNo: TextEditingController(),
            cvv: TextEditingController(),
            xDate: TextEditingController(),
            cardHolder: TextEditingController(),
            onPay: (value) {},
          ),

          //-------------------------[card form]--------------------------------
          Divider(
            endIndent: 16,
            indent: 16,
            color: AppColors.colorTextPrimary.withOpacity(0.3),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Row(
              children: [
                Image.asset(AppImages.imgUpi, height: 26),
                const SizedBox(width: 8.0),
                Text('UPI',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 14.fontMultiplier)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _commonCard(img: AppImages.imgGooglePay),
                _commonCard(img: AppImages.imgPhonePe),
                _commonCard(img: AppImages.imgPaytm),
                _commonCard(img: AppImages.imgOther)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: InkWell(
              onTap: () => _feeCtrl.doPayment(method: PaymentMethod.netbanking),
              child: Row(
                children: [
                  Image.asset(AppImages.imgCreditCard, height: 26),
                  const SizedBox(width: 8.0),
                  Text('NetBanking',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 14.fontMultiplier)),
                  const Spacer(),
                  SizedBox(
                    width: 80,
                    child: Stack(
                      children: [
                        _commonPaymentCard(img: AppImages.imgVisa, height: 5),
                        Positioned(
                          left: 22,
                          child: _commonPaymentCard(
                              img: AppImages.imgRuPay, height: 5),
                        ),
                        Positioned(
                            left: 44,
                            child: _commonPaymentCard(
                                img: AppImages.imgMasterCard))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(
            endIndent: 16,
            indent: 16,
            color: AppColors.colorTextPrimary.withOpacity(0.3),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                Image.asset(AppImages.imgCreditCard, height: 26),
                const SizedBox(width: 8.0),
                Text('Wallet',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 14.fontMultiplier)),
                const Spacer(),
                SizedBox(
                  width: 80,
                  child: Stack(
                    children: [
                      _commonPaymentCard(img: AppImages.imgVisa, height: 5),
                      Positioned(
                        left: 22,
                        child: _commonPaymentCard(
                            img: AppImages.imgRuPay, height: 5),
                      ),
                      Positioned(
                          left: 44,
                          child:
                              _commonPaymentCard(img: AppImages.imgMasterCard))
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(
            endIndent: 16,
            indent: 16,
            color: AppColors.colorTextPrimary.withOpacity(0.3),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                Image.asset(AppImages.imgCreditCard, height: 26),
                const SizedBox(width: 8.0),
                Text('EMI',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 14.fontMultiplier)),
                const Spacer(),
                SizedBox(
                  width: 80,
                  child: Stack(
                    children: [
                      _commonPaymentCard(img: AppImages.imgVisa, height: 5),
                      Positioned(
                        left: 22,
                        child: _commonPaymentCard(
                            img: AppImages.imgRuPay, height: 5),
                      ),
                      Positioned(
                          left: 44,
                          child:
                              _commonPaymentCard(img: AppImages.imgMasterCard))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _commonPaymentCard({required String img, double? height}) {
    return GestureDetector(
      child: CircleAvatar(
        radius: 14,
        backgroundColor: AppColors.colorTextPrimary.withOpacity(0.4),
        child: CircleAvatar(
          radius: 13,
          backgroundColor: Colors.white,
          child: Center(child: Image.asset(img, height: height ?? 8)),
        ),
      ),
    );
  }

  _commonCard({required String img}) {
    return Container(
        decoration: BoxDecoration(
          color: AppColors.colorLightBlue,
          borderRadius: BorderRadius.circular(8.0),
        ),
        height: 50,
        width: 50,
        padding: const EdgeInsets.all(12.0),
        child: Center(child: Image.asset(img)));
  }
}
