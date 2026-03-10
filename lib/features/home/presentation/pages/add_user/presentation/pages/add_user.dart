import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jhd/core/constant/app_assets.dart';
import 'package:jhd/core/extensions/align.dart';
import 'package:jhd/core/extensions/extensions.dart';
import 'package:jhd/core/theme/app_colors.dart';
import 'package:jhd/core/validations/validations.dart';
import 'package:jhd/core/widget/custom_container.dart';
import 'package:jhd/core/widget/custom_elevated_button.dart';
import 'package:jhd/core/widget/custom_text_form_field.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/models/add_user_request_data_model.dart';
import 'package:jhd/features/home/presentation/pages/add_user/domain/entities/add_user_request.dart';
import 'package:jhd/features/home/presentation/pages/add_user/presentation/manager/add_user_cubit.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SafeArea(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.primaryColor,
                      ),
                      style: IconButton.styleFrom(
                          backgroundColor: AppColors.secondaryColor),
                    ),
                    Spacer(),
                    Image.asset(
                      AppAssets.logo,
                      height: 80,
                    ),
                  ],
                ),
              ).alignLeft(),
              CustomTextFormField(
                hintText: 'Email',
                controller: emailController,
                validate: (value) => Validations.isEmailValid(
                  value!,
                ),
              ),
              0.01.height.hSpace,
              CustomTextFormField(
                hintText: 'Name',
                controller: nameController,
                validate: (value) => Validations.isNameValid(
                  value!,
                ),
              ),
              0.01.height.hSpace,
              CustomTextFormField(
                hintText: 'Password',
                isPassword: true,
                controller: passwordController,
                validate: (value) => Validations.isPasswordValid(
                  value!,
                ),
              ),
              0.01.height.hSpace,
              CustomTextFormField(
                hintText: 'Confirm Password',
                isPassword: true,
                controller: confirmPasswordController,
                validate: (value) => (value == passwordController.text.trim())
                    ? null
                    : 'Password And Confirm Password Not Same',
              ),
              0.2.height.hSpace,
              CustomElevatedButton(
                child: Text(
                  "Add",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final AddUserRequestDataModel user =
                        AddUserRequestDataModel(
                      password: passwordController.text.trim(),
                      email: emailController.text.trim(),
                      createdAt: DateTime.now(),
                      name: nameController.text.trim(),
                      role: 'user',
                    );
                    await context.read<AddUserCubit>().addUser(user);
                  }
                },
              ),
              0.02.height.hSpace,
              BlocBuilder<AddUserCubit, AddUserState>(
                builder: (context, state) {
                  var handler = state as Handler;
                  if (handler is AddUserSuccefully) {
                    return CustomContainer(
                      child: Row(
                        children: [
                          Text(
                            'User Added Succefully',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.group_add,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    );
                  } else if (handler is AddUserFailed) {
                    return CustomContainer(
                      child: Row(
                        children: [
                          Text(
                            'User Not Added ',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.group_add,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ).hPadding(0.03.width),
        ),
      ),
    );
  }
}
