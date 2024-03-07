import 'package:flutter/material.dart';

class aboutpage extends StatefulWidget {
  const aboutpage({Key? key}) : super(key: key);

  @override
  State<aboutpage> createState() => _aboutpageState();
}

class _aboutpageState extends State<aboutpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(),
        backgroundColor: Color(0xff832729),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              height: 50,
              width: 50,
              child: CircleAvatar(
                backgroundColor: Color(0xff832729),
                radius: 0, // Image radius
                backgroundImage: AssetImage('asset/logo.png'),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "About Us",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Container(
                padding: EdgeInsets.all(0),
                // decoration: BoxDecoration(
                //   border: Border(
                //     bottom: BorderSide(color: Colors.grey)
                //   )
                // ),

                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 400,
                    width: 330,
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: const DecorationImage(
                          image: AssetImage('asset/about.jpg'),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.red),
                  ),
                ),
              ),
              Center(
                child: Text(
                  """Sri Shanmuga Jewellery
Where trust, quality, and style meet.""",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff832729), fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25, left: 25),
                child: Text(
                  """
\nSri Shanmuga Jewellery was founded in 1950 by S Shanmugam Mudaliar. Over the past 70 years, With each being a successful generation, from S Angappa Mudaliar to Sri Rangan A, the business was passed down to Angappa Mudaliar’s son, A Sri Rangan, who is the current managing director. Under his leadership, Sri Shanmuga Jewellery has continued to grow and expand, and it is now one of the leading jewelry retailers in Tamil Nadu. the business has been passed down through four generations, and it continues to meet the expectations of customers today.

Sri Shanmuga Jewellery has a wide selection of jewelry to choose from, including gold and silver. The business also offers a variety of custom jewelry services, so you can create the perfect piece of jewelry for any occasion.
""",
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 300,
                width: 300,
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: AssetImage('asset/logo.png'),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.transparent),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
