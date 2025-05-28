enum CardType { invoices, clients, revenue, drafts }

class DashboardCardInfo {
  final CardType type;
  final int? count;
  final double? amount;

  const DashboardCardInfo({required this.type, this.count, this.amount});
}
