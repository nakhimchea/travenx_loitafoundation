import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor;
import 'package:travenx_loitafoundation/models/post_object_model.dart';

class Policies extends StatelessWidget {
  final PostObject post;

  const Policies({Key? key, required this.post}) : super(key: key);

  List<Widget> _buildPolicies(BuildContext context) {
    List<Widget> policyList = [];
    for (String policy in post.policies!)
      policyList.add(
        Text(
          '• ' + policy,
          textScaleFactor: textScaleFactor,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      );

    return policyList;
  }

  @override
  Widget build(BuildContext context) {
    return post.policies != null
        ? Padding(
            padding: EdgeInsets.symmetric(
              horizontal: kHPadding,
              vertical: kVPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'គោលការណ៍',
                  textScaleFactor: textScaleFactor,
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(height: 10.0),
                Column(children: _buildPolicies(context)),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
