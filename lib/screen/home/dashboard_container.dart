import 'package:flutter/material.dart';
import 'package:ssj/api/get/topbanner.dart';
import 'package:ssj/screen/home/banner.dart';
import 'package:ssj/screen/home/drawer_pages/branches_map.dart';
import 'package:ssj/screen/home/drawer_pages/customer_care.dart';
import 'package:ssj/screen/home/joinScheme/goldscheme.dart';
import 'package:ssj/screen/home/myschemes/myschemes.dart';
import 'package:ssj/screen/home/profile/drawer_profile.dart';
import 'package:ssj/screen/pdf_view/show_brochures.dart';

class homescreeninput extends StatefulWidget {
  const homescreeninput({Key? key}) : super(key: key);

  @override
  State<homescreeninput> createState() => _homescreeninputState();
}

class _homescreeninputState extends State<homescreeninput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              height: 150,
              child: FutureBuilder<TopBanner>(
                // Replace this with your API call to get the JSON data
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return BannerSlideView(
                      data: snapshot.data!.data,
                      sec: 500,
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: AssetImage("asset/banner1.jpg"),
                            fit: BoxFit.cover),
                        color: Colors.grey[300],
                      ),
                      height: 150,
                    ));
                  } else {
                    return Center(
                        child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[300],
                      ),
                      height: 150,
                    ));
                  }
                },
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FeatureGrid(
                imageLink: "asset/join_scheme.png",
                featureName: "Join Scheme",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GoldSchemesWidget(),
                    ),
                  );
                }),
            FeatureGrid(
                imageLink: "asset/my_scheme.png",
                featureName: "My Scheme",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MySchemeDataWidget(),
                    ),
                  );
                }),
            FeatureGrid(
                imageLink: "asset/brochure.png",
                featureName: "Brochures",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PdfViewerScreen(),
                    ),
                  );
                }),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FeatureGrid(
                imageLink: "asset/user.png",
                featureName: "Profile",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DrawerProfile(),
                    ),
                  );
                }),
            FeatureGrid(
                imageLink: "asset/branch.png",
                featureName: "Branches",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => branchesmap(),
                    ),
                  );
                }),
            FeatureGrid(
                imageLink: "asset/customer_care.png",
                featureName: "Customer Care",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => customercare(),
                    ),
                  );
                }),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              height: 150,
              child: FutureBuilder<TopBanner>(
                // Replace this with your API call to get the JSON data
                future: fetchDataHotBanner(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return BannerSlideView(
                        data: snapshot.data!.data, sec: 1000);
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("asset/banner2.jpg"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[300],
                      ),
                      height: 150,
                    ));
                  } else {
                    return Center(
                        child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: 150,
                    ));
                  }
                },
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class FeatureGrid extends StatelessWidget {
  FeatureGrid({
    required this.imageLink,
    required this.featureName,
    required this.onTap,
  });

  String imageLink;
  String featureName;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            CircleAvatar(
              // backgroundColor: Color.fromARGB(255, 144, 66, 43),
              backgroundColor: Color(0xff832729),
              maxRadius: 38,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(imageLink),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                featureName,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
