import 'package:box_this/src/common/widgets/custom_bottem_nav_bar.dart';
import 'package:box_this/src/common/widgets/custom_search_bar.dart';
import 'package:box_this/src/common/widgets/title_app_bar.dart';
import 'package:box_this/src/data/model/box.dart';
import 'package:box_this/src/data/repositories/database_repository.dart';
import 'package:box_this/src/data/repositories/mock_database_repository.dart';
import 'package:box_this/src/data/repositories/shared_preferences_repository.dart';
import 'package:box_this/src/features/organization/presentation/screens/create_box_screen.dart';
import 'package:box_this/src/features/organization/presentation/widgets/button_create_box.dart';
import 'package:box_this/src/features/organization/presentation/widgets/list_element.dart';
import 'package:flutter/material.dart';

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
      _futureBoxes = MockDatabaseRepository.instance.readMainBoxStructure();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final MockDatabaseRepository repository = MockDatabaseRepository.instance;
    // final SharedPreferencesRepository repository = SharedPreferencesRepository.instance;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: TiTleAppBar(title: "Home", setBackIcon: false, icon: "home_icon"),
      body: Column(
        children: [
          CustomSearchBar(),
          // TODO später dynamisch und aus liste / akkordion
          Expanded(
            child: FutureBuilder(
              future: MockDatabaseRepository.instance.readMainBoxStructure(),
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
                        itemCount: MockDatabaseRepository
                            .instance
                            .mainBox
                            .boxes
                            .length,
                        itemBuilder: (context, index) {
                          String key = MockDatabaseRepository
                              .instance
                              .mainBox
                              .boxes
                              .keys
                              .elementAt(index);
                          return ListElement(
                            element: MockDatabaseRepository
                                .instance
                                .mainBox
                                .boxes[key]!,
                            onDelete: () {
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
      MaterialPageRoute(
        builder: (context) => CreateBoxScreen(),
      ),
    );
  }
}
