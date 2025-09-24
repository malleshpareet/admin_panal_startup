import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/routes/app_pages.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          Expanded(
            child: ListView(
              children: [
                DrawerListTile(
                  title: "Dashboard",
                  svgSrc: "assets/icons/menu_dashboard.svg",
                  press: () {
                    context.mainScreenProvider.navigateToScreen('Dashboard');
                  },
                ),
                DrawerListTile(
                  title: "Category",
                  svgSrc: "assets/icons/menu_tran.svg",
                  press: () {
                    context.mainScreenProvider.navigateToScreen('Category');
                  },
                ),
                DrawerListTile(
                  title: "Sub Category",
                  svgSrc: "assets/icons/menu_task.svg",
                  press: () {
                    context.mainScreenProvider.navigateToScreen('SubCategory');
                  },
                ),
                DrawerListTile(
                  title: "Brands",
                  svgSrc: "assets/icons/menu_doc.svg",
                  press: () {
                    context.mainScreenProvider.navigateToScreen('Brands');
                  },
                ),
                DrawerListTile(
                  title: "Variant Type",
                  svgSrc: "assets/icons/menu_store.svg",
                  press: () {
                    context.mainScreenProvider.navigateToScreen('VariantType');
                  },
                ),
                DrawerListTile(
                  title: "Variants",
                  svgSrc: "assets/icons/menu_notification.svg",
                  press: () {
                    context.mainScreenProvider.navigateToScreen('Variants');
                  },
                ),
                DrawerListTile(
                  title: "Orders",
                  svgSrc: "assets/icons/menu_profile.svg",
                  press: () {
                    context.mainScreenProvider.navigateToScreen('Order');
                  },
                ),
                DrawerListTile(
                  title: "Coupons",
                  svgSrc: "assets/icons/menu_setting.svg",
                  press: () {
                    context.mainScreenProvider.navigateToScreen('Coupon');
                  },
                ),
                DrawerListTile(
                  title: "Posters",
                  svgSrc: "assets/icons/menu_doc.svg",
                  press: () {
                    context.mainScreenProvider.navigateToScreen('Poster');
                  },
                ),
                // DrawerListTile(
                //   title: "Notifications",
                //   svgSrc: "assets/icons/menu_notification.svg",
                //   press: () {
                //     context.mainScreenProvider.navigateToScreen('Notifications');
                //   },
                // ),
              ],
            ),
          ),
          ListTile(
            onTap: () async {
              // Show confirmation dialog before logout
              bool shouldLogout = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirm Logout'),
                        content: Container(
                          width: 300, // Bigger width for web
                          child: Text('Are you sure you want to logout?'),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: Text('Logout'),
                          ),
                        ],
                      );
                    },
                  ) ??
                  false;

              // If user confirmed, then logout
              if (shouldLogout) {
                Get.offAllNamed(AppPages.LOGIN);
              }
            },
            horizontalTitleGap: 0.0,
            leading: Icon(
              Icons.logout,
              color: Colors.white54,
              size: 16,
            ),
            title: Text(
              "Logout",
              style: TextStyle(color: Colors.white54),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
