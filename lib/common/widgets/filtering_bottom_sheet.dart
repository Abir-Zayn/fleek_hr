import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';


class FilteringBottomSheet extends StatelessWidget {
  final String title;
  final List<String> filteringOpt;
  final String selectedFilter;
  final void Function(String) onFilterSelected;
  final double borderRadius;
  final EdgeInsets padding;
  const FilteringBottomSheet({
    super.key,
    required this.title,
    required this.filteringOpt,
    required this.selectedFilter,
    required this.onFilterSelected,
    this.borderRadius = 20.0,
    this.padding = const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                AppTextstyle(
                  text: title,
                  style: appStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color ??
                        Colors.black,
                    size: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          const Divider(),
          ...filteringOpt.map((filter) => buildFilterOptions(context, filter)),
        ],
      ),
    );
  }

  Widget buildFilterOptions(BuildContext context, String filterName) {
    final isSelected = selectedFilter == filterName;
    return InkWell(
      onTap: () {
        onFilterSelected(filterName);
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
            ),
            SizedBox(width: 16),
            AppTextstyle(
              text: filterName,
              style: appStyle(
                size: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).textTheme.bodyMedium?.color ??
                        Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
