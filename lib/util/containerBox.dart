import 'package:flutter/material.dart';
import 'package:ssj/screen/pdf_view/pdfviewer.dart';

class ContainerGrid extends StatelessWidget {
  ContainerGrid({
    required this.name,
    required this.location,
  });

  String name;
  String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(6),
        elevation: 5,
        child: Column(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PdfViewerPage(
                        location,
                        name,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6)),
                        image: DecorationImage(
                            image: AssetImage("asset/brochure_pdf.png"),
                            fit: BoxFit.contain)),
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(
                  right: 5,
                  left: 5,
                  top: 3,
                  bottom: 6,
                ),
                child: Center(
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Color(0xffCF8268),
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.012,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
