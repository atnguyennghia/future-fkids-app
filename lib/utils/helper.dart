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
    final normalized = value.trim();

    // Việt Nam: 10 digits, starts with 03/05/07/08/09
    final vnRegExp = RegExp(r'^(0[35789])[0-9]{8}$');

    // Nhật: 10-11 digits, starts with 0x… or 81…
    // Examples: 0901234567, 07012345678, 81312345678
    final jpRegExp = RegExp(r'^(0\d{9,10}|81\d{9,10})$');

    return vnRegExp.hasMatch(normalized) || jpRegExp.hasMatch(normalized);
  }
}
