import 'package:flutter/cupertino.dart';

class AppTextField extends StatefulWidget {
  final String placeholder;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? value;
  final ValueChanged<String>? onChanged;
  final EdgeInsetsGeometry? padding;

  const AppTextField({
    super.key,
    required this.placeholder,
    this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.value,
    this.onChanged,
    this.padding,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final TextEditingController _controller;
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value ?? '');
    _obscure = widget.obscureText;
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && widget.value != _controller.text) {
      _controller.text = widget.value ?? '';
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }
    if (widget.obscureText != oldWidget.obscureText) {
      _obscure = widget.obscureText;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleObscure() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 8.0),
      child: CupertinoTextField(
        placeholder: widget.placeholder,
        prefix:
            widget.prefixIcon != null
                ? Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(widget.prefixIcon),
                )
                : null,
        suffix:
            widget.obscureText
                ? GestureDetector(
                  onTap: _toggleObscure,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      _obscure ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                    ),
                  ),
                )
                : null,
        keyboardType: widget.keyboardType,
        obscureText: _obscure,
        controller: _controller,
        onChanged: widget.onChanged,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: CupertinoColors.systemGrey, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
