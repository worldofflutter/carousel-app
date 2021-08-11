import 'package:advance_carousal/constant/data.dart';
import 'package:flutter/material.dart';

final imagesList = [
  "assets/images/newyork.jpg",
  "assets/images/capetown.jpg",
  "assets/images/switzerland.jpg",
];

final colorList = [
  Colors.redAccent.shade100,
  Colors.blueAccent.shade100,
  Colors.green
];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: currentPage, viewportFraction: 0.7);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * .7,
            child: PageView.builder(
              controller: _pageController,
              pageSnapping: true,
              onPageChanged: _pageChange,
              itemCount: 3,
              itemBuilder: (context, index) {
                return iteamBuilder(index);
              },
            ),
          ),
          details(currentPage)
        ],
      )),
    );
  }

  Widget details(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = (_pageController.page - index);
          value = (1 - (value.abs() * 1)).clamp(0.0, 1.0);
        }
        Future.delayed(Duration(seconds: 2));
        return Expanded(
          child: Transform.translate(
            offset: Offset(
                0, 0 - (value - 1) * MediaQuery.of(context).size.height * .3),
            child: Opacity(
              opacity: value,
              child: Column(
                children: <Widget>[
                  Text(
                    "${detailsList[index].title}",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${detailsList[index].description}",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 2,
                    width: 80,
                    color: colorList[index],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      "Read More",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: colorList[index],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget iteamBuilder(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = (_pageController.page - index);
          value = (1 - (value.abs() * .3)).clamp(0.0, 1.0);

          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: Curves.easeIn.transform(value) *
                  MediaQuery.of(context).size.height *
                  .7,
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: child,
            ),
          );
        } else {
          // We use this for the 1st time the app run then the _pageController.position.haveDimensions = false
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: Curves.easeIn
                      .transform(index == currentPage ? value : value * .7) *
                  MediaQuery.of(context).size.height *
                  .7,
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: child,
            ),
          );
        }
      },
      child: Material(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            child: Image.asset(
              imagesList[index],
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );
  }

  _pageChange(int index) {
    setState(() {
      currentPage = index;
    });
  }
}
