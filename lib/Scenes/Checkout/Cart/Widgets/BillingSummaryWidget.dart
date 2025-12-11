import 'package:flutter/material.dart';
import 'package:ofm_demo/Commons/Models/CartModel.dart';

class BillingSummaryWidget extends StatelessWidget {
  final BillingSummary billingSummary;

  const BillingSummaryWidget({super.key, required this.billingSummary});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Subtotal
          _buildSummaryRow(
            'Subtotal',
            '€ ${billingSummary.subtotal}',
            isBold: false,
          ),
          const SizedBox(height: 8),

          // Descontos
          if (billingSummary.discounts != '0,00')
            _buildSummaryRow(
              'Descontos',
              '- € ${billingSummary.discounts}',
              color: Colors.red,
              isBold: false,
            ),
          if (billingSummary.discounts != '0,00') const SizedBox(height: 8),

          // Frete
          _buildSummaryRow(
            'Frete',
            billingSummary.shipping == '0,00'
                ? 'Grátis'
                : '€ ${billingSummary.shipping}',
            color: billingSummary.shipping == '0,00' ? Colors.green : null,
            isBold: false,
          ),
          const SizedBox(height: 12),

          // Divider
          const Divider(thickness: 1),
          const SizedBox(height: 12),

          // Total
          _buildSummaryRow(
            'Total',
            '€ ${billingSummary.total}',
            isBold: true,
            fontSize: 18,
          ),

          const SizedBox(height: 16),

          // Botão de finalizar compra
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implementar navegação para checkout
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Finalizar Compra',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    Color? color,
    bool isBold = false,
    double? fontSize,
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
