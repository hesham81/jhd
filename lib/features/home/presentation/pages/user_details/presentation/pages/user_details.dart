import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jhd/core/constant/app_assets.dart';
import 'package:jhd/core/extensions/extensions.dart';
import 'package:jhd/core/theme/app_colors.dart';
import 'package:jhd/core/validations/date_from.dart';
import 'package:jhd/core/widget/custom_elevated_button.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/models/add_user_request_data_model.dart';
import 'package:jhd/features/home/presentation/pages/user_details/presentation/manager/user_details_cubit.dart';

class UserDetails extends StatefulWidget {
  final AddUserRequestDataModel userRequestDataModel;
  const UserDetails({
    super.key,
    required this.userRequestDataModel,
  });

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          ImageIcon(
            AssetImage(
              AppAssets.logo,
            ),
          ),
        ],
        title: Text(
          '${widget.userRequestDataModel.name} Edit',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://i.pinimg.com/736x/89/90/e0/8990e0304c44794197af164ab0138011.jpg',
            ),
            0.02.height.hSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Email : ${widget.userRequestDataModel.email}',
                  style: Theme.of(context).textTheme!.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                0.02.height.hSpace,
                Text(
                  'Name : ${widget.userRequestDataModel.name}',
                  style: Theme.of(context).textTheme!.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                0.02.height.hSpace,
                Text(
                  'Created At : ${DateFrom.handleDateFrom(date: widget.userRequestDataModel.createdAt)}',
                  style: Theme.of(context).textTheme!.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                0.02.height.hSpace,
                Text(
                  'Password : ${widget.userRequestDataModel.password}',
                  style: Theme.of(context).textTheme!.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                0.02.height.hSpace,
                Text(
                  'Role : ${widget.userRequestDataModel.role}',
                  style: Theme.of(context).textTheme!.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                0.02.height.hSpace,
                BlocBuilder<UserDetailsCubit, UserDetailsState>(
                  builder: (context, state) {
                    if (state is UserDetailsInitial ||
                        state is UserDetailsError) {
                      return Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButton(
                              child: Text(
                                'Back',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor,
                                    ),
                              ),
                              onPressed: () => Navigator.pop(
                                context,
                              ),
                            ),
                          ),
                          0.02.width.vSpace,
                          Expanded(
                            child: CustomElevatedButton(
                              child: Text(
                                'Delete',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                              ),
                              onPressed: () async =>
                                  context.read<UserDetailsCubit>().deleteUser(
                                        widget.userRequestDataModel.uid,
                                      ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ).hPadding(0.03.width),
          ],
        ),
      ),
    );
  }
}
