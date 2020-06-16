import 'package:flutter/material.dart';
import 'utils.dart';

class BinaryPicker extends StatefulWidget {

  TextEditingController binaryController,
      decimalController,
      octalController,
      hexController;

  BinaryPicker(
      {this.binaryController,
      this.octalController,
      this.decimalController,
      this.hexController});

  @override
  _BinaryPickerState createState() => _BinaryPickerState();
}

class _BinaryPickerState extends State<BinaryPicker> {
  String binary;

  @override
  void initState() {
    super.initState();
    widget.binaryController.addListener(() {
      setState(() {
        binary = widget.binaryController.text;
      });
    });
  }

  @override
  void dispose() {
    widget.binaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    binary = widget.binaryController.text;
    fillBits();
    return getBinarySelector();
  }

  void fillBits() {
    binary = reversed(binary);
    int length = (63 - binary.length);
    for (int i = 0; i < length; i++) {
      binary += "0";
    }
    binary = reversed(binary);
  }

  Widget getBinarySelector() {
    List<Widget> widgets = [];
    List<Widget> row = [];
    for (int i = 0, j = 0, k = 0; i < binary.length; i++, j++) {
      String char = binary.split('')[i];
      if (i == 0)
        row.add(Text(
          "  ",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1),
        ));
      if (i == 3 || j == 4) {
        row.add(Text(
          "  ",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1),
        ));
        k++;
        j = 0;
      }
      if (k == 5) {
        widgets.add(Wrap(
          alignment: WrapAlignment.center,
          children: row,
        ));
        k = 0;
        row = [];
      }
      row.add(GestureDetector(
        child: Text(
          binary.split('')[i],
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1),
        ),
        onTap: () {
          setState(() {
            binary = binary.replaceRange(i, i + 1, char == "1" ? "0" : "1");

            setBases(binary);
          });
        },
      ));
      if (i == 62) {
        widgets.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: row,
        ));
        k = 0;
        row = [];
      }
    }

    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: widgets,
      ),
    );
  }

  void setBases(String binary) {
    Converted c = Conversions.fromRadix(binary, Conversions.binary);

    widget.decimalController.text = c.decimal;
    widget.decimalController.selection = TextSelection.fromPosition(
        TextPosition(offset: c.decimal.length));

    widget.binaryController.text = c.binary;
    widget.binaryController.selection = TextSelection.fromPosition(
        TextPosition(offset: c.binary.length));

    widget.octalController.text = c.octal;
    widget.octalController.selection =
        TextSelection.fromPosition(TextPosition(offset: c.octal.length));

    widget.hexController.text = c.hex;
    widget.hexController.selection =
        TextSelection.fromPosition(TextPosition(offset: c.hex.length));
  }

  String reversed(String string) {
    return string.split('').reversed.join('');
  }
}
