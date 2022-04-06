import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor;
import 'package:travenx_loitafoundation/widgets/portrait/profile_screen/add_post/custom_input_box.dart';
import 'package:travenx_loitafoundation/widgets/portrait/profile_screen/add_post/policies_input_box.dart';

class StepThreeFields extends StatelessWidget {
  final List<TextEditingController> policyControllers;
  final void Function(String) detailsCallback;
  final void Function({bool isRemoved, int index}) policiesCallback;
  final void Function(String) announcementCallback;
  const StepThreeFields({
    Key? key,
    required this.policyControllers,
    required this.detailsCallback,
    required this.policiesCallback,
    required this.announcementCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kHPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).bottomAppBarColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(15.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomInputBox(
            label: 'ព័ត៌មានលម្អិត',
            hintText:
                'ឧទាហរណ៍៖ ប្រាសាទអង្គរវត្ត ជាប្រាសាទពុទ្ធសាសនា នៅភាគពាយ័ព្យនៃប្រទេសកម្ពុជា។'
                ' ប្រាសាទនេះគឺជាសម្បត្តិបេតិកភណ្ឌពិភពលោករបស់អង្គការយូណេស្កូ'
                ' និងជាគោលដៅទេសចរណ៍ដ៏សំខាន់មួយដែលជានិមិត្តសញ្ញាជាតិ និងជាទីសក្ការៈនៃព្រះពុទ្ធសាសនាខ្មែរ។',
            textCallback: detailsCallback,
            minimumLines: 10,
          ),
          const SizedBox(height: kHPadding),
          Text(
            'គោលការណ៍ ឬសេចក្តីណែនាំ',
            textAlign: TextAlign.justify,
            textScaleFactor: textScaleFactor,
            style: Theme.of(context).textTheme.button,
          ),
          PoliciesInputBox(
            hintText: 'អនុញ្ញាតិអោយមានភ្ញៀវអតិបរមា២នាក់ក្នុងមួយបន្ទប់។',
            policyControllers: policyControllers,
            policiesCallback: policiesCallback,
          ),
          const SizedBox(height: kHPadding),
          CustomInputBox(
            label: 'សេចក្តីប្រកាស (ឧទាហរណ៍៖ អំពីCoViD-19)',
            hintText:
                'ឧទាហរណ៍៖ ប្រសិនបើលោកអ្នកមានបញ្ហាសុខភាព ឬមានជម្ងឺ ឬសង្ស័យថាមានការឆ្លងជម្ងឺ'
                ' សូមប្រញាប់ទៅស្វែងរកការពិនិត្យពិគ្រោះនៅមន្ទីរពេទ្យរដ្ឋ ឬទំនាក់ទំនងតាមលេខទូរស័ព្ទ៖'
                '\n០១២ ៨២៥ ៤២៤ ឬ ០១២ ៤៨៨ ៩៨១ ឬ ០១២ ៨៣៦ ៨៦៨',
            textCallback: announcementCallback,
            minimumLines: 5,
          ),
        ],
      ),
    );
  }
}
