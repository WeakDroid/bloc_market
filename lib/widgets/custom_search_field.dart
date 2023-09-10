import 'package:flutter/material.dart';
import '../styles/colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  final TextEditingController _textEditingController = TextEditingController();
  Color borderColor = AppColors.grey800;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      borderColor =
          _focusNode.hasFocus ? AppColors.neonBlue : AppColors.grey800;
    });
  }

  void _clearText() {
    _textEditingController.clear();
    if (widget.onChanged != null) {
      widget.onChanged!('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: _buildTextField(),
    );
  }

  TextField _buildTextField() {
    return TextField(
      controller: _textEditingController,
      decoration: InputDecoration(
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.only(
            top: 16, bottom: 16, left: 16, right: 48),
        border: InputBorder.none,
        suffixIcon: _textEditingController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(
                  Icons.clear,
                  size: 26,
                  color: AppColors.neonBlue,
                ),
                onPressed: _clearText,
              )
            : null,
      ),
      onChanged: widget.onChanged,
      focusNode: _focusNode,
    );
  }
}
