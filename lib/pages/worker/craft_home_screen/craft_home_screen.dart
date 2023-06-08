import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortestpages/pages/worker/craft_home_screen/waited_tap.dart';
import 'package:fortestpages/pages/worker/craft_profile_editing/craft_profile_editing.dart';
import 'package:flutter/material.dart';

import '../craft_profile_editing/settings.dart';
import 'accepted_tab.dart';

class CraftHomeScreen extends StatelessWidget {
  const CraftHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          color: Colors.grey[250],
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0).r,
                    color: const Color.fromRGBO(217, 173, 48, 1),
                  ),
                  height: 117.0.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      Padding(
                        padding: EdgeInsets.only(
                          right: 20.0.r,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.settings,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CraftSetting(),
                              ),
                            );
                          },
                        ),
                      ),

                    ],
                  ),
                ),
                Positioned(
                  left: 20.0.r,
                  top: 95.0.r,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0).r,
                      color: const Color.fromRGBO(47, 52, 76, 1),
                    ),
                    width: 320.0.w,
                    height: 90.0.h,
                    child: Row(children: [
                      Container(
                        width: 152.0.w,
                        color: Colors.transparent,
                        child: Text(
                          'الطلبات تنتظرك! باشر عملك الان',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0.sp,
                              height: 1.0.h),
                        ),
                      ),
                       SizedBox(
                        width: 10.0.w,
                      ),
                      Container(
                        width: 158.0.w,
                        height: 85.0.h,
                        color: Colors.transparent,
                        child: const Image(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'assets/scientific-research.png',
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                top: 65.0.r,
              ),
              child: TabBar(
                indicatorColor: const Color.fromRGBO(217, 173, 48, 1),
                tabs: [
                  Tab(
                    child: Text(
                      'الطلبات المنتظره',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'الطلبات الجاريه',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(children: [
                WaitedTap(),
                AcceptedTap(),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
