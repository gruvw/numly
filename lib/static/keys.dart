abstract class Keys {
  static const negative = "-";
  static const decimal = ".";
  static const fraction = "/";
  static const percent = "%";

  static const symbolsRow = {negative, decimal, fraction, percent};
  static const numbersRow1 = {"1", "2", "3"};
  static const numbersRow2 = {"4", "5", "6"};
  static const numbersRow3 = {"7", "8", "9"};
  static const zero = "0";

  static const all = {
    ...symbolsRow,
    ...numbersRow1,
    ...numbersRow2,
    ...numbersRow3,
    zero,
  };
}
