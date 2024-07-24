import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PdfViewerPage extends StatefulWidget {
  final String url;

  const PdfViewerPage({super.key, required this.url});

  @override
  // ignore: library_private_types_in_public_api
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      )),
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
