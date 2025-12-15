import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ofm_demo/Resources/DesignSystem/Colors/DSColors.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSText.dart';

class CreditCardForm extends StatelessWidget {
  final TextEditingController cardNumberController;
  final TextEditingController cardNameController;
  final TextEditingController expiryDateController;
  final TextEditingController cvvController;

  const CreditCardForm({
    super.key,
    required this.cardNumberController,
    required this.cardNameController,
    required this.expiryDateController,
    required this.cvvController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 1),
          const SizedBox(height: 16),
          DSText.compact(
            'Vul uw creditcardgegevens in',
            color: DSColors().textGray,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: cardNumberController,
            label: 'Kaartnummer',
            hint: '1234 5678 9012 3456',
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
              _CardNumberFormatter(),
            ],
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: cardNameController,
            label: 'Naam op kaart',
            hint: 'Zoals op de kaart staat',
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: expiryDateController,
                  label: 'Vervaldatum',
                  hint: 'MM/JJ',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                    _ExpiryDateFormatter(),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTextField(
                  controller: cvvController,
                  label: 'CVV',
                  hint: '123',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DSText.compact(
          label,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: DSColors().primaryColor, width: 2),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }
}

class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      final nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' ');
      }
    }

    final string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    if (text.length > 2) {
      final month = text.substring(0, 2);
      final year = text.substring(2);
      final formatted = '$month/$year';

      return newValue.copyWith(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }

    return newValue;
  }
}
