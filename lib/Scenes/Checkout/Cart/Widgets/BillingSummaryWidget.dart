import 'package:flutter/material.dart';
import 'package:ofm_demo/Commons/Models/CartModel.dart';
import 'package:ofm_demo/Commons/Widgets/DSButtonWidget.dart';

class BillingSummaryWidget extends StatelessWidget {
  final BillingSummary billingSummary;

  const BillingSummaryWidget({super.key, required this.billingSummary});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.black12,
      child: Column(
        children: [
          // Subtotal
          _buildSummaryRow(
            'Subtotaal',
            '€ ${billingSummary.subtotal}',
            isBold: false,
          ),
          // const SizedBox(height: 8),

          // Descontos
          if (billingSummary.discounts != '0,00')
            _buildSummaryRow(
              'Je bespaart',
              '- € ${billingSummary.discounts}',
              isBold: false,
            ),
          // if (billingSummary.discounts != '0,00') const SizedBox(height: 8),

          // Frete
          _buildSummaryRow(
            'Bezorgkosten',
            billingSummary.shipping == '0,00'
                ? 'Grátis'
                : '€ ${billingSummary.shipping}',
            isBold: false,
          ),
          // const SizedBox(height: 12),

          // Total
          _buildSummaryRow(
            'Totaal',
            '€ ${billingSummary.total}',
            isBold: true,
          ),

          const SizedBox(height: 16),

          // Botão de finalizar compra
          SizedBox(
            width: double.infinity,
            child: DSButtonWidget(
              title: 'Verder naar bestellen',
              type: DSButtonType.primary,
              iconType: DSButtonIconType.cart,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    Color? color,
    bool isBold = false,
    double? fontSize = 14,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize ?? 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: color ?? Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize ?? 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: color ?? Colors.black87,
          ),
        ),
      ],
    );
  }
}
