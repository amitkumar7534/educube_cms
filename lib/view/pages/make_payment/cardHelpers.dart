import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

enum CardType {
  otherBrand,
  mastercard,
  visa,
  rupay,
  americanExpress,
  unionpay,
  discover,
  elo,
  hipercard,
  empty
}

class CardHelpers{
  static bool isAmex = false;
  static const double creditCardIconSize = 35;
  static const String packageName = '';
  // static const String packageName = 'flutter_credit_card';

   static CardType getCardType({ required String cardNumber}){
     if(cardNumber.trim().isEmpty){
       return CardType.empty;
     }
    final CardType ccType = detectCCType(cardNumber);
    return ccType;
    // // isAmex = ccType == CardType.americanExpress;
    // return getCardTypeImage(
    //   cardType: ccType,
    // );
  }

  static String expiryDateMasking(String value){
    final String expiry = value;
    value =
    expiry.startsWith(RegExp('[2-9]')) ? '0$expiry' : expiry;
    if (value.length > 2) {
      final v1 = value.substring(0, 2);
      final v2 = value.substring(2, value.length);
      v2.replaceAll('/', '');
      if (v2.isNotEmpty) {
        value = '$v1/$v2';
      }
    }else{
      if(int.parse(value) > 12){
        value = '0${value}';
      }

      if (value.length > 2) {
        final v1 = value.substring(0, 2);
        final v2 = value.substring(2, value.length);
        v2.replaceAll('/', '');
        if (v2.isNotEmpty) {
          value = '$v1/$v2';
        }
      }
    }

    return value;
  }



  static CardType detectCCType(String cardNumber) {
    if (cardNumber.isEmpty) {
      return CardType.otherBrand;
    }

    // Remove any spaces
    cardNumber = cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');

    final int firstDigit = int.parse(
      cardNumber.length <= 1 ? cardNumber : cardNumber.substring(0, 1),
    );

    if (!cardNumPatterns.containsKey(firstDigit)) {
      return CardType.otherBrand;
    }

    final Map<List<int?>, CardType> cardNumPatternSubMap =
    cardNumPatterns[firstDigit]!;

    final int ccPatternNum = int.parse(cardNumber);

    for (final List<int?> range in cardNumPatternSubMap.keys) {
      int subPatternNum = ccPatternNum;

      if (range.length != 2 || range.first == null) {
        continue;
      }

      final int start = range.first!;
      final int? end = range.last;

      // Adjust the cardNumber prefix as per the length of start prefix range.
      final int startLen = start.toString().length;
      if (startLen < cardNumber.length) {
        subPatternNum = int.parse(cardNumber.substring(0, startLen));
      }

      if ((end == null && subPatternNum == start) ||
          ((subPatternNum <= (end ?? -double.maxFinite)) &&
              subPatternNum >= start)) {
        return cardNumPatternSubMap[range]!;
      }
    }

    return CardType.otherBrand;
  }



  static const Map<int, Map<List<int?>, CardType>> cardNumPatterns =
  <int, Map<List<int?>, CardType>>{
    6: <List<int?>, CardType>{
      <int?>[655021, 655058]: CardType.elo,
      <int?>[655000, 655019]: CardType.elo,
      <int?>[6521, 6522]: CardType.rupay,
      <int?>[651652, 651679]: CardType.elo,
      <int?>[650901, 650978]: CardType.elo,
      <int?>[650720, 650727]: CardType.elo,
      <int?>[650700, 650718]: CardType.elo,
      <int?>[650541, 650598]: CardType.elo,
      <int?>[650485, 650538]: CardType.elo,
      <int?>[650405, 650439]: CardType.elo,
      <int?>[650035, 650051]: CardType.elo,
      <int?>[650031, 650033]: CardType.elo,
      <int?>[65, null]: CardType.discover,
      <int?>[644, 649]: CardType.discover,
      <int?>[636368, null]: CardType.elo,
      <int?>[636297, null]: CardType.elo,
      <int?>[627780, null]: CardType.elo,
      <int?>[622126, 622925]: CardType.discover,
      <int?>[62, null]: CardType.unionpay,
      <int?>[606282, null]: CardType.hipercard,
      <int?>[6011, null]: CardType.discover,
      <int?>[60, null]: CardType.rupay,
    },
    5: <List<int?>, CardType>{
      <int?>[51, 55]: CardType.mastercard,
      <int?>[509000, 509999]: CardType.elo,
      <int?>[506699, 506778]: CardType.elo,
      <int?>[504175, null]: CardType.elo,
    },
    4: <List<int?>, CardType>{
      <int?>[457631, 457632]: CardType.elo,
      <int?>[457393, null]: CardType.elo,
      <int?>[451416, null]: CardType.elo,
      <int?>[438935, null]: CardType.elo,
      <int?>[431274, null]: CardType.elo,
      <int?>[401178, 401179]: CardType.elo,
      <int?>[4, null]: CardType.visa,
    },
    3: <List<int?>, CardType>{
      <int?>[34, 37]: CardType.americanExpress,
    },
    2: <List<int?>, CardType>{
      <int?>[2720, null]: CardType.mastercard,
      <int?>[270, 271]: CardType.mastercard,
      <int?>[23, 26]: CardType.mastercard,
      <int?>[223, 229]: CardType.mastercard,
      <int?>[2221, 2229]: CardType.mastercard,
    },
  };

