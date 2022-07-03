import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Controller/ControllerBottom.dart';
import 'BottomNavigator.dart';

class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int pageIndex = 0;
  String _currentPage = "Page1";
  List<String> pageKeys = [
    "Page1",
    "Page2",
    "Page3",
  ];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Page1": GlobalKey<NavigatorState>(),
    "Page2": GlobalKey<NavigatorState>(),
    "Page3": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 0;
  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      setState(() {
        _navigatorKeys[tabItem]!
            .currentState!
            .popUntil((route) => route.isFirst);
      });
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  ControllerBottom _controllerBottom = Get.put(ControllerBottom());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ControllerBottom>(builder: (c) {
      if (_controllerBottom.goHomePage == true) {
        _currentPage = "Page1";
        _selectedIndex = 0;
        _controllerBottom.goHomePage = false;
      }
      return Scaffold(
          bottomNavigationBar: Container(
            width: size.width,
            height: 60,
            color: Colors.transparent,
            child: Stack(
              overflow: Overflow.visible,
              children: [
                CustomPaint(
                  size: Size(size.width, 80),
                  painter: BNBCustomPainter(),
                ),
                Center(
                  heightFactor: 0.6,
                  child: FloatingActionButton(
                      heroTag: "buildbottomnaviga",
                      backgroundColor: Colors.amber,
                      child: Icon(
                        Icons.add,
                      ),
                      elevation: 0.1,
                      onPressed: () {
                        setBottomBarIndex(1);
                      }),
                ),
                Container(
                  width: size.width,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.home,
                          color: _selectedIndex == 0
                              ? Get.theme.bottomAppBarColor
                              : Colors.grey.shade400,
                          size: 28,
                        ),
                        onPressed: () {
                          setBottomBarIndex(0);
                        },
                        splashColor: Colors.white,
                      ),
                      Container(
                        width: size.width * 0.20,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.person,
                            color: _selectedIndex == 2
                                ? Get.theme.bottomAppBarColor
                                : Colors.grey.shade400,
                            size: 28,
                          ),
                          onPressed: () {
                            setBottomBarIndex(2);
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
          body: WillPopScope(
            onWillPop: () async {
              final isFirstRouteInCurrentTab =
                  !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
              if (isFirstRouteInCurrentTab) {
                if (_currentPage != "Page1") {
                  _selectTab("Page1", 1);

                  return false;
                }
              }
              // let system handle back button if we're on the first route
              return isFirstRouteInCurrentTab;
            },
            child: Stack(
              children: [
                _buildOffstageNavigator("Page1"),
                _buildOffstageNavigator("Page2"),
                _buildOffstageNavigator("Page3"),
              ],
            ),
          ));
    });
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }

  void setBottomBarIndex(int i) {
    setState(() {
      _selectTab(pageKeys[i], i);
    });
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 5); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 5);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
