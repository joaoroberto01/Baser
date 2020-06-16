import 'dart:math';

class Converted{
  String decimal = "", binary = "", octal = "", hex = "";
}

class Conversions {
  static const int binary = 2;
  static const int octal = 8;
  static const int decimal = 10;
  static const int hex = 16;

  static const String binaryRange = "[0-1]";
  static const String octalRange = "[0-7]";
  static const String decimalRange = "[0-9]";
  static const String hexRange = "[a-fA-F0-9]";

  static final Map<String,int> hexLetters = {"A": 10, "B": 11, "C": 12, "D": 13, "E": 14, "F": 15};
  static Converted fromDecimal(String string){
    Converted converted = Converted();

    if(string.isNotEmpty){
      int decimal = int.parse(string);
      converted.decimal = string;
      converted.binary = decimal.toRadixString(binary);
      converted.octal = decimal.toRadixString(octal);
      converted.hex = decimal.toRadixString(hex).toUpperCase();
    }

    return converted;
  }

  static Converted fromRadix(String string, int radix){
    if (string.isEmpty) return Converted();
    int decimal = 0;
    int element;
    string = string.toUpperCase();

    for(int i = 0, j = string.length - 1; j >= 0;i++, j--){
      if (hexLetters.containsKey(string[i]))
        element = hexLetters[string[i]];
      else
        element = int.parse(string[i]);
      decimal += element * pow(radix, j);
    }
    return Conversions.fromDecimal(decimal.toString());
  }

}