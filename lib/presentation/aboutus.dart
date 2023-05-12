import 'package:flutter/material.dart';

import '../core/colors/importedTheme.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Developers', style: greetingTextStyle.copyWith(fontSize: 20, color: Colors.white),),
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
        child: ListView(
          children: [
            _buildDeveloperSection(
              name: 'Shibil Basith CP',
              img: "assets/images/shibil.jpg",
              color: Colors.white,
              description:
                  'A full-stack developer with experience in developing high-performance mobile applications using Flutter.',
            ),
            _buildDeveloperSection(
              name: 'Mohammed Shakeel C',
              img: "assets/images/shakeel.jpg",
              color: Colors.white,
              description:
                  'A graphic designer and front-end developer with professional experience.',
            ),
            _buildDeveloperSection(
              name: 'Muhammed Dilshan K',
              img: "assets/images/dilshan.jpeg",
              color: Colors.white,
              description:
                  'A full-stack developer with experience in building web and mobile applications.',
            ),
            _buildDeveloperSection(
              name: 'Muhammed Bahiz N',
              img: "assets/images/bahiz.png",
              color: Colors.white,
              description:
                  'a Mobile Developer with a focus on user experience and accessibility.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeveloperSection({
    required String name,
    required String img,
    required Color color,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          //padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(img),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: titleTextStyle,
                    ),
                    SizedBox(height: 8),
                    Text(
                      description,
                      style: facilityTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
