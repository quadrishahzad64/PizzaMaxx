import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'Aboutus.dart';
import 'ColorClass.dart';
import 'Icecream.dart';
import 'Login.dart';
import 'Pizza.dart';


class AppHomePage extends StatefulWidget {
   const AppHomePage({Key? key, }) : super(key: key); // Modify this line

  @override
  State<AppHomePage> createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final NotchBottomBarController _controller = NotchBottomBarController(index: 0);

  int maxCount = 5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// widget list
    final List<Widget> bottomBarPages = [
      Pizza(),
      const IceCream(),
      LoginScreen(),
      const AboutUs(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Pizza Max',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.yellow[100],
            fontSize: 40,
            shadows: [
              Shadow(
                color: Colors.yellow,
                offset: Offset(3.0, 3.0),
                blurRadius: 3.0,
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        color: Colors.red,
        showLabel: true,
        textOverflow: TextOverflow.visible,
        maxLine: 1,
        shadowElevation: 5,
        kBottomRadius: 28.0,
        notchColor: DesignColor.notchColors,
        removeMargins: false,
        bottomBarWidth: 500,
        showShadow: false,
        durationInMilliSeconds: 300,
        itemLabelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        elevation: 1,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.local_pizza,
              color: DesignColor.yelloColors1,
            ),
            activeItem: Icon(
              Icons.local_pizza,
              color: DesignColor.yelloColors2,
            ),
            itemLabel: 'Pizzas',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.ac_unit_rounded, color: DesignColor.yelloColors1),
            activeItem: Icon(
              Icons.ac_unit_rounded,
              color: DesignColor.yelloColors2,
            ),
            itemLabel: 'IceCreame',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.login, color: DesignColor.yelloColors1),
            activeItem: Icon(
              Icons.ac_unit_rounded,
              color: DesignColor.yelloColors2,
            ),
            itemLabel: 'Login',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.person, color: DesignColor.yelloColors1),
            activeItem: Icon(
              Icons.person,
              color: DesignColor.yelloColors2,
            ),
            itemLabel: 'About Us',
          ),
        ],
        onTap: (index) {
          log('current selected index $index');
          _pageController.jumpToPage(index);
        },
        kIconSize: 24.0,
      )
          : null,
    );
  }
}
/// add controller to check weather index through change or not. in page 1
class Page1 extends StatelessWidget {
  final NotchBottomBarController? controller;

  const Page1({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesignColor.yelloColors,
      child: Center(
        /// adding GestureDetector
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            controller?.jumpTo(2);

          },
          child: const Text('Page 1'),
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(color: DesignColor.yelloColors, child: const Center(child: Text('Page no')));
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: DesignColor.yelloColors, child: const Center(child: Text('Page 3')));
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: DesignColor.yelloColors, child: const Center(child: Text('Page 4')));
  }
}

class Page5 extends StatelessWidget {
  const Page5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: DesignColor.yelloColors, child: const Center(child: Text('Page 5')));
  }
}
