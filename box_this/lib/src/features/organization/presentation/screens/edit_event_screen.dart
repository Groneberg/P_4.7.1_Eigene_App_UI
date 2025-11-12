import 'dart:developer';

import 'package:box_this/src/common/widgets/custom_bottem_nav_bar.dart';
import 'package:box_this/src/common/widgets/custom_search_bar.dart';
import 'package:box_this/src/common/widgets/title_app_bar.dart';
import 'package:box_this/src/data/model/event.dart';
import 'package:box_this/src/data/repositories/shared_preferences_repository.dart';
import 'package:box_this/src/features/organization/presentation/screens/box_detail_screen.dart';
import 'package:box_this/src/features/organization/presentation/widgets/label_name.dart';

import 'package:box_this/src/theme/custom_extensions/gradients_extension.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';

class EditEventScreen extends StatefulWidget {
  final Event? event;
  final String? itemId;

  EditEventScreen({super.key, this.event, this.itemId});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  // final MockDatabaseRepository repository = MockDatabaseRepository();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final event = widget.event;
    if (event != null) {
      _nameController.text = event.name;
      _dateController.text = event.date;
      _itemNameController.text = event.time;
      _descriptionController.text = event.description;
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  DateTime? _parseCombinedDateTime() {
    try {
      final DateFormat format = DateFormat('dd.MM.yyyy HH:mm');
      //
      return format.parseStrict(
        '${_dateController.text} ${_itemNameController.text}',
      );
    } catch (e) {
      log("Fehler beim Parsen des Datums/Zeit: $e");
      return null;
    }
  }

  DateTime? _parseCombinedDateTimeFromWidget(Event? event) {
    if (event == null) return null;
    try {
      final DateFormat format = DateFormat('dd.MM.yyyy HH:mm');
      return format.parseStrict('${event.date} ${event.time}');
    } catch (e) {
      return null;
    }
  }

  // bool _showDatePicker = false;

  // bool _showTimePicker = false;

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //   );

  //   if (picked != null) {
  //     setState(() {
  //       _dateController.text = DateFormat('dd.MM.yyyy').format(picked);
  //     });
  //   }
  // }

  // Future<void> _selectTime(BuildContext context) async {
  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         backgroundColor: Colors.transparent,
  //         elevation: 0,
  //         child: ThemedTimePicker(
  //           onTimeSelected: (String timeString) {
  //             if (timeString.isNotEmpty) {
  //               setState(() {
  //                 _itemNameController.text = timeString;
  //               });
  //             }
  //           },
  //         ),
  //       );
  //     },
  //   );

  // }

  @override
  void dispose() {
    _descriptionController.dispose();
    _nameController.dispose();
    _dateController.dispose();
    _itemNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradients = Theme.of(context).extension<GradientsExtension>();

    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: TitleAppBar(
          title: "Edit Event",
          setBackIcon: true,
          icon: "event_icon",
        ),
        body: Center(
          child: Column(
            children: [
              CustomSearchBar(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      spacing: 24,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 48,
                              child: SvgPicture.asset(
                                "assets/svg/icons/event_icon.svg",
                                height: 34,
                                width: 30,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.onPrimary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.tertiary,
                                  ),
                                ),
                                child: TextFormField(
                                  controller: _nameController,
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  decoration: InputDecoration(
                                    hintText: "Eventname...",
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Name required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),

                        // --------------------
                        Row(
                          children: [
                            // TODO später optische anpassung
                            // TODO Datum aus der date picker nehmen
                            LabelName(labelName: "Date", labelWidth: 64),
                            SizedBox(width: 16),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.tertiary,
                                  ),
                                ),
                                child: TextFormField(
                                  controller: _dateController,
                                  // onTap: () {
                                  //   _selectDate(context);
                                  // },
                                  // readOnly: true,
                                  keyboardType: TextInputType.datetime,
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  decoration: InputDecoration(
                                    hintText: "01.01.2025",
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Date required';
                                    }
                                    try {
                                      DateFormat(
                                        'dd.MM.yyyy',
                                      ).parseStrict(value);
                                      return null;
                                    } catch (e) {
                                      return 'Format: TT.MM.JJJJ';
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            // TODO später optische anpassung
                            // TODO Zeit aus der time picker nehmen
                            LabelName(labelName: "Time", labelWidth: 64),
                            SizedBox(width: 16),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.tertiary,
                                  ),
                                ),
                                child: TextFormField(
                                  controller: _itemNameController,
                                  // onTap: () {
                                  //   _selectTime(context);
                                  // },
                                  // readOnly: true,
                                  keyboardType: TextInputType.datetime,
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  decoration: InputDecoration(
                                    hintText: "12:00",
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Time required';
                                    }
                                    try {
                                      DateFormat('HH:mm').parseStrict(value);
                                      return null;
                                    } catch (e) {
                                      return 'Format: HH:MM';
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),

                        // --------------------
                        Column(
                          children: [
                            LabelName(
                              labelName: "Description",
                              labelWidth: 200,
                            ),
                            SizedBox(height: 8),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4.0,
                                  horizontal: 8,
                                ),
                                child: TextFormField(
                                  controller: _descriptionController,
                                  maxLines: null,
                                  minLines: 3,
                                  keyboardType: TextInputType.multiline,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  decoration: InputDecoration(
                                    hintText: "Description...",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // CreateButton(),
              Consumer<SharedPreferencesRepository>(
                builder: (context, databaseRepository, child) =>
                    GestureDetector(
                      onTap: () {
                        updateEvent(context);
                      },
                      child: Container(
                        height: 48,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: gradients?.greenGradient,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Edit",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
                    ),
              ),
              CustomBottemNavBar(),
            ],
          ),
        ),
      ),
    );
  }

  void updateEvent(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      log("Form is invalid (format error)");
      return;
    }

    final DateTime? scheduledTime = _parseCombinedDateTime();

    if (scheduledTime == null) {
      _showErrorSnackBar(context, "Invalid date or time format.");
      return;
    }
    
    final DateTime checkTime = DateTime.now().subtract(const Duration(minutes: 1));

    final String originalTimeStr = _parseCombinedDateTimeFromWidget(widget.event)?.toString() ?? "";
    final String newTimeStr = scheduledTime.toString();

    if (scheduledTime.isBefore(checkTime) && (newTimeStr != originalTimeStr)) {
       log("Error: The selected time is in the past.");
       _showErrorSnackBar(context, "Error: The selected time is in the past.");
       return;
    }

    final databaseRepository = Provider.of<SharedPreferencesRepository>(
      context,
      listen: false,
    );

    final Event updatedEvent = Event(
      id: widget.event!.id, 
      parentId: widget.event!.parentId, 
      name: _nameController.text,
      date: _dateController.text,
      time: _itemNameController.text,
      description: _descriptionController.text,
    );

    if (widget.itemId != null) {
      databaseRepository.updateEventInItem(updatedEvent, widget.itemId!);
    } else {
      databaseRepository.updateEvent(updatedEvent);
    }

    Navigator.pop(context);
  }
}
