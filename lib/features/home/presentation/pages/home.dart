import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:jhd/core/constant/app_assets.dart';
import 'package:jhd/core/extensions/extensions.dart';
import 'package:jhd/core/extensions/padding.dart';
import 'package:jhd/core/route/route_names.dart';
import 'package:jhd/core/theme/app_colors.dart';
import 'package:jhd/features/home/presentation/pages/add_user/presentation/pages/add_user.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:route_transitions/route_transitions.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final dataMap = <String, double>{
    "John": 50,
    "Andro Adel": 3200,
    "Jasmin": 200,
    'Rawan': 1222,
  };

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
                    "https://www.google.com/url?sa=t&source=web&rct=j&url=https%3A%2F%2Fmicrobiology.ucr.edu%2Fimage%2Fprofile-image-placeholder&ved=0CBYQjRxqFwoTCNCrvcSOlJMDFQAAAAAdAAAAABAm&opi=89978449"),
              ),
              0.02.height.hSpace,
              ListTile(
                onTap: () {},
                title: const Row(
                  children: [
                    Text(
                      "Users",
                    ),
                    Spacer(),
                    Icon(Icons.person_2_outlined)
                  ],
                ),
              ),
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
                onTap: () {},
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
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PieChart(dataMap: dataMap),
              0.02.height.hSpace,
              const Divider(),
              0.02.height.hSpace,
              Text(
                'Users Reports',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              ListView.separated(
                itemBuilder: (context, index) => const ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          'https://scontent-hbe1-1.xx.fbcdn.net/v/t39.30808-6/475437101_9038149546260938_7908073895246431393_n.jpg?stp=cp6_dst-jpg_tt6&_nc_cat=111&ccb=1-7&_nc_sid=53a332&_nc_ohc=Wf0Pp7ioejcQ7kNvwHZa3bp&_nc_oc=Adm5B4cRsMbzLaqdo-4dSwQtmXM7qV1KV38ZnpV-jB2_ipcZAwtv-3xr1aZ0sYI-EpI&_nc_zt=23&_nc_ht=scontent-hbe1-1.xx&_nc_gid=2YrVQPX7PY0DIl6Ms4EMhw&_nc_ss=8&oh=00_Afx22PPS9784ESfuGx6wujb1EMmV7aqNhnqRdaeqE9mTcw&oe=69B55BB0',
                        ),
                      ),
                      Spacer(),
                      Text('John Adel')
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => Divider(),
                itemCount: 10,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ],
          ),
        ),
      ).hPadding(0.03.width),
    );
  }
}
