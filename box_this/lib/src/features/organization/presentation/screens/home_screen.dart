import 'package:box_this/src/common/widgets/custom_bottem_nav_bar.dart';
import 'package:box_this/src/common/widgets/custom_search_bar.dart';
import 'package:box_this/src/common/widgets/title_app_bar.dart';
import 'package:box_this/src/data/model/box.dart';
import 'package:box_this/src/data/repositories/shared_preferences_repository.dart';
import 'package:box_this/src/features/organization/presentation/screens/create_box_screen.dart';
import 'package:box_this/src/features/organization/presentation/widgets/button_create_box.dart';
import 'package:box_this/src/features/organization/presentation/widgets/list_element.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Box> _futureBoxes;

  @override
  void initState() {
    super.initState();
    _loadBoxes();
  }

  Future<void> _loadBoxes() async {
    setState(() {
      SharedPreferencesRepository.instance.initializePersistence();
      _futureBoxes = SharedPreferencesRepository.instance
          .readMainBoxStructure();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final SharedPreferencesRepository repository = SharedPreferencesRepository.instance;
    // final SharedPreferencesRepository repository = SharedPreferencesRepository.instance;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: TiTleAppBar(title: "Home", setBackIcon: false, icon: "home_icon"),
      body: Column(
        children: [
          CustomSearchBar(),
          // TODO später dynamisch und aus liste / akkordion
          Consumer<SharedPreferencesRepository>(
            builder: (context, databaseRepository, child) => Expanded(
              child: FutureBuilder(
                // future: databaseRepository.readMainBoxStructure(),
                future: _futureBoxes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.onPrimary,
                        strokeWidth: 8,
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: databaseRepository.mainBox.boxes.length,
                          itemBuilder: (context, index) {
                            String key = databaseRepository.mainBox.boxes.keys
                                .elementAt(index);
                            return ListElement(
                              element: databaseRepository.mainBox.boxes[key]!,
                              onDelete: () {
                                databaseRepository.deleteBox(key);
                                _loadBoxes();
                              },
                            );
                          },
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ButtonCreateBox(
                                onPressed: () {
                                  databaseRepository.currentBox = databaseRepository.mainBox;
                                  navigatetoCreateBoxScreen(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return const Text("No data available");
                  }
                },
              ),
            ),
          ),

          SizedBox(height: 90),
          CustomBottemNavBar(),
          // SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  void navigatetoCreateBoxScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) => CreateBoxScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      // MaterialPageRoute(
      //   builder: (context) => CreateBoxScreen(),
      // ),
    );
  }
}
