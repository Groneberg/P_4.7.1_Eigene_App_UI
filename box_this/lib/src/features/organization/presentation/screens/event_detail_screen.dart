import 'package:box_this/src/common/widgets/custom_bottem_nav_bar.dart';
import 'package:box_this/src/common/widgets/custom_search_bar.dart';
import 'package:box_this/src/common/widgets/title_app_bar.dart';
import 'package:box_this/src/data/model/event.dart';
import 'package:box_this/src/data/model/item.dart';
import 'package:box_this/src/data/repositories/shared_preferences_repository.dart';
import 'package:box_this/src/features/organization/presentation/screens/edit_event_screen.dart';
import 'package:box_this/src/features/organization/presentation/widgets/element_information.dart';
import 'package:box_this/src/features/organization/presentation/widgets/label_name.dart';
import 'package:box_this/src/features/organization/presentation/widgets/small_action_button.dart';
import 'package:box_this/src/features/organization/presentation/widgets/user_prompt_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventDetailScreen extends StatefulWidget {
  final Event event;

  const EventDetailScreen({super.key, required this.event});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  // @override
  // void dispose() {
  //   _amountController.dispose();
  //   _minAmountController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<SharedPreferencesRepository>(
      builder: (context, databaseRepository, child) {
        final Event? currentDisplayEvent = databaseRepository.mainBox.findEventById(
          widget.event.id,
        );

        if (currentDisplayEvent == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context);
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return SafeArea(
          top: true,
          bottom: true,
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.primary,
            appBar: TitleAppBar(
              title: currentDisplayEvent.name,
              setBackIcon: true,
              icon: "event_icon",
            ),
            body: Column(
              children: [
                CustomSearchBar(),
                SizedBox(height: 24),
                Expanded(
                  child: Column(
                    spacing: 24,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: LabelName(labelName: currentDisplayEvent.name, labelWidth: 64),
                      ),
                      ElementInformation(
                        description: currentDisplayEvent.description,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          children: [
                            LabelName(labelName: "Date", labelWidth: 64),
                            SizedBox(width: 16),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(right: 8),
                                child: Text(
                                  currentDisplayEvent.date,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          children: [
                            LabelName(labelName: "Time", labelWidth: 64),
                            SizedBox(width: 16),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(right: 8),
                                child: Text(
                                  currentDisplayEvent.time,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 88,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(width: 40),
                      SizedBox(width: 40),
                      SizedBox(width: 40),
                      SmallActionButton(
                        svgIconPath: "assets/svg/icons/edit_icon.svg",
                        onPressed: () {
                          navigateToEventEditScreen(context, currentDisplayEvent);
                        },
                      ),
                      SmallActionButton(
                        svgIconPath: "assets/svg/icons/delete_icon.svg",
                        onPressed: () async {
                          final bool didConfirmDelete =
                              await showDeleteConfirmationDialog(
                                context,
                                title: "Delete '${currentDisplayEvent.name}'?",
                              );

                          if (didConfirmDelete) {
                            if (!mounted) return;
                            Navigator.pop(context);

                            if (currentDisplayEvent.parentId != null) {
                               Item? parentItem = databaseRepository.mainBox.findItemById(currentDisplayEvent.parentId!);
                               
                               if (parentItem != null) {
                                 // Es gehört zu einem Item -> Spezielle Löschmethode nutzen
                                 databaseRepository.deleteEventInItem(currentDisplayEvent.id, parentItem.id);
                               } else {
                                 // Kein Item als Parent gefunden, versuche normale Löschung (Box)
                                 databaseRepository.deleteEvent(currentDisplayEvent.id);
                               }
                            } else {
                              // Kein Parent bekannt, Fallback auf Box-Löschung
                              databaseRepository.deleteEvent(currentDisplayEvent.id);
                            }
                          }
                            // databaseRepository.deleteEvent(currentDisplayEvent.id);
                          
                        
                        },
                      ),
                    ],
                  ),
                ),
                CustomBottemNavBar(),
              ],
            ),
          ),
        );
      },
    );
  }

  void navigateToEventEditScreen(BuildContext context, Event event) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) =>
            EditEventScreen(event: event),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      // // TODO navigation anpassen für Item und Event
      // MaterialPageRoute(builder: (context) => ItemDetailScreen(box: widget.element)),
    );
  }
}
