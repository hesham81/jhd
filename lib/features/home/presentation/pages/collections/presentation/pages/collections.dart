import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jhd/core/constant/app_assets.dart';
import 'package:jhd/core/extensions/align.dart';
import 'package:jhd/core/extensions/dimensions.dart';
import 'package:jhd/core/extensions/extensions.dart';
import 'package:jhd/core/extensions/padding.dart';
import 'package:jhd/core/route/route_names.dart';
import 'package:jhd/core/theme/app_colors.dart';
import 'package:jhd/core/validations/validations.dart';
import 'package:jhd/core/widget/custom_container.dart';
import 'package:jhd/core/widget/custom_elevated_button.dart';
import 'package:jhd/core/widget/custom_text_form_field.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/manager/get_all_categorise_cubit.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final categoryNameController = TextEditingController();
  final categoryPriceController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
          context,
          RouteNames.addCollections,
        ),
        backgroundColor: AppColors.secondaryColor,
        child: const Icon(
          Icons.ad_units,
          color: AppColors.primaryColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              0.05.height.hSpace,
              Row(
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
              0.02.height.hSpace,
              const CupertinoSearchTextField(),
              0.02.height.hSpace,
              BlocBuilder<GetAllCategoriseCubit, GetAllCategoriseState>(
                builder: (context, state) {
                  if (state is GetAllCategoriseInitial) {
                    return const SizedBox();
                  } else if (state is GetAllCategoriseSuccefully) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => CustomContainer(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Text(
                              state.listOfCategories[index].name,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: AppColors.secondaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Spacer(),
                            Text(
                              '${state.listOfCategories[index].price} EGP',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: state.listOfCategories.length,
                      padding: EdgeInsets.zero,
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ).hPadding(
            0.03.width,
          ),
        ),
      ),
    );
  }
}
