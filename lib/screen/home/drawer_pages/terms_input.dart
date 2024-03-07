import 'package:flutter/material.dart';
import 'package:ssj/util/constant.dart';

class termspageinput extends StatelessWidget {
  const termspageinput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                """Introduction:""",
                style: TextStyle(color: BASECOLOR, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                """ Sri Shanmuga Jewellery(SSJ) is a mobile application-based gold savings scheme offered by Sri Shanmuga Jewellery. The scheme allows users to save in gold using the SSJ mobile application.
""",
                style: TextStyle(
                  color: Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                """1. Eligibility:""",
                style: TextStyle(color: BASECOLOR, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                """\u2022 The Gold Scheme is open to all individuals who are residents of India and have a valid PAN card.\n
\u2022 Applicants must be at least 18 years old and must not have any outstanding loans or dues with the Government of India.""",
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                """2. Application Process:""",
                style: TextStyle(color: BASECOLOR, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                """
\u2022 To apply for the Gold Scheme, applicants must submit an online application form.\n
\u2022 The application form must be accompanied by the following documents:
\t\t\t\t1. PAN card
\t\t\t\t2. Proof of identity
\t\t\t\t3. Proof of residence""",
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                """3. Scheme Benefits:""",
                style: TextStyle(color: BASECOLOR, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                """A Gold Saving Scheme by Sri Shanmuga jewellers is a scheme where you can deposit your gold with the jeweller and earn a higher quantity of gold by the end of a year. 
""",
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.justify,
              ),
              Text(
                """4. Repayment:""",
                style: TextStyle(color: BASECOLOR, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                """The amount must be repaid in equal monthly installments over the repayment period.
With a maximum tenure of one year, this scheme must be closed by buying a jewellery on the maturity date.
""",
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.justify,
              ),
              Text(
                """5. Governing Law:""",
                style: TextStyle(color: BASECOLOR, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                """The Gold Scheme will be governed by the laws of India.""",
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                """6. Dispute Resolution:""",
                style: TextStyle(color: BASECOLOR, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                """Any disputes arising out of the Gold Scheme will be resolved by a mutually agreed upon arbitration tribunal.
""",
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.justify,
              ),
              Text(
                """
7. Waiver:""",
                style: TextStyle(color: BASECOLOR, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                """
The Government of India may waive any of the terms and conditions of the Gold Scheme at its sole discretion.""",
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }
}
