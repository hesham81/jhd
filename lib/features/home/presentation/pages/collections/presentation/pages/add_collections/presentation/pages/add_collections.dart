import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jhd/core/constant/app_assets.dart';
import 'package:jhd/core/extensions/align.dart';
import 'package:jhd/core/extensions/dimensions.dart';
import 'package:jhd/core/extensions/extensions.dart';
import 'package:jhd/core/extensions/padding.dart';
import 'package:jhd/core/theme/app_colors.dart';
import 'package:jhd/core/validations/validations.dart';
import 'package:jhd/core/widget/custom_elevated_button.dart';
import 'package:jhd/core/widget/custom_text_form_field.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/models/category_data_model.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/presentation/manager/add_category_cubit.dart';

class AddCollections extends StatefulWidget {
  const AddCollections({super.key});

  @override
  State<AddCollections> createState() => _AddCollectionsState();
}

class _AddCollectionsState extends State<AddCollections> {
  var categoryNameController = TextEditingController();
  var categoryPriceController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
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
                    const Spacer(),
                    Image.asset(
                      AppAssets.logo,
                      height: 80,
                    ),
                  ],
                ).alignLeft(),
              ),
              0.01.height.hSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  0.05.height.hSpace,
                  CustomTextFormField(
                    hintText: 'Category Name',
                    validate: (value) => Validations.isNameValid(
                      value!,
                    ),
                    controller: categoryNameController,
                  ),
                  0.03.height.hSpace,
                  CustomTextFormField(
                    hintText: 'Category Price',
                    suffixIcon: Icons.attach_money_outlined,
                    validate: (value) => Validations.isNameValid(
                      value!,
                    ),
                    controller: categoryPriceController,
                    keyboardType: const TextInputType.numberWithOptions(),
                  ),
                  0.12.height.hSpace,
                  CustomElevatedButton(
                    child: Text(
                      'Confirm',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        CategoryDataModel category = CategoryDataModel(
                          name: categoryNameController.text.trim(),
                          price: double.parse(
                            categoryPriceController.text.trim(),
                          ) as double,
                        );
                        await context.read<AddCategoryCubit>().addCategory(
                              category,
                            );
                      }
                    },
                  ),
                ],
              ).hPadding(0.03.width),
            ],
          ),
        ),
      ),
    );
  }
}
