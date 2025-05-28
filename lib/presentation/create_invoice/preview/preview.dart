import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  String? filePath;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadPDF();
  }

  Future<void> _loadPDF() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/INV-2025-001.pdf');

      if (await file.exists()) {
        setState(() {
          filePath = file.path;
        });
      } else {
        setState(() {
          error = 'PDF file not found.';
        });
      }
    } catch (e) {
      setState(() {
        error = 'Failed to load PDF: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return Column(children: [Text("Invoice PDF")]);
    }

    if (filePath == null) {
      return Column(children: [Center(child: CircularProgressIndicator())]);
    }

    return Stack(
      children: [
        Container(
          width: 320,
          height: 450,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200, width: 1.3),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(11),
            child: PDFView(
              filePath: filePath!,
              enableSwipe: false,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: false,
              fitPolicy: FitPolicy.BOTH,
              onError: (error) {
                setState(() {
                  this.error = 'PDF error: $error';
                });
              },
              onPageError: (page, error) {
                setState(() {
                  this.error = 'Page $page error: $error';
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
