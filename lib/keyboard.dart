import 'package:flutter/material.dart';
import 'utils.dart';

class Keyboard extends StatelessWidget {
  int radix = 0;

  TextEditingController binaryController,
      decimalController,
      octalController,
      hexController;

  Keyboard(this.radix,
      {this.binaryController,
      this.octalController,
      this.decimalController,
      this.hexController})
      : assert(radix != null, "Null radix given");

  @override
  Widget build(BuildContext context) => _getKeyboard(radix);

  TextEditingController getController(int radix) {
    return {
      2: binaryController,
      8: octalController,
      10: decimalController,
      16: hexController,
    }[radix];
  }

  int getControllerLength(int radix){
    return {
      2: 63,
      8: 21,
      10: 19,
      16: 16,
    }[radix];
  }

  Widget button(String key, {bool expanded = false}) {
    void onPressed(){
      TextEditingController controller = getController(radix);
      if(controller.text.length == getControllerLength(radix)) return;
      controller.text += key;

      setBases(controller.text, radix);
    }

    return expanded
        ? Expanded(
            child: FlatButton(
              child: Text(key),
              onPressed: onPressed,
            ),
          )
        : Flexible(
            child: FlatButton(
              child: Text(key),
              onPressed: onPressed,
            ),
          );
  }

  Widget clearButton({bool all = false}) {
    return Flexible(
      child: all
          ? FlatButton(
              child: Text("Limpar"),
              onPressed: () {
                TextEditingController controller = getController(radix);
                controller.text = "";
                setBases(controller.text, radix);
              },
            )
          : FlatButton(
              child: Icon(Icons.backspace),
              onPressed: () {
                TextEditingController controller = getController(radix);
                controller.text = "";
                setBases(controller.text, radix);
              },
            ),
    );
  }

  void setBases(String text, int radix) {
    Converted c = Conversions.fromRadix(text, radix);
    if (radix != Conversions.decimal) decimalController.text = c.decimal;

    decimalController.selection = TextSelection.fromPosition(
        TextPosition(offset: decimalController.text.length));

    if (radix != Conversions.binary)
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

  Widget _getKeyboard(int radix) {
    return {
      0: Center(),
      2: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button("1"),
              button("0"),
              clearButton(),
              clearButton(all: true)
            ],
          )
        ],
      ),
      8: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button("1"),
              button("2"),
              button("3"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button("4"),
              button("5"),
              button("6"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button("7"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button("0", expanded: true),
              clearButton(),
              clearButton(all: true)
            ],
          )
        ],
      ),
      10: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button("1"),
              button("2"),
              button("3"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button("4"),
              button("5"),
              button("6"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button("7"),
              button("8"),
              button("9"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button("0", expanded: false),
              clearButton(),
              clearButton(all: true)
            ],
          )
        ],
      ),
      16: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button("1"),
              button("2"),
              button("3"),
              button("A"),
              button("B"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button("4"),
              button("5"),
              button("6"),
              button("C"),
              button("D"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button("7"),
              button("8"),
              button("9"),
              button("E"),
              button("F"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button("0", expanded: true),
              clearButton(),
              clearButton(all: true)
            ],
          )
        ],
      ),
    }[radix];
  }
}
