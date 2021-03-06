import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShippingAddressTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final String Function(String) onValidate;
  final Function(String) onChanged;
  final double width;
  final int maxLength;
  final bool isValid;

  const ShippingAddressTextField({
    this.labelText = '',
    this.keyboardType = TextInputType.text,
    this.controller,
    this.onValidate,
    this.onChanged,
    this.width,
    this.maxLength = 26,
    this.isValid = true,
  });

  @override
  Widget build(BuildContext context) {
    return SurfaceContainer(
      height: 65.0,
      width: width,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
        child: TextFormField(
          textAlign: TextAlign.left,
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
          validator: onValidate,
          maxLength: maxLength,
          maxLengthEnforced: true,
          decoration: InputDecoration(
            counterText: '',
            labelText: labelText,
            counterStyle: const TextStyle(fontSize: 0),
            border: InputBorder.none,
            hintStyle: textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: FontSizes.small_3x,
                color: BrandingColors.primaryText.withOpacity(0.5)),
            errorText:
                isValid ?? true ? null : localization.errorMessageShippingAddress,
            errorStyle: TextStyle(color: Colors.red[300]),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red[300],
                style: BorderStyle.solid,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
