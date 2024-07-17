import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PdfViewerPage extends StatefulWidget {
  final String url;

  PdfViewerPage({required this.url});

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Viewer"),
      ),
      body: const PDF().fromUrl(
        widget.url,
        placeholder: (double progress) => Center(
          child: Text('$progress %'),
        ),
        errorWidget: (dynamic error) => Center(
          child: Text(error.toString()),
        ),
      ),
    );
  }
}
