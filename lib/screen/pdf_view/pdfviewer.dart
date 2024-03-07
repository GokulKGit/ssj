import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/material.dart';

class PdfViewerPage extends StatelessWidget {
  final String pdfUrl;
  final String name;

  PdfViewerPage(this.pdfUrl, this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SfPdfViewer.network(
        pdfUrl,
      ),
    );
  }
}