  static const Map<CardType, String> cardTypeIconAsset = <CardType, String>{
    CardType.visa: AssetPaths.visa,
    CardType.rupay: AssetPaths.rupay,
    CardType.americanExpress: AssetPaths.americanExpress,
    CardType.mastercard: AssetPaths.mastercard,
    CardType.unionpay: AssetPaths.unionpay,
    CardType.discover: AssetPaths.discover,
    CardType.elo: AssetPaths.elo,
    CardType.hipercard: AssetPaths.hipercard,
  };
}

class AssetPaths {
  const AssetPaths._();

  static const String visa = 'assets/cardIcons/visa.png';
  static const String rupay = 'assets/cardIcons/rupay.png';
  static const String mastercard = 'assets/cardIcons/mastercard.png';
  static const String americanExpress = 'assets/cardIcons/amex.png';
  static const String unionpay = 'assets/cardIcons/unionpay.png';
  static const String discover = 'assets/cardIcons/discover.png';
  static const String elo = 'assets/cardIcons/elo.png';
  static const String hipercard = 'assets/cardIcons/hipercard.png';
  static const String chip = 'assets/cardIcons/chip.png';
}

class CustomCardTypeIcon {
  /// A model class to update card image with user defined widget for the
  /// [CardType].
  CustomCardTypeIcon({
    required this.cardType,
    required this.cardImage,
  });

  /// Specify type of the card available in the parameter of enum.
  CardType cardType;

  /// Showcasing widget for specified card type.
  Widget cardImage;
}


List<CustomCardTypeIcon> cardImageList = [
  CustomCardTypeIcon(
    cardType: CardType.mastercard,
    cardImage: Image.asset(
      AssetPaths.mastercard,
      height: 48,
      width: 48,
    ),
  ),
  CustomCardTypeIcon(
    cardType: CardType.americanExpress,
    cardImage: Image.asset(
      AssetPaths.americanExpress,
      height: 48,
      width: 48,
    ),
  ),
  CustomCardTypeIcon(
    cardType: CardType.discover,
    cardImage: Image.asset(
      AssetPaths.discover,
      height: 48,
      width: 48,
    ),
  ),
  CustomCardTypeIcon(
    cardType: CardType.elo,
    cardImage: Image.asset(
      AssetPaths.elo,
      height: 48,
      width: 48,
    ),
  ),
  CustomCardTypeIcon(
    cardType: CardType.hipercard,
    cardImage: Image.asset(
      AssetPaths.hipercard,
      height: 48,
      width: 48,
    ),
  ),
  CustomCardTypeIcon(
    cardType: CardType.rupay,
    cardImage: Image.asset(
      AssetPaths.rupay,
      height: 48,
      width: 48,
    ),
  ),
  CustomCardTypeIcon(
    cardType: CardType.unionpay,
    cardImage: Image.asset(
      AssetPaths.unionpay,
      height: 48,
      width: 48,
    ),
  ),
  CustomCardTypeIcon(
    cardType: CardType.visa,
    cardImage: Image.asset(
      AssetPaths.visa,
      height: 48,
      width: 48,
    ),
  ),
  CustomCardTypeIcon(
    cardType: CardType.otherBrand,
    cardImage: Image.asset(
      AssetPaths.chip,
      height: 48,
      width: 48,
    ),
  ),
];


Widget getCardTypeImage({
  CardType? cardType,
}) {
  const Widget blankSpace =
  SizedBox.square(dimension: CardHelpers.creditCardIconSize);

  if (cardType == null || cardType == CardType.empty) {
    return blankSpace;
  }

  return cardImageList.firstWhere(
        (CustomCardTypeIcon element) => element.cardType == cardType,
    orElse: () {
      final bool isKnownCardType =
      CardHelpers.cardTypeIconAsset.containsKey(cardType);

      return CustomCardTypeIcon(
        cardType: isKnownCardType ? cardType : CardType.otherBrand,
        cardImage: isKnownCardType
            ? Image.asset(
          CardHelpers.cardTypeIconAsset[cardType]!,
          height: CardHelpers.creditCardIconSize,
          width: CardHelpers.creditCardIconSize,
          // package: CardHelpers.packageName,
        )
            : blankSpace,
      );
    },
  ).cardImage;
}


class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue previousValue,
      TextEditingValue nextValue,
      ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}