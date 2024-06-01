import 'package:flutter/material.dart';

class IncrementDecrementButton extends StatefulWidget {
  final String incDec;
  final Function(int) updatePrice;

  IncrementDecrementButton(
      {Key? key, required this.incDec, required this.updatePrice})
      : super(key: key);

  @override
  _IncrementDecrementButtonState createState() =>
      _IncrementDecrementButtonState();
}

class _IncrementDecrementButtonState extends State<IncrementDecrementButton> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      widget.updatePrice(1); // Increment the price by 15
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      widget.updatePrice(-1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.incDec == '+' ? _incrementCounter : _decrementCounter,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        side: BorderSide(color: Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(widget.incDec),
    );
  }
}
