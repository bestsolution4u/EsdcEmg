import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewerScreen extends StatefulWidget {

  final String pdfPath, title;

  PdfViewerScreen({this.title = "", this.pdfPath = 'asset/pdf/calendar.pdf'});

  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {

  int pages = 0;
  bool isReady = false;
  final Completer<PDFViewController> _controller = Completer<PDFViewController>();
  Uint8List pdfData;

  @override
  void initState() {
    super.initState();
    pdfData = null;
    loadPDFdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: pdfData == null ? Center(child: CircularProgressIndicator(),) : PDFView(
        pdfData: pdfData,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: true,
        pageFling: true,
        onRender: (_pages) {
          setState(() {
            pages = _pages;
            isReady = true;
          });
        },
        onError: (error) {
          print(error.toString());
        },
        onPageError: (page, error) {
          print('$page: ${error.toString()}');
        },
        onViewCreated: (PDFViewController pdfViewController) {
          _controller.complete(pdfViewController);
        },
        onPageChanged: (int page, int total) {
          print('page change: $page/$total');
        },
      ),
    );
  }

  Future<void> loadPDFdata() async {
    var data = await rootBundle.load(widget.pdfPath);
    var bytes = data.buffer.asUint8List();
    setState(() {
      pdfData = bytes;
    });
  }
}
