import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/payment_controller.dart';
import '../widgets/custom_text_field.dart'; // For a more organized approach

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: ChangeNotifierProvider(
        create: (_) => PaymentController(),
        child: Consumer<PaymentController>(
          builder: (context, controller, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Amount to Pay: \$${controller.amountToPay.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      controller: controller.cardNumberController,
                      labelText: 'Card Number',
                      hintText: 'xxxx xxxx xxxx xxxx',
                      keyboardType: TextInputType.number,
                      validator: controller.validateCardNumber,
                      onChanged: (value) {
                        // Add spaces for readability
                        if (value.length % 4 == 0 && value.length < 19 && value.isNotEmpty && !value.endsWith(' ')) {
                          controller.cardNumberController.text = '${value} ';
                          controller.cardNumberController.selection = TextSelection.fromPosition(
                            TextPosition(offset: controller.cardNumberController.text.length),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: controller.expiryDateController,
                            labelText: 'Expiry Date',
                            hintText: 'MM/YY',
                            keyboardType: TextInputType.number,
                            validator: controller.validateExpiryDate,
                            onChanged: (value) {
                              if (value.length == 2 && !value.contains('/')) {
                                controller.expiryDateController.text = '$value/';
                                controller.expiryDateController.selection = TextSelection.fromPosition(
                                  TextPosition(offset: controller.expiryDateController.text.length),
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomTextField(
                            controller: controller.cvvController,
                            labelText: 'CVV',
                            hintText: 'XXX',
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            validator: controller.validateCvv,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: controller.cardHolderNameController,
                      labelText: 'Card Holder Name',
                      hintText: 'John Doe',
                      keyboardType: TextInputType.name,
                      validator: controller.validateCardHolderName,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: controller.isLoading ? null : () => controller.processPayment(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Button color
                        foregroundColor: Colors.white, // Text color
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: controller.isLoading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : const Text(
                              'Pay Now',
                              style: TextStyle(fontSize: 18),
                            ),
                    ),
                    if (controller.paymentStatusMessage != null) ...[
                      const SizedBox(height: 24),
                      Text(
                        controller.paymentStatusMessage!,
                        style: TextStyle(
                          color: controller.paymentStatusMessage!.contains('successful')
                              ? Colors.green.shade700
                              : Colors.red.shade700,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}