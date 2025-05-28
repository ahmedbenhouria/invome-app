import 'package:Invome/core/configs/assets/app_vectors.dart';
import 'package:Invome/presentation/create_invoice/widgets/action_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/configs/assets/app_images.dart';
import '../../core/configs/theme/app_colors.dart';
import 'create_invoice.dart';

class SelectTemplate extends StatefulWidget {
  const SelectTemplate({super.key});

  @override
  State<SelectTemplate> createState() => _SelectTemplateState();
}

class _SelectTemplateState extends State<SelectTemplate> {
  final PageController _pageController = PageController(viewportFraction: 0.86);
  int _currentPage = 0;

  List<String> invoiceTemplateImages = [
    AppImages.invoice1,
    AppImages.invoice2,
    AppImages.invoice3,
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 25, top: 11),
            child: Center(child: SvgPicture.asset(AppVectors.line)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 2),
            child: const Text(
              'Choose a Template',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: screenHeight * 0.52,
            child: PageView.builder(
              controller: _pageController,
              itemCount: invoiceTemplateImages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 17),
                  child: _buildInvoiceCard(
                    templateImage: invoiceTemplateImages[index],
                    index: index,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 25),
          _buildDots(),
          const SizedBox(height: 5),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3.0),
                child: ActionButtonWidget(
                  text: 'Continue',
                  color: AppColors.primary,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => CreateInvoicePage(),
                      ),
                    );
                  },
                  width: 140,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceCard({
    required String templateImage,
    required int index,
  }) {
    bool isSelected = index == _currentPage;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Colors.grey.shade400 : Colors.grey.shade200,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Image.asset(templateImage, fit: BoxFit.fill),
      ),
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(invoiceTemplateImages.length, (index) {
        final isActive = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 8.5,
          height: 8.5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? AppColors.primary : Colors.grey.shade300,
          ),
        );
      }),
    );
  }
}
