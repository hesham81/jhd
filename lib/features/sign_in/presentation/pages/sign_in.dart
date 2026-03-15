import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jhd/core/constant/app_assets.dart';
import 'package:jhd/core/extensions/extensions.dart';
import 'package:jhd/core/theme/app_colors.dart';
import 'package:jhd/core/validations/validations.dart';
import 'package:jhd/core/widget/custom_elevated_button.dart';
import 'package:jhd/core/widget/custom_text_form_field.dart';
import 'package:jhd/features/sign_in/domain/entities/sign_in_request.dart';

import 'package:jhd/features/sign_in/presentation/manager/sign_in_cubit.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignInCubit>();
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SafeArea(
              child: Row(
                children: [
                  Image.asset(
                    AppAssets.logo,
                    height: 80,
                    width: 80,
                  ),
                ],
              ),
            ),
            0.2.height.hSpace,
            Text(
              "Email",
              style: Theme
                  .of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomTextFormField(
              hintText: "",
              controller: emailController,
              validate: (value) => Validations.isEmailValid(value!),
              suffixIcon: Icons.mail_outline,
            ),
            0.01.height.hSpace,
            Text(
              "Password",
              style: Theme
                  .of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomTextFormField(
              hintText: "",
              controller: passwordController,
              isPassword: true,
              validate: (value) => Validations.isPasswordValid(value!),
            ),
            0.03.height.hSpace,
            CustomElevatedButton(
                child: Text(
                  "Sign In",
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: AppColors.primaryColor),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    var signInModel = SignInRequest(emailController.text.trim(),
                        passwordController.text.trim());
                    await cubit.signIn(data: signInModel);
                  }
                }
            ),
            const Spacer(),
            SafeArea(
              child: Text(
                'Presented By : Hisham Aymen \n To John Adel Hairdresser\n2026',
                textAlign: TextAlign.center,
                style: Theme
                    .of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(
                  color: AppColors.secondaryColor!.withAlpha(90),
                ),
              ),
            )
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
