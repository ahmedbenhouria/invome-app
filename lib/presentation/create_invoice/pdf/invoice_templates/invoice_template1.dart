import 'dart:io';

import 'package:Invome/presentation/create_invoice/pdf/pdf_file_manager.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../domain/entities/invoice.dart';

class InvoiceTemplate1 {
  static Future<File> generate(Invoice invoice, String invoiceName) async {
    final pdf = Document();

    pdf.addPage(
      Page(
        pageFormat: PdfPageFormat.a4,
        margin: EdgeInsets.zero,
        build: (context) {
          return Container(
            width: PdfPageFormat.a4.width,
            height: PdfPageFormat.a4.height,
            color: hexToPdfColor('#F9FAFC'),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInvoiceHeader(invoice),
                  SizedBox(height: 25),
                  _buildMainContent(invoice),
                  SizedBox(height: 15),
                  _buildInvoiceFooter(),
                ],
              ),
            ),
          );
        },
      ),
    );

    return PdfFileManager.saveDocument(name: invoiceName, pdf: pdf);
  }

  static Widget buildInvoiceHeader(Invoice invoice) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invoice.supplier.name,
                  style: TextStyle(
                    fontSize: 17,
                    color: hexToPdfColor('#E87117'),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  invoice.supplier.website,
                  style: TextStyle(fontSize: 11, color: PdfColors.grey600),
                ),
                SizedBox(height: 4),
                Text(
                  invoice.supplier.email,
                  style: TextStyle(fontSize: 11, color: PdfColors.grey600),
                ),
                SizedBox(height: 4),
                Text(
                  invoice.supplier.phone,
                  style: TextStyle(fontSize: 11, color: PdfColors.grey600),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Push content to bottom
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Business Address',
                  style: TextStyle(fontSize: 11, color: PdfColors.grey600),
                ),
                SizedBox(height: 4),
                Text(
                  invoice.supplier.address,
                  style: TextStyle(fontSize: 11, color: PdfColors.grey600),
                ),
                SizedBox(height: 4),
                Text(
                  invoice.supplier.taxId,
                  style: TextStyle(fontSize: 11, color: PdfColors.grey600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildInvoiceFooter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Terms and Conditions',
          style: TextStyle(fontSize: 9, color: PdfColors.grey600),
        ),
        SizedBox(height: 5),
        Text(
          'Please pay within 15 days of receiving this invoice.',
          style: TextStyle(fontSize: 9, color: PdfColors.black),
        ),
      ],
    );
  }

  static Widget _buildMainContent(Invoice invoice) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: PdfColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: PdfColors.grey300, width: 1),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Billed To
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Billed to',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: PdfColors.grey700,
                                ),
                              ),
                              SizedBox(height: 5),

                              Text(
                                invoice.customer.name,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: PdfColors.black,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                invoice.customer.address,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: PdfColors.grey600,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.clip,
                                softWrap: true,
                              ),
                              SizedBox(height: 3),
                              Text(
                                invoice.customer.phone,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: PdfColors.grey600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: 18),

                        // Invoice Number
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Invoice number',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: PdfColors.grey700,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  invoice.info.number,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: PdfColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Invoice Total
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Invoice of (USD)',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: PdfColors.grey700,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '\$${getGrandTotal(invoice).toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 21,
                                  color: hexToPdfColor('#E87117'),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 33),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Subject',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: PdfColors.grey600,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                invoice.info.description,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: PdfColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.clip,
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Invoice date',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: PdfColors.grey600,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  invoice.info.date.toLocal().toString().split(
                                    ' ',
                                  )[0],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: PdfColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Due date',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: PdfColors.grey600,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                invoice.info.dueDate.toLocal().toString().split(
                                  ' ',
                                )[0],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: PdfColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: Table(
                        columnWidths: {
                          0: FlexColumnWidth(5),
                          1: FlexColumnWidth(0.8),
                          2: FlexColumnWidth(2),
                          3: FlexColumnWidth(2),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: PdfColors.grey300,
                                  width: 1,
                                ),
                                bottom: BorderSide(
                                  color: PdfColors.grey300,
                                  width: 1,
                                ),
                              ),
                            ),
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 6),
                                child: _cell(
                                  'ITEM DETAIL',
                                  align: TextAlign.left,
                                  color: PdfColors.grey700,
                                  fontSize: 10,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 6),
                                child: _cell(
                                  'QTY',
                                  align: TextAlign.start,
                                  color: PdfColors.grey700,
                                  fontSize: 10,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 6),
                                child: _cell(
                                  'RATE',
                                  align: TextAlign.right,
                                  color: PdfColors.grey700,
                                  fontSize: 10,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 6),
                                child: _cell(
                                  'AMOUNT',
                                  align: TextAlign.right,
                                  color: PdfColors.grey700,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          ...invoice.items.asMap().entries.map((entry) {
                            final index = entry.key;
                            final item = entry.value;

                            final isLast = index == invoice.items.length - 1;

                            return TableRow(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                      isLast
                                          ? BorderSide(
                                            color: PdfColors.grey300,
                                            width: 1,
                                          )
                                          : BorderSide.none,
                                ),
                              ),
                              children: [
                                _itemDetail(item.name, item.description),
                                _cell(
                                  '${item.quantity}',
                                  align: TextAlign.start,
                                ),
                                _cell('\$${item.unitPrice.toStringAsFixed(2)}'),
                                _cell('\$${item.total.toStringAsFixed(2)}'),
                              ],
                            );
                          }),
                          TableRow(
                            children: List.generate(
                              4,
                              (_) => SizedBox(height: 8),
                            ),
                          ),
                          TableRow(
                            children: [
                              SizedBox(),
                              SizedBox(),
                              _cell('Subtotal', align: TextAlign.left),
                              _cell(
                                '\$${getInvoiceSubtotal(invoice).toStringAsFixed(2)}',
                              ),
                            ],
                          ),
                          TableRow(
                            children: List.generate(
                              4,
                              (_) => SizedBox(height: 4),
                            ),
                          ),
                          TableRow(
                            children: [
                              SizedBox(),
                              SizedBox(),
                              _cell('Tax (10%)', align: TextAlign.left),
                              _cell(
                                '\$${getInvoiceTotalVat(invoice).toStringAsFixed(2)}',
                              ),
                            ],
                          ),
                          TableRow(
                            children: List.generate(
                              4,
                              (_) => SizedBox(height: 6),
                            ),
                          ),
                          TableRow(
                            children: [
                              SizedBox(),
                              SizedBox(),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: PdfColors.grey300,
                                      width: 1.4,
                                    ),
                                  ),
                                ),
                                child: _cell(
                                  'Total',
                                  align: TextAlign.left,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: PdfColors.grey300,
                                      width: 1.4,
                                    ),
                                  ),
                                ),
                                child: _cell(
                                  '\$${getGrandTotal(invoice).toStringAsFixed(2)}',
                                  align: TextAlign.right,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Thanks for the business',
                  style: TextStyle(
                    fontSize: 10,
                    color: PdfColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _cell(
  String text, {
  TextAlign align = TextAlign.right,
  PdfColor color = PdfColors.black,
  FontWeight fontWeight = FontWeight.normal,
  double fontSize = 12,
}) {
  return Padding(
    padding: const EdgeInsets.all(4),
    child: Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    ),
  );
}

Widget _itemDetail(String title, String subtitle) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 2),
        Text(
          subtitle,
          style: TextStyle(fontSize: 11, color: PdfColors.grey600),
        ),
      ],
    ),
  );
}

PdfColor hexToPdfColor(String hex) {
  hex = hex.replaceAll('#', '');
  if (hex.length == 6) {
    final r = int.parse(hex.substring(0, 2), radix: 16);
    final g = int.parse(hex.substring(2, 4), radix: 16);
    final b = int.parse(hex.substring(4, 6), radix: 16);
    return PdfColor.fromInt((r << 16) + (g << 8) + b);
  }
  throw ArgumentError('Hex color must be 6 characters long.');
}
