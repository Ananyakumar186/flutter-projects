import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_projects/earthquake_logs/earthquake_data_provider.dart';
import 'package:practice_projects/earthquake_logs/settings.dart';
import 'package:practice_projects/earthquake_logs/utils/helper_functions.dart';
import 'package:practice_projects/main.dart';
import 'package:provider/provider.dart';

class EarthquakeLog extends StatefulWidget {
  static const routeName = 'EarthQuake';

  const EarthquakeLog({super.key});

  @override
  State<EarthquakeLog> createState() => _EarthquakeLogState();
}

class _EarthquakeLogState extends State<EarthquakeLog> {
  @override
  void didChangeDependencies() {
    Provider.of<EarthQuakeDataProvider>(context, listen: false).init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earth Quake Log'),
        actions: [
          IconButton(
              onPressed: _showSortingDialog, icon: const Icon(Icons.sort)),
          IconButton(
              onPressed: (){ context.goNamed(SettingsPage.routeName);  }, icon: const Icon(Icons.settings))
        ],
      ),
      body: Consumer<EarthQuakeDataProvider>(
          builder: (context, provider, child) => provider.hasDataLoaded
              ? provider.earthquakeModel!.features!.isEmpty
                  ? const Center(
                      child: Text('No record found'),
                    )
                  : ListView.builder(
                      itemCount: provider.earthquakeModel!.features!.length,
                      itemBuilder: (context, index) {
                        final data = provider
                            .earthquakeModel!.features![index].properties!;
                        return ListTile(
                          title: Text(data.place ?? data.title ?? 'Unknown'),
                          subtitle: Text(getFormattedDateTIme(
                              data.time!, 'EEE MM dd yyyy hh:mm a')),
                          trailing: Chip(
                              avatar: data.alert == null
                                  ? null
                                  : CircleAvatar(
                                      backgroundColor:
                                          provider.getAlertColor(data.alert!),
                                    ),
                              label: Text('${data.mag}')),
                        );
                      },
                    )
              : const Center(
                  child: Text('Please Wait'),
                )),
    );
  }

  void _showSortingDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sort by'),
        content: Consumer<EarthQuakeDataProvider>(
          builder: (context, provider, child) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioGroup(groupValue: provider.orderBy, value: 'magnitude', label: 'magnitude-Desc', onChange: (value){
                provider.setOrder(value!);
              }),
              RadioGroup(groupValue: provider.orderBy, value: 'magnitude-asc', label: 'magnitude-Asc', onChange: (value){
                provider.setOrder(value!);
              }),
              RadioGroup(groupValue: provider.orderBy, value: 'time', label: 'time-Desc', onChange: (value){
                provider.setOrder(value!);
              }),
              RadioGroup(groupValue: provider.orderBy, value: 'time-asc', label: 'time-Asc', onChange: (value){
                provider.setOrder(value!);
              })

            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'),)
        ],
      ),
    );
  }
}

class RadioGroup extends StatelessWidget {
  final String groupValue;
  final String value;
  final String label;
  final Function(String?) onChange;

  const RadioGroup(
      {super.key,
      required this.groupValue,
      required this.value,
      required this.label,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<String>(value: value, groupValue: groupValue, onChanged: onChange),
        Text(label)
      ],
    );
  }
}
