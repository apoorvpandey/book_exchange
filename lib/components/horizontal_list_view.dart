import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Category(
            imageLocation: "images/categories/bodybuilding.png",
            imageCaption: "Bodybuilding",
          ),
          Category(
            imageLocation: "images/categories/career.png",
            imageCaption: "Career",
          ),
          Category(
            imageLocation: "images/categories/engineering.png",
            imageCaption: "Engineering",
          ),
          Category(
            imageLocation: "images/categories/maths.png",
            imageCaption: "Mathematics",
          ),
          Category(
            imageLocation: "images/categories/motivation.png",
            imageCaption: "Motivation",
          ),
          Category(
            imageLocation: "images/categories/programming.png",
            imageCaption: "Programming",
          ),
          Category(
            imageLocation: "images/categories/school.png",
            imageCaption: "School",
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String imageLocation;
  final String imageCaption;

  Category({this.imageLocation, this.imageCaption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Container(
              width: 100,
              height: 80,
              child: ListTile(
                title: Image.asset(
                  imageLocation,
                  width: 100,
                  height: 80,
                ),
                subtitle: Container(
                    child: Text(
                  imageCaption,
                  overflow: TextOverflow.ellipsis,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
