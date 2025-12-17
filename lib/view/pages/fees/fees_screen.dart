import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:educube1/const/app_colors.dart';
import 'package:educube1/model/feeMonthModel.dart';
import 'package:educube1/model/pastTransactionModel.dart';
import 'package:educube1/utils/app_alerts.dart';
import 'package:educube1/utils/extensions/extension.dart';
import 'package:educube1/view/widgets/common_app_bar.dart';
import 'package:educube1/view/widgets/common_button.dart';
import 'package:educube1/view/widgets/common_drawer.dart';
import 'package:educube1/view/widgets/common_scaffold.dart';
import 'package:educube1/view/widgets/common_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../controller/fees/fees_controller.dart';
import '../../../route/app_routes.dart';

class FeesScreen extends StatefulWidget {
  const FeesScreen({super.key});

  @override
  State<FeesScreen> createState() => _FeesScreenState();
}

class _FeesScreenState extends State<FeesScreen> {
  final feesController = Get.find<FeesController>();

  @override
  void initState() {
    super.initState();
    _getData();
    _listeners();
  }

  void _listeners() {
    feesController.hitPaymentGateWay = () {
      feesController.getPaymentSession();
    };
    feesController.openPaymentWebView = (value) {
      Logger().d('----web url-----');
      "https://www.google.com/";
    };
  }

