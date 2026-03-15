import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jhd/core/constant/app_assets.dart';
import 'package:jhd/core/extensions/extensions.dart';
import 'package:jhd/core/route/route_names.dart';
import 'package:jhd/core/services/role_based_route.dart';
import 'package:jhd/core/theme/app_colors.dart';
import 'package:jhd/features/home/presentation/manager/admin_cubit.dart';
import 'package:material_charts/material_charts.dart';
import 'package:pie_chart/pie_chart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    _getCurrentUser();
    super.initState();
  }

  User? user;
  void _getCurrentUser() {
    user = FirebaseAuth.instance.currentUser!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
          context,
          RouteNames.addUser,
        ),
        backgroundColor: AppColors.secondaryColor,
        child: const Icon(
          Icons.add,
          color: AppColors.primaryColor,
        ),
      ),
      appBar: AppBar(
        actions: const [
          ImageIcon(
            AssetImage(
              AppAssets.logo,
            ),
          ),
        ],
        title: Text(
          "Welcome ${user?.displayName ?? "User"}",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        backgroundColor: AppColors.primaryColor,
        child: SafeArea(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 65,
                backgroundImage: NetworkImage(
                  "https://i.pinimg.com/736x/89/90/e0/8990e0304c44794197af164ab0138011.jpg",
                ),
              ),
              0.02.height.hSpace,
              ListTile(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteNames.collections,
                  );
                },
                title: const Row(
                  children: [
                    Text(
                      "Categories",
                    ),
                    Spacer(),
                    Icon(Icons.collections)
                  ],
                ),
              ),
              0.02.height.hSpace,
              ListTile(
                onTap: RoleBasedRoute().logout,
                title: const Row(
                  children: [
                    Text(
                      "Logout",
                    ),
                    Spacer(),
                    Icon(
                      Icons.logout,
                      color: Colors.red,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<AdminCubit, AdminState>(
          builder: (context, state) {
            if (state is AdminSuccess) {
              return SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    0.02.height.hSpace,
                    Text(
                      'Insight Reports',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    PieChart(
                      initialAngleInDegree: 20,
                      chartRadius: 250,
                      dataMap: state.budgets,
                    ),
                    0.02.height.hSpace,
                    const Divider(),
                    Text(
                      'Most Orders',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    MaterialBarChart(
                      style: const BarChartStyle(
                        barColor: Colors.black,
                      ),
                      showGrid: true,
                      showValues: true,
                      horizontalGridLines: 8,
                      data: state.orderDetails
                          .map(
                            (e) => BarChartData(
                              value: e.values.first,
                              label: e.keys.first.toString(),
                            ),
                          )
                          .toList(),
                      width: 10,
                      height: 300,
                    ),
                    const Divider(),
                    0.02.height.hSpace,
                    Text(
                      'Users ',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    ListView.separated(
                      itemBuilder: (context, index) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        hoverColor: Colors.black,
                        title: Row(
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                'https://i.pinimg.com/736x/89/90/e0/8990e0304c44794197af164ab0138011.jpg',
                              ),
                            ),
                            const Spacer(),
                            Text(
                              state.users[index].name,
                            ),
                          ],
                        ),
                        onTap: () => Navigator.pushNamed(
                          context,
                          RouteNames.userDetails,
                          arguments: state.users[index],
                        ),
                      ),
                      separatorBuilder: (context, index) => 0.01.height.hSpace,
                      itemCount: state.users.length,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                  ],
                ),
              );
            } else if (state is AdminFailed) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  0.35.height.hSpace,
                  const Icon(
                    Icons.error_outline_rounded,
                    color: Colors.grey,
                    size: 80,
                  ),
                  0.02.height.hSpace,
                  Text(
                    state.errorMessage,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  )
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ).hPadding(0.03.width),
    );
  }
}
