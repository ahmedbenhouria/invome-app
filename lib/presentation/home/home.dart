import 'package:Invome/core/configs/assets/app_vectors.dart';
import 'package:Invome/core/configs/theme/app_colors.dart';
import 'package:Invome/presentation/home/widgets/revenue_wave_clipper.dart';
import 'package:Invome/presentation/home/widgets/swipeable_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../create_invoice/select_template.dart';
import 'dashboard_card_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<DashboardCardInfo> _cardInfo = [
    DashboardCardInfo(type: CardType.invoices, count: 20),
    DashboardCardInfo(type: CardType.clients, count: 12),
    DashboardCardInfo(type: CardType.revenue, amount: 240.56),
    DashboardCardInfo(type: CardType.drafts, count: 5),
  ];

  Widget _buildCard({
    required double height,
    required Color color,
    required Widget child,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: child,
    );
  }

  Widget _buildInvoiceCard(int count) {
    return SwipeableCardWidget(
      height: 155.0,
      color: AppColors.primary,
      frontChild: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 23),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Invoices',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Text(
              '$count',
              style: TextStyle(
                color: Colors.white,
                fontSize: 42,
                fontWeight: FontWeight.w500,
                height: 0.9,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Swipe →',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
      backChild: _buildInvoiceDetails(),
    );
  }

  Widget _buildClientsCard(int count) {
    return _buildCard(
      height: 200.0,
      color: AppColors.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Clients',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '$count',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(23),
                    bottomRight: Radius.circular(23),
                  ),
                ),
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 14.5),
              ),
              child: Text(
                'View All Clients',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueCard(double amount) {
    return _buildCard(
      height: 200.0,
      color: AppColors.surface,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 23),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Revenue',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '\$${amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: RevenueWaveClipper(),
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDraftsCard(int count) {
    return _buildCard(
      height: 155.0,
      color: AppColors.surface,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 23),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              AppVectors.save,
              colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              width: 26,
              height: 26,
            ),
            Text(
              'Drafts',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '$count',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 42,
                fontWeight: FontWeight.w500,
                height: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Invoice Details',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Paid',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  Text(
                    '15',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overdue',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  Text(
                    '5',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Text(
            '← Swipe',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCardList() {
    return _cardInfo.map((card) {
      switch (card.type) {
        case CardType.invoices:
          return _buildInvoiceCard(card.count ?? 0);
        case CardType.clients:
          return _buildClientsCard(card.count ?? 0);
        case CardType.revenue:
          return _buildRevenueCard(card.amount ?? 0);
        case CardType.drafts:
          return _buildDraftsCard(card.count ?? 0);
      }
    }).toList();
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black87.withOpacity(0.5),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return SelectTemplate();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _showBottomSheet(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 1,
                    padding: EdgeInsets.symmetric(vertical: 11),
                    shadowColor: Colors.black45,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: Text(
                      'Create New Invoice',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Overview',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),
            MasonryGridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 28,
              crossAxisSpacing: 22,
              itemCount: _buildCardList().length,
              itemBuilder: (context, index) => _buildCardList()[index],
            ),
          ],
        ),
      ),
    );
  }
}
