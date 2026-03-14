import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:jhd/core/constant/app_assets.dart';
import 'package:jhd/core/extensions/extensions.dart';
import 'package:jhd/core/theme/app_colors.dart';
import 'package:jhd/core/widget/custom_elevated_button.dart';
import 'package:jhd/core/widget/custom_text_form_field.dart';

class PayWithVisaCard extends StatefulWidget {
  const PayWithVisaCard({super.key});

  @override
  State<PayWithVisaCard> createState() => _PayWithVisaCardState();
}

class _PayWithVisaCardState extends State<PayWithVisaCard> {
  var cardNumber = TextEditingController();
  var expiryDate = TextEditingController();
  var cardHolderName = TextEditingController();
  var cvvCode = TextEditingController();
  var isFocused = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(
                      context,
                    ),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.primaryColor,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                    ),
                    alignment: Alignment.center,
                  ),
                  Text(
                    'Add Custom Order',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Image.asset(
                    AppAssets.logo,
                    height: 80,
                  ),
                ],
              ),
            ),
            CreditCardWidget(
              cardBgColor: AppColors.secondaryColor,
              cardNumber: cardNumber.text,
              expiryDate: expiryDate.text,
              enableFloatingCard: true,
              cardHolderName: (cardHolderName.text.isEmpty)
                  ? 'Hisham Aymen'
                  : cardHolderName.text,
              glassmorphismConfig: Glassmorphism(
                blurX: 10.0,
                blurY: 10.0,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Colors.red,
                    AppColors.secondaryColor,
                  ],
                  stops: <double>[
                    0.3,
                    0,
                  ],
                ),
              ),
              cvvCode: cvvCode.text,
              isHolderNameVisible: true,
              showBackView:
                  isFocused, //true when you want to show cvv(back) view
              onCreditCardWidgetChange: (
                CreditCardBrand brand,
              ) {}, // Callback for anytime credit card brand is changed
              padding: 0,
            ),
            0.01.height.hSpace,
            CustomTextFormField(
              hintText: 'Card Number',
              controller: cardNumber,
              onChanged: (value) {
                setState(() {});
              },
            ),
            0.01.height.hSpace,
            CustomTextFormField(
              hintText: 'Card Holder Name',
              controller: cardHolderName,
              onChanged: (value) {
                setState(() {});
              },
            ),
            0.01.height.hSpace,
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    hintText: 'CVV',
                    controller: cvvCode,
                    onEditingComplete: () => setState(
                      () {
                        isFocused = false;
                      },
                    ),
                    onChanged: (value) {
                      isFocused = (value!.isEmpty) ? false : true;
                      setState(() {});
                    },
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: CustomTextFormField(
                    hintText: 'ExpiryDate',
                    controller: expiryDate,
                    onChanged: (value) {
                      setState(
                        () {},
                      );
                      return null;
                    },
                  ),
                ),
              ],
            ),
            0.01.height.hSpace,
            CustomElevatedButton(
                onPressed: () {},
                child: Text(
                  'Confirm',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ))
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
