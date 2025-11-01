class Helper {
  Helper();

  static Helper get instance => Helper();

  String getNameOfRank(int rank) {
    switch (rank) {
      case 0:
        return 'Chưa có';
      case 1:
        return 'Đồng I';
      case 2:
        return 'Đồng II';
      case 3:
        return 'Đồng III';
      case 4:
        return 'Bạc I';
      case 5:
        return 'Bạc II';
      case 6:
        return 'Bạc III';
      case 7:
        return 'Vàng I';
      case 8:
        return 'Vàng II';
      case 9:
        return 'Vàng III';
      case 10:
        return 'Bạch kim I';
      case 11:
        return 'Bạch kim II';
      case 12:
        return 'Bạch kim III';
      case 13:
        return 'Kim cương I';
      case 14:
        return 'Kim cương II';
      case 15:
        return 'Kim cương III';
      case 16:
        return 'Cao thủ';
    }

    return '';
  }

  String cleanupWhitespace(String input) {
    final _whitespaceRE = RegExp(r"\s+");
    return input.replaceAll(_whitespaceRE, " ");
  }

  bool isValidPhone(String value) {
    final phoneRegExp = RegExp(r"(0[3|5|7|8|9])+([0-9]{8})\b");
    return phoneRegExp.hasMatch(value);
  }
}
