import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'utils.dart';
import 'keyboard.dart';
import 'binary_picker.dart';

class ConvertPage extends StatefulWidget {
  @override
  _ConvertPageState createState() => _ConvertPageState();
}

class _ConvertPageState extends State<ConvertPage> {
  TextEditingController decimalController = TextEditingController();
  TextEditingController binaryController = TextEditingController();
  TextEditingController octalController = TextEditingController();
  TextEditingController hexController = TextEditingController();

  int radix = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          radix = 0;
        });
      },
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          BinaryPicker(
            binaryController: binaryController,
            octalController: octalController,
            decimalController: decimalController,
            hexController: hexController,
          ),
          FractionallySizedBox(
            widthFactor: 0.8,
            alignment: Alignment.center,
            child: TextField(
              onChanged: (newText) {
                setBases(newText, Conversions.decimal);
              },
              onTap: () {
                setState(() {
                  radix = Conversions.decimal;
                });
              },
              controller: decimalController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp(Conversions.decimalRange))
              ],
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(labelText: "Decimal"),
              maxLength: 19,
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.8,
            child: TextField(
              onChanged: (newText) {
                setBases(newText, Conversions.binary);
              },
              onTap: () {
                setState(() {
                  radix = Conversions.binary;
                });
              },
              controller: binaryController,
              keyboardType: TextInputType.number,
              maxLines: 3,
              minLines: 1,
              maxLength: 63,
              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp(Conversions.binaryRange))
              ],
              decoration: InputDecoration(labelText: "Binário"),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.8,
            child: TextField(
              onChanged: (newText) {
                setBases(newText, Conversions.octal);
              },
              onTap: () {
                setState(() {
                  radix = Conversions.octal;
                });
              },
              controller: octalController,
              keyboardType: TextInputType.number,
              maxLength: 21,
              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp(Conversions.octalRange))
              ],
              decoration: InputDecoration(labelText: "Octal"),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.8,
            child: TextField(
              onChanged: (newText) {
                setBases(newText, Conversions.hex);
              },
              onTap: () {
                setState(() {
                  radix = Conversions.hex;
                });
              },
              controller: hexController,
              keyboardType: TextInputType.text,
              maxLength: 16,
              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp(Conversions.hexRange))
              ],
              decoration: InputDecoration(labelText: "Hexadecimal"),
            ),
          ),
          Keyboard(
            radix,
            binaryController: binaryController,
            octalController: octalController,
            decimalController: decimalController,
            hexController: hexController,
          ),
        ]),
      ),
    );
  }

  void setBases(String text, int radix, {bool clicked = false}) {
    Converted c = Conversions.fromRadix(text, radix);

    if (radix != Conversions.decimal) decimalController.text = c.decimal;

    decimalController.selection = TextSelection.fromPosition(
        TextPosition(offset: decimalController.text.length));

    if (radix != Conversions.binary || clicked)
      binaryController.text = c.binary;

    binaryController.selection = TextSelection.fromPosition(
        TextPosition(offset: binaryController.text.length));

    if (radix != Conversions.octal) octalController.text = c.octal;
    octalController.selection =
        TextSelection.fromPosition(TextPosition(offset: c.octal.length));

    if (radix != Conversions.hex) hexController.text = c.hex;
    hexController.selection =
        TextSelection.fromPosition(TextPosition(offset: c.hex.length));
  }
}
