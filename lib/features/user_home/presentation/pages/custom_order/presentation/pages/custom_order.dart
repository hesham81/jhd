import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:jhd/features/user_home/presentation/pages/custom_order/data/models/order_data_model.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/presentation/manager/add_order_cubit.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/presentation/widgets/order_widget.dart';

class CustomOrder extends StatefulWidget {
  const CustomOrder({super.key});

  @override
  State<CustomOrder> createState() => _CustomOrderState();
}

class _CustomOrderState extends State<CustomOrder> {
  final TextEditingController clientName = TextEditingController();
  final TextEditingController clientPhoneNumber = TextEditingController();
  final TextEditingController description = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    clientName.dispose();
    clientPhoneNumber.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: BlocBuilder<AddOrderCubit, AddOrderState>(
            builder: (context, state) {
              if (state is AddOrderInitial ||
                  state is UpdateAllCategories ||
                  state is UpdateCategory) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    0.05.height.hSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
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
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Image.asset(
                          AppAssets.logo,
                          height: 80,
                        ),
                      ],
                    ),
                    0.02.height.hSpace,
                    OrderWidget(
                      list: state.allCategories,
                      onTap: (selected) {
                        context
                            .read<AddOrderCubit>()
                            .updateSelectedCategories(selected);
                      },
                    ),
                    0.02.height.hSpace,
                    CustomTextFormField(
                      hintText: 'Client Name',
                      controller: clientName,
                      validate: (value) => Validations.isNameValid(value!),
                    ),
                    0.02.height.hSpace,
                    CustomTextFormField(
                      hintText: 'Client Phone Number',
                      controller: clientPhoneNumber,
                      validate: (value) =>
                          Validations.isEgyptianPhoneValid(value!),
                    ),
                    0.02.height.hSpace,
                    CustomTextFormField(
                      hintText: 'Description',
                      controller: description,
                      validate: (value) =>
                          Validations.isDescriptionValid(value!),
                      maxLine: 7,
                      minLine: 7,
                    ),
                    0.04.height.hSpace,
                    Row(
                      children: [
                        Text(
                          'Total Amount',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const Spacer(),
                        Text(
                          '${state.totalAmount.roundToDouble()} EGP',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                        ),
                      ],
                    ),
                    0.01.height.hSpace,
                    CustomElevatedButton(
                      child: Text(
                        'Confirm Order',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final OrderDataModel order = OrderDataModel(
                            clientName: clientName.text.trim(),
                            clientPhoneNumber: clientPhoneNumber.text.trim(),
                            id: FirebaseAuth.instance.currentUser!.uid,
                            description: description.text.trim(),
                            tasks: state.categories,
                            totalOrder: state.totalAmount,
                          );
                          log('This is the order ${order.toJson()}');

                          context.read<AddOrderCubit>().addOrder(order);
                        }
                      },
                    ),
                  ],
                ).hPadding(0.03.width);
              } else if (state is AddOrderFailed) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    0.3.height.hSpace,
                    const Icon(
                      Icons.error_outline_outlined,
                      color: Colors.grey,
                      size: 80,
                    ),
                    0.02.height.hSpace,
                    Text(
                      state.error,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ).center;
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
