import 'package:fortestpages/pages/worker/craft_home_screen/waited_tap.dart';
import 'package:fortestpages/pages/worker/craft_profile_editing/craft_profile_editing.dart';
import 'package:flutter/material.dart';

import 'accepted_tab.dart';

class CraftHomeScreen extends StatelessWidget {
  const CraftHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          color: Colors.grey[350],
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    color: const Color.fromRGBO(217, 173, 48, 1),
                  ),
                  height: 127.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(
                          right: 20.0,
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
                                    const CraftProfileEditing(),
                              ),
                            );
                          },
                        ),
                      ),

                    ],
                  ),
                ),
                Positioned(
                  left: 20.0,
                  top: 95.0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color.fromRGBO(47, 52, 76, 1),
                    ),
                    width: 320.0,
                    height: 90.0,
                    child: Row(children: [
                      Container(
                        width: 152.0,
                        color: Colors.transparent,
                        child: const Text(
                          'الطلبات تنتظرك! باشر عملك الان',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              height: 1.0),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        width: 158.0,
                        height: 85.0,
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
              margin: const EdgeInsets.only(
                top: 60.0,
              ),
              child: const TabBar(
                tabs: [
                  Tab(
                    child: Text(
                      'الطلبات المنتظره',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'الطلبات الجاريه',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontSize: 20,
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
