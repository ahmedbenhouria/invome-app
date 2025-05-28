import 'package:Invome/presentation/home/home.dart';
import 'package:Invome/presentation/invoices/invoices.dart';
import 'package:Invome/presentation/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/configs/assets/app_images.dart';
import '../core/configs/assets/app_vectors.dart';
import '../core/configs/theme/app_colors.dart';
import 'clients/clients.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int currentIndex = 0;

  List<String> navIcons = [
    AppVectors.pieChart,
    AppVectors.document,
    AppVectors.user,
    AppVectors.setting,
  ];

  List<EdgeInsets> iconPaddings = [
    EdgeInsets.all(11),
    EdgeInsets.all(9.5),
    EdgeInsets.zero,
    EdgeInsets.fromLTRB(7, 10.5, 7, 7),
  ];

  Widget _navBar() {
    return Container(
      height: 66,
      margin: const EdgeInsets.only(right: 24, left: 24, bottom: 24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 20,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
            navIcons.map((icon) {
              int index = navIcons.indexOf(icon);
              bool isSelected = currentIndex == index;
              EdgeInsets paddingValue = iconPaddings[index];

              return Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    alignment: Alignment.center,
                    padding: paddingValue,
                    child: SvgPicture.asset(
                      icon,
                      width: 28,
                      height: 28,
                      colorFilter: ColorFilter.mode(
                        isSelected
                            ? AppColors.secondary
                            : Colors.white.withOpacity(0.9),
                        BlendMode.srcIn,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: 80.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 13,
        children: [
          ClipOval(
            child: Image.asset(
              AppImages.profileImage,
              fit: BoxFit.cover,
              height: 53,
              width: 53,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 13.5,
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
              Text(
                'Martin Butler',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Color(0xfff6f5f5),
            child: IconButton(
              color: Color(0xfff6f5f5),
              icon: SvgPicture.asset(
                AppVectors.notification,
                colorFilter: ColorFilter.mode(Colors.black45, BlendMode.srcIn),
              ),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pagesList = const [
      HomePage(),
      InvoicesPage(),
      ClientsPage(),
      SettingsPage(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          currentIndex == 0
              ? PreferredSize(
                preferredSize: const Size.fromHeight(80.0),
                child: _appBar(),
              )
              : null,
      body: Stack(
        children: [
          // Scrollable page content
          SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: kBottomNavigationBarHeight + 18,
            ), // prevent overflow
            child: pagesList[currentIndex],
          ),

          // Sticky Bottom Nav Bar
          Align(alignment: Alignment.bottomCenter, child: _navBar()),
        ],
      ),
    );
  }
}
