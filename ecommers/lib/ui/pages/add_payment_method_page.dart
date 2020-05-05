import 'package:ecommers/core/common/payment_method_validator.dart';
import 'package:ecommers/core/provider_models/payment_method_provider_model.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/utils/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class AddPaymentMethodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<PaymentMethodProviderModel>(context, listen: false);
    return Scaffold(
      backgroundColor: BrandingColors.pageBackground,
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Insets.x4, horizontal: Insets.x6),
          child: Column(
            children: <Widget>[
              Center(
                child: Image.asset(
                  Assets.bigCreditCard,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: Insets.x4),
              CreditCardTextField(
                hintText: localization.creditCardNumberPlaceHolder,
                maxLength: 19,
                inputFormatters: [
                  MaskTextInputFormatter(
                    mask: '####-####-####-####',
                    filter: {'#': RegExp(PaymentMethodValidator.digitPattern)},
                  ),
                ],
                onChanged: (text) => provider.creditCard.number = text,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: Insets.x4),
              CreditCardTextField(
                hintText: localization.namePlaceHolder,
                onChanged: (text) => provider.creditCard.name = text,
                maxLength: 26,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: Insets.x4),
              Row(
                children: <Widget>[
                  CreditCardTextField(
                    width: 158.0,
                    hintText: localization.exprDatePlaceHolder,
                    inputFormatters: [
                      MaskTextInputFormatter(
                        mask: 'f#/##',
                        filter: {
                          'f': RegExp(PaymentMethodValidator.firstSymbolDatePattern),
                          '#': RegExp(PaymentMethodValidator.digitPattern)
                        },
                      ),
                    ],
                    onChanged: (text) => provider.expDate = text,
                    maxLength: 5,
                    keyboardType: TextInputType.datetime,
                  ),
                  const Spacer(),
                  CreditCardTextField(
                    width: 104.0,
                    hintText: localization.cvc,
                    maxLength: 3,
                    inputFormatters: [
                      MaskTextInputFormatter(
                        mask: '###',
                        filter: {
                          '#': RegExp(PaymentMethodValidator.digitPattern)
                        },
                      ),
                    ],
                    onChanged: (text) => provider.creditCard.cvc = text,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
              const SizedBox(height: Insets.x4),
              SizedBox(
                height: 46.0,
                child: PrimaryButtonWidget(
                  onPressedFunction: () async => provider.addPaymentMethod(),
                  text: localization.addCardDetails,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
