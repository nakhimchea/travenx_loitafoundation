import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/widgets/custom_loading.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      insetPadding: EdgeInsets.symmetric(
          horizontal: (MediaQuery.of(context).size.width - 100) / 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        height: 100,
        child: Loading(color: Theme.of(context).primaryColor),
      ),
    );
  }
}
