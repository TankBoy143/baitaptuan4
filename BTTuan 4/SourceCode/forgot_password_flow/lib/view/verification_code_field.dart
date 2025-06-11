import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class VerificationCodeField extends StatefulWidget {
  final int length;
  final ValueChanged<String> onChanged;

  const VerificationCodeField({
    super.key,
    this.length = 6,
    required this.onChanged,
  });

  @override
  State<VerificationCodeField> createState() => _VerificationCodeFieldState();
}

class _VerificationCodeFieldState extends State<VerificationCodeField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  final FocusNode _keyboardFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    _keyboardFocusNode.dispose();
    super.dispose();
  }

  void _onChanged() {
    final code = _controllers.map((c) => c.text).join();
    widget.onChanged(code);
  }

  void _handleKey(RawKeyEvent event) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      final current = _focusNodes.indexWhere((f) => f.hasFocus);
      if (current > 0 && _controllers[current].text.isEmpty) {
        _focusNodes[current - 1].requestFocus();
        _controllers[current - 1].clear();
        _onChanged();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: _keyboardFocusNode,
      onKey: _handleKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.length, (index) {
          return Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              border: Border.all(color: CupertinoColors.systemGrey, width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
              color: CupertinoColors.white,
            ),
            child: CupertinoTextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              onChanged: (value) {
                if (value.length == 1 && index < widget.length - 1) {
                  _focusNodes[index + 1].requestFocus();
                }
                _onChanged();
              },
              onTap: () {
                _controllers[index].selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: _controllers[index].text.length,
                );
                _keyboardFocusNode.requestFocus();
              },
              onSubmitted: (_) => _onChanged(),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: CupertinoColors.systemGrey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              onEditingComplete: _onChanged,
            ),
          );
        }),
      ),
    );
  }
}