  void _getData() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      EasyLoading.show(dismissOnTap: true);
      await feesController.getData();
      EasyLoading.show(dismissOnTap: false);
    });
  }

  @override
  void dispose() {
    feesController.hitPaymentGateWay = null;
    feesController.openPaymentWebView = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDuesTab = feesController.activeTab == 0;
      return CommonScaffold(
        title: isDuesTab ? 'Fees' : 'Fees',
        showBack: true, onBack: () { Navigator.pop(context); },

        //  backgroundColor: AppColors.kPrimaryColor,
      //  drawer:  CommonDrawer(),
      //  appBar: CommonAppBar(title: isDuesTab ? 'Fees' : 'Report'),
        body: Column(
          children: [
             CommonTile(),

            /// Tabs (Payment Dues | Past Transactions)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  _tabChip(
                    context: context,
                    label: 'Payment Dues',
                    selected: isDuesTab,
                    onTap: () async {
                      EasyLoading.show(dismissOnTap: true);
                      await feesController.onTabAction(0);
                      EasyLoading.show(dismissOnTap: false);
                    },
                  ),
                  const SizedBox(width: 12),
                  _tabChip(
                    context: context,
                    label: 'Past Transactions',
                    selected: !isDuesTab,
                    onTap: () async {
                      EasyLoading.show(dismissOnTap: true);
                      await feesController.onTabAction(1);
                      EasyLoading.show(dismissOnTap: false);
                    },
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: isDuesTab ? _paymentDuesUI(context) : _pastTransactionsUI(context),
              ),
            ),

            /// Bottom CTA
            Obx(() {
              if (!isDuesTab) return const SizedBox.shrink();
              final hasDues = feesController.feeCollection.isNotEmpty;
              if (!hasDues) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.fromLTRB(80, 8, 80, 16),
                child: CommonButton(
                  height: 40,
                  text: 'Next',
                  onPressed: () async {
                    EasyLoading.show(dismissOnTap: true);
                    try {
                      feesController.getPermission();
                    } finally {
                      EasyLoading.show(dismissOnTap: false);
                    }
                  },
                ),
              );
            }),
          ],
        ),
      );
    });
  }

  // ---------------- UI Pieces ----------------

  Widget _tabChip({
    required BuildContext context,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? AppColors.colorBlue.withOpacity(.12) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected ? AppColors.colorBlue : AppColors.colorTextPrimary.withOpacity(.3),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: 10.fontMultiplier,
              color: selected ? AppColors.colorBlue : AppColors.colorTextPrimary,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _paymentDuesUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Time Period + Dropdown
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Time Period:',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontSize: 10.fontMultiplier, color: AppColors.colorTextPrimary)),
            Obx(() {
              final months = feesController.feeMonths;
              if (months.isEmpty) return const SizedBox.shrink();
              return DropdownButtonHideUnderline(
                child: DropdownButton2<FeeMonthModel>(
                  isExpanded: false,
                  items: months
                      .map((m) => DropdownMenuItem(
                    value: m,
                    child: Text(
                      m.feeMonthValue ?? '',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: 10.fontMultiplier,
                        fontWeight: FontWeight.w400,
                        color: AppColors.colorTextPrimary,
                      ),
                    ),
                  ))
                      .toList(),
                  value: feesController.selectMonth,
                  onChanged: (newValue) async {
                    if (newValue == null) return;
                    EasyLoading.show(dismissOnTap: true);
                    await feesController.setSelectedMonth(newValue);
                    EasyLoading.show(dismissOnTap: false);
                  },
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                    ),
                  ),
                  iconStyleData: IconStyleData(
                    icon: Icon(Icons.keyboard_arrow_down,
                        color: AppColors.colorTextPrimary, size: 18),
                  ),
                ),
              );
            }),
          ],
        ),
        const SizedBox(height: 12),

        /// Dues list
        Expanded(
          child: Obx(() {
            final dues = feesController.feeCollection;
            return ListView.separated(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              itemCount: dues.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final item = dues[i];
                final name = item.feeStructureName ?? '';
                final amountText = item.paymentAmount ?? '0';
                final due = feesController.strToDateFormat(
                  item.feeEndDate ?? '',
                  'dd-MM-yyyy',
                  'MMMM yyyy',
                ); // "March 2025"
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                    border: Border.all(color: AppColors.colorTextPrimary.withOpacity(.08)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontSize: 12.5.fontMultiplier, color: AppColors.colorBlackText),
                            ),
                          ),
                          Text(
                            '₹$amountText',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontSize: 12.5.fontMultiplier, color: AppColors.colorRed),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Due: $due',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontSize: 11.fontMultiplier,
                            color: AppColors.colorRed,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),

        /// Total Unpaid bar
        Obx(() {
          final dues = feesController.feeCollection;
          final total = dues.fold<double>(
            0.0,
                (sum, e) => sum + (double.tryParse(e.paymentAmount ?? '0') ?? 0),
          );
          if (dues.isEmpty) return const SizedBox.shrink();
          return Container(
            margin: const EdgeInsets.only(top: 6, bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.colorTextPrimary.withOpacity(.08)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Unpaid',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontSize: 12.fontMultiplier, color: AppColors.colorBlackText)),
                Text('₹${total.toStringAsFixed(0)}',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontSize: 12.fontMultiplier, color: AppColors.colorRed)),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _pastTransactionsUI(BuildContext context) {
    return Column(
      children: [
        /// List of past transactions -> first expanded card style
        Expanded(
          child: Obx(() {
            final items = feesController.pastTransactions;
            if (items.isEmpty) {
              return Center(
                  child: Text('No past transactions',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.colorBlackText)));
            }
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, i) {
                final data = items[i];
                final paidDate = data.feePaidDate ?? '';
                final rightDate = feesController.strToDateFormat(paidDate, 'dd-MM-yyyy', 'd MMM');
                final monthTitle = /*data.feeMonthLabel ??*/ 'School Fee'; // add label in your model if needed
                final amount = data.feeAmount ?? '0';

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.colorTextPrimary.withOpacity(.08)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Header
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '$monthTitle for ${feesController.strToDateFormat(paidDate, "dd-MM-yyyy", "MMMM")}',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontSize: 12.fontMultiplier,
                                  color: AppColors.colorBlackText,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              rightDate,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(fontSize: 11.fontMultiplier, color: AppColors.colorBlackText),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        /// Amount big
                        Text(
                          '₹$amount',
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontSize: 16.fontMultiplier,
                            color: AppColors.colorBlackText,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),

                        /// Details
                        _kvRow(context, 'Fee Paid Date', paidDate),
                        _kvRow(context, 'Fee Amount', data.feeAmount ?? ''),
                        _kvRow(context, 'Fine Amount', data.fineAmount ?? '0'),
                        _kvRow(context, 'Fee Receipt No', data.feeReceiptNo ?? ''),
                        _kvRow(context, 'Mode of Payment', data.modeOfPayment ?? 'Online'),
                        _kvRow(context, 'Transaction ID', data.onlineTransactionId ?? ''),
                        _kvRow(context, 'Status', data.status ?? 'Success'),

                        const SizedBox(height: 10),

                        /// View Receipt button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.colorBlue,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () async {
                              EasyLoading.show(dismissOnTap: true);
                              final res = await feesController.getReceipt(data.voucherId ?? '');
                              EasyLoading.show(dismissOnTap: false);
                              if (res['status'] == true) {
                                Get.toNamed(AppRoutes.routeFeesViewReceipt);
                              } else {
                                AppAlerts.error(message: '${res['msg']}');
                              }
                            },
                            child: Text('View Receipt',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(fontSize: 10.fontMultiplier, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _kvRow(BuildContext context, String k, String v) {
    final style = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(fontSize: 10.fontMultiplier, color: AppColors.colorBlackText);
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(child: Text(k, style: style)),
          const SizedBox(width: 24),
          Expanded(child: Text(v, style: style, textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}
