import 'package:educube1/utils/extensions/extension.dart';
import 'package:educube1/view/pages/make_payment/cardHelpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../widgets/common_button.dart';
import '../../widgets/common_input_field.dart';

class CardCtrl extends GetxController {
  final Rx<CardType> _cardIcon = Rx<CardType>(CardHelpers.getCardType(
    cardNumber: '',
  ));

  CardType get cardIcon => _cardIcon.value;

  void onCardNo({required String cardNo}) {
    _cardIcon.value = CardHelpers.getCardType(
      cardNumber: cardNo,
    );
    _cardIcon.refresh();
  }
}

class CardForm extends StatelessWidget {
  final TextEditingController cardNo;
  final TextEditingController cvv;
  final TextEditingController xDate;
  final TextEditingController cardHolder;
  final Function(PaymentCardModel) onPay;

  const CardForm(
      {super.key,
      required this.cardNo,
      required this.cvv,
      required this.xDate, required this.cardHolder, required this.onPay});

  @override
  Widget build(BuildContext context) {
    final _cardCtrl = Get.put(CardCtrl());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Text('Card Information',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: 14.fontMultiplier)),
        ),
        CommonInputField(
          inputFormatter: [
            FilteringTextInputFormatter.digitsOnly,
            CardNumberFormatter(),
          ],
          controller: cardNo,
          hint: 'XXXX XXXX XXXX XXXX',
          isShowTrailing: RxBool(true),
          maxLength: 19,
          trailing: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GetX<CardCtrl>(builder: (ctyrk) {
              return getCardTypeImage(cardType: ctyrk.cardIcon);
            }),
          ),
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                _Icons.card,
                width: 20,
                height: 20,
              ),
            ],
          ),
          inputType: TextInputType.number,
          onChanged: (value) => _cardCtrl.onCardNo(cardNo: value),
        ),
        CommonInputField(
          inputFormatter: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          controller: cardHolder,
          hint: 'Card Holder Name',
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                _Icons.user,
                width: 20,
                height: 20,
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: CommonInputField(
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                controller: cvv,
                hint: 'CVV',
                maxLength: 3,
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      _Icons.cvv,
                      width: 20,
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: CommonInputField(
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                controller: xDate,
                hint: 'MM/YY',
                maxLength: 4,
                onChanged: (value) {
                  xDate.text = CardHelpers.expiryDateMasking(value);
                },
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      _Icons.month,
                      width: 20,
                      height: 20,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),

        CommonButton(
            height: 40,
            // margin:
            // const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
            text: 'pay_now',
            onPressed: () {
              onPay(PaymentCardModel(
                cardNo: cardNo.text,
                xYear: xDate.text.split('/')[1],
                xMonth: xDate.text.split('/')[0],
                cvv: cvv.text,
                name: cardHolder.text,
              ));
            })
      ],
    );
  }
}

class PaymentCardModel{
  final String cardNo;
  final String name;
  final String cvv;
  final String xMonth;
  final String xYear;

  PaymentCardModel({required this.cardNo, required this.name, required this.cvv, required this.xMonth, required this.xYear});
}



class _Icons {
  static const String card = 'assets/cardIcons/credit-card.png';
  static const String cvv = 'assets/cardIcons/cvv.png';
  static const String month = 'assets/cardIcons/calendar.png';
  static const String user = 'assets/cardIcons/user.png';
}
