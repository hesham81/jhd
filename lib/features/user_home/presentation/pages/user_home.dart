import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jhd/core/constant/app_assets.dart';
import 'package:jhd/core/extensions/align.dart';
import 'package:jhd/core/extensions/dimensions.dart';
import 'package:jhd/core/extensions/extensions.dart';
import 'package:jhd/core/extensions/padding.dart';
import 'package:jhd/core/route/route_names.dart';
import 'package:jhd/core/theme/app_colors.dart';
import 'package:jhd/core/widget/custom_container.dart';
import 'package:jhd/features/user_home/presentation/manager/user_home_cubit.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
          context,
          RouteNames.customOrder,
        ),
        backgroundColor: AppColors.secondaryColor,
        child: const Icon(
          Icons.add,
          color: AppColors.primaryColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Image.asset(
                AppAssets.logo,
                height: 80,
              ),
            ),
            BlocBuilder<UserHomeCubit, UserHomeState>(
              builder: (
                context,
                state,
              ) {
                if (state is UserHomeInitial || state is UserHomeFailed) {
                  return const SizedBox();
                } else if (state is UserHomeLoaded) {
                  return GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemBuilder: (
                      context,
                      index,
                    ) =>
                        CustomContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.data[index].name[0].toUpperCase(),
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge!.copyWith(
                                  color: AppColors.secondaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          0.01.height.hSpace,
                          Text(
                            state.data[index].name,
                            style: Theme.of(
                              context,
                            ).textTheme.labelMedium!.copyWith(
                                  color: AppColors.secondaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                    itemCount: state.data.length,
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            0.2.height.hSpace,
            SafeArea(
              child: Text(
                'Presented By : Hisham Aymen \n To John Adel Hairdresser\n2026',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppColors.secondaryColor!.withAlpha(90),
                    ),
              ),
            ).center
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
