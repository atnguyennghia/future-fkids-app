///
///A class handle convert number to words
///
class NumberToWordsVietnamese {
  NumberToWordsVietnamese._();

  static const unitNumbers = ["không", "một", "hai", "ba", "bốn", "năm", "sáu", "bảy", "tám", "chín"];
  static const placeValues = ["", "nghìn", "triệu", "tỷ"];

  List<String> chunks(String str, int chunkSize) {
    var chunks = <String>[];
    for (var i = 0; i < str.length; i += chunkSize) {
      chunks.add(str.substring(i, i+chunkSize > str.length ? str.length : i + chunkSize));
    }
    return chunks;
  }

  static String convert(int inputNumber) {
    if (inputNumber == 0) {
      return "không";
    }

    bool isNegative = false;

    // -12345678.3445435 => "-12345678"
    String sNumber = inputNumber.toString();
    double number = double.parse(sNumber);
    if (number < 0)
    {
      number = -number;
      sNumber = number.toString();
      isNegative = true;
    }

    int ones, tens, hundreds;

    int positionDigit = sNumber.length;   // last -> first

    String result = " ";

    if (positionDigit == 0) {
      result = unitNumbers[0] + result;
    }
    else {
      // 0:       ###
      // 1: nghìn ###,###
      // 2: triệu ###,###,###
      // 3: tỷ    ###,###,###,###
      int placeValue = 0;
      final listStr = sNumber.split('');
      while (positionDigit > 0)
      {
        // Check last 3 digits remain ### (hundreds tens ones)
        tens = hundreds = -1;
        ones = int.parse(listStr[positionDigit - 1]);
        positionDigit--;
        if (positionDigit > 0)
        {
          tens = int.parse(listStr[positionDigit - 1]);
          positionDigit--;
          if (positionDigit > 0)
          {
            hundreds = int.parse(listStr[positionDigit - 1]);
            positionDigit--;
          }
        }

        if ((ones > 0) || (tens > 0) || (hundreds > 0) || (placeValue == 3)){
          result = placeValues[placeValue] + result;
        }

        placeValue++;
        if (placeValue > 3) placeValue = 1;

        if ((ones == 1) && (tens > 1)) {
          result = "mốt " + result;
        }
        else
        {
          if ((ones == 5) && (tens > 0)) {
            result = "lăm " + result;
          }
          else if (ones > 0) {
            result = unitNumbers[ones] + " " + result;
          }
        }
        if (tens < 0) {
          break;
        }
        else
        {
          if ((tens == 0) && (ones > 0)) result = "lẻ " + result;
          if (tens == 1) result = "mười " + result;
          if (tens > 1) result = unitNumbers[tens] + " mươi " + result;
        }
        if (hundreds < 0) {
          break;
        }
        else
        {
          if ((hundreds > 0) || (tens > 0) || (ones > 0)) {
            result = unitNumbers[hundreds] + " trăm " + result;
          }
        }
        result = " " + result;
      }
    }
    result = result.trim();
    if (isNegative) result = "âm " + result;
    return result;
  }
}