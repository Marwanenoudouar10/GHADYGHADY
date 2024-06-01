import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final String text;
  final Color color;
  final Color colorText;
  final double fontSize;
  final VoidCallback onPressed;
  final IconData? icon;
  final double? border;
  final double? iconSize;
  final String? iconAsset; // Path to the asset icon
  final double
      spacing; // Added to customize spacing between the icon and the text
  final String? side;

  const Button({
    super.key,
    required this.text,
    required this.onPressed,
    required this.fontSize,
    required this.color,
    required this.colorText,
    this.icon,
    this.iconSize,
    this.iconAsset,
    this.spacing = 8.0,
    this.border,
    this.side,
  });

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => _updateHover(true),
      onExit: (event) => _updateHover(false),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: _buttonStyle(),
          onPressed: widget.onPressed,
          child: widget.iconAsset == null && widget.icon == null
              ? Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: widget.fontSize,
                    fontWeight: FontWeight.bold,
                    color: widget.colorText,
                    letterSpacing: 1.0,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widget.icon != null
                        ? Icon(
                            widget.icon,
                            size: widget.iconSize,
                          )
                        : Image.asset(
                            widget.iconAsset!,
                            width: widget.iconSize,
                          ),
                    SizedBox(
                        width: widget.spacing), // Space between icon and text
                    Text(
                      widget.text,
                      style: TextStyle(
                        fontSize: widget.fontSize,
                        fontWeight: FontWeight.bold,
                        color: widget.colorText,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      minimumSize: const Size(150, 50),
      padding: const EdgeInsets.symmetric(vertical: 11),
      backgroundColor: widget.color,
      foregroundColor:
          _isHovering ? widget.color : const Color.fromARGB(255, 170, 170, 170),
      shape: RoundedRectangleBorder(
        borderRadius: widget.border != null
            ? BorderRadius.circular(widget.border!)
            : BorderRadius.circular(23),
        side: widget.side != null
            ? const BorderSide(width: 1, color: Color(0xFFFF5700))
            : BorderSide.none,
      ),
    );
  }

  void _updateHover(bool isHovering) {
    setState(() {
      _isHovering = isHovering;
    });
  }
}
