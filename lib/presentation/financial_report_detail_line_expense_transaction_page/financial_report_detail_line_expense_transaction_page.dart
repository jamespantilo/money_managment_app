import 'widgets/financialreportdetaillineexpen_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

// ignore_for_file: must_be_immutable
class FinancialReportDetailLineExpenseTransactionPage extends StatefulWidget {
  const FinancialReportDetailLineExpenseTransactionPage({Key? key})
      : super(
          key: key,
        );

  @override
  FinancialReportDetailLineExpenseTransactionPageState createState() =>
      FinancialReportDetailLineExpenseTransactionPageState();
}

class FinancialReportDetailLineExpenseTransactionPageState
    extends State<FinancialReportDetailLineExpenseTransactionPage>
    with
        AutomaticKeepAliveClientMixin<
            FinancialReportDetailLineExpenseTransactionPage> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillOnErrorContainer,
          child: Column(
            children: [
              SizedBox(height: 8.v),
              Padding(
                padding: EdgeInsets.only(
                  left: 6.h,
                  right: 9.h,
                ),
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (
                    context,
                    index,
                  ) {
                    return SizedBox(
                      height: 1.v,
                    );
                  },
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return FinancialreportdetaillineexpenItemWidget();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
